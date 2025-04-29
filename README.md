# duobr_project
## Duobr Project
O Duobr Project é um aplicativo de mensagens instantâneas desenvolvido em Flutter, utilizando Firebase como backend. O projeto tem como objetivo fornecer uma experiência de chat simples e eficiente, com funcionalidades como autenticação, envio de mensagens e notificações.
Uma das principais características do projeto é a utilização do padrão de arquitetura Clean Architecture, que separa as responsabilidades em diferentes camadas, facilitando a manutenção e escalabilidade do código.(Tinder para gamers e streamers)

## Funcionalidades

- Autenticação de usuários com Google Sign-In
- Envio e recebimento de mensagens em tempo real
- Armazenamento de mensagens no Firestore
- Notificações locais para mensagens recebidas
- Interface amigável e responsiva
- Gerenciamento de estado com MobX
- Injeção de dependência com GetIt

### Instalação do projeto

```bash
git clone

cd duobr_project

flutter pub get
```
### Configuração do Firebase
1. Crie um projeto no Firebase Console.
2. Adicione um aplicativo Android e iOS ao projeto.
3. Baixe o arquivo `google-services.json` para Android e `GoogleService-Info.plist` para iOS.
4. Coloque o arquivo `google-services.json` na pasta `android/app/` e o arquivo `GoogleService-Info.plist` na pasta `ios/Runner/`.
5. No Android, adicione o plugin do Google Services no arquivo `android/app/build.gradle`:
```groovy
apply plugin: 'com.google.gms.google-services'
```

### Tecnologias utilizadas
- [Flutter](https://flutter.dev/)
- [Firebase](https://firebase.google.com/) (Auth, Firestore, Storage)
- [MobX](https://mobx.pub/) (Gerenciamento de estado)
- [GetIt](https://pub.dev/packages/get_it) (Injeção de dependência)
- [Google Sign-In](https://pub.dev/packages/google_sign_in) (Autenticação com Google)
- [Flutter Local Notifications](https://pub.dev/packages/flutter_local_notifications) (Notificações locais)


flutter build runner:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Configuração do projeto

### Estrutura de pastas

```bash
lib/
├── core/                  # Funcionalidades globais
│   ├── constants/         # Constantes (cores, strings)
│   ├── errors/            # Erros customizados
│   ├── network/           # Configuração de rede (Firebase)
│   ├── routes/            # Rotas nomeadas
│   ├── theme/             # Temas (cores, fontes)
│   └── utils/             # Helpers (validators, extensions)
│
├── data/                  # Camada de Dados
│   ├── datasources/       # Fontes de dados (Firebase, APIs)
│   ├── models/            # Modelos (DTOs)
│   └── repositories/      # Implementação dos repositórios
│
├── domain/                # Regras de Negócio
│   ├── entities/          # Entidades (objetos puros)
│   ├── repositories/      # Contratos (interfaces)
│   └── usecases/          # Casos de uso
│
└── presentation/          # Camada de UI
    ├── pages/             # Telas (auth, home, chat)
    ├── stores/            # Stores do MobX
    ├── widgets/           # Componentes reutilizáveis
```

