import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duobr_project/data/datasources/player_remote_datasource.dart';
import 'package:duobr_project/data/services/chat_service.dart';
import 'package:duobr_project/data/services/match_service.dart';
import 'package:duobr_project/domain/repositories/player_repository.dart';
import 'package:duobr_project/domain/repositories/player_repository_impl.dart';
import 'package:duobr_project/domain/usecases/get_available_players.dart';
import 'package:duobr_project/presentation/stores/auth_store.dart';
import 'package:duobr_project/presentation/stores/chat_store.dart';
import 'package:duobr_project/presentation/stores/home_store.dart';
import 'package:duobr_project/presentation/stores/match_store.dart';
import 'package:duobr_project/presentation/stores/theme_store.dart';
import 'package:get_it/get_it.dart';
import 'package:duobr_project/data/datasources/auth_datasource.dart';

final GetIt getIt = GetIt.instance;

void setupDependencies() {
  // Datasources
  getIt.registerSingleton<ThemeStore>(ThemeStore());
  getIt.registerSingleton<AuthDatasource>(AuthDatasource());
  getIt.registerSingleton<AuthStore>(AuthStore());
  // // Repositories
  // getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl(getIt<AuthDatasource>()));

  getIt.registerLazySingleton(() => FirebaseFirestore.instance);
  getIt.registerLazySingleton<PlayerRemoteDataSource>(() => PlayerRemoteDataSourceImpl(getIt()));
  getIt.registerLazySingleton<PlayerRepository>(() => PlayerRepositoryImpl(FirebaseFirestore.instance));
  getIt.registerLazySingleton(() => PlayerRepositoryImpl(FirebaseFirestore.instance));
  getIt.registerLazySingleton<GetAvailablePlayers>(() => GetAvailablePlayers(getIt()));
  getIt.registerFactory<HomeStore>(() => HomeStore(getIt<GetAvailablePlayers>()));
  getIt.registerLazySingleton(() => ChatStore(getIt<ChatService>()));
  getIt.registerLazySingleton(() => ChatService());
  getIt.registerLazySingleton(() => MatchStore(getIt<MatchService>()));
  getIt.registerLazySingleton(() => MatchService());
  // // Usecases
  // getIt.registerSingleton<LoginUsecase>(LoginUsecase(getIt<AuthRepository>()));

  // // Stores
  // getIt.registerSingleton<AuthStore>(AuthStore(getIt<LoginUsecase>()));
}
