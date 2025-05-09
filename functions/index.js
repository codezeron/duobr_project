import { initializeApp } from 'firebase-admin/app';
import { getFirestore } from 'firebase-admin/firestore';
import { getMessaging } from 'firebase-admin/messaging';
import { onDocumentCreated } from 'firebase-functions/v2/firestore';

initializeApp();

const db = getFirestore();
const messaging = getMessaging();

export const sendMessageNotification = onDocumentCreated(
  {
    region: 'us-central1',
    document: 'chats/{chatId}/messages/{messageId}',
  },
  async (event) => {
    const message = event.data?.data();
    const chatId = event.params.chatId;

    if (!message) return;

    const senderId = message.senderId;
    const content = message.content;

    const chatDoc = await db.collection('chats').doc(chatId).get();
    const userIds = chatDoc.data()?.userIds || [];

    const receiverId = userIds.find((id) => id !== senderId);
    if (!receiverId) return;

    const userDoc = await db.collection('users').doc(receiverId).get();
    const token = userDoc.data()?.fcmToken;

    if (!token) {
      console.log(`Usuário ${receiverId} não tem token FCM.`);
      return;
    }

    const payload = {
      token,
      notification: {
        title: 'Nova mensagem',
        body: content,
      },
      data: {
        chatId,
        senderId,
        type: 'chat',
      },
    };

    await messaging.send(payload);
    console.log(`Notificação enviada para ${receiverId}`);
  }
);
