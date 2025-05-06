import 'package:cloud_firestore/cloud_firestore.dart';

class MatchService {
  final _firestore = FirebaseFirestore.instance;

  Future<void> likeUser({required String currentUserId, required String likedUserId}) async {
    final docRef = _firestore.collection('likes').doc('$currentUserId\_$likedUserId');

    await docRef.set({'from': currentUserId, 'to': likedUserId});

    final reverseLike = await _firestore.collection('likes').doc('$likedUserId\_$currentUserId').get();

    if (reverseLike.exists) {
      // Criar o chat se houve match
      await _firestore.collection('matches').doc().set({
        'userIds': [currentUserId, likedUserId],
        'matchedAt': DateTime.now(),
      });
    }
  }

  Future<List<String>> getMatchedUserIds(String userId) async {
    final snapshot = await _firestore.collection('matches').where('userIds', arrayContains: userId).get();

    final matches = snapshot.docs.map((doc) => List<String>.from(doc['userIds'])).toList();

    return matches.map((list) => list.firstWhere((id) => id != userId)).toList();
  }
}
