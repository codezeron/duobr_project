import 'package:duobr_project/presentation/stores/auth_store.dart';
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

  // // Usecases
  // getIt.registerSingleton<LoginUsecase>(LoginUsecase(getIt<AuthRepository>()));

  // // Stores
  // getIt.registerSingleton<AuthStore>(AuthStore(getIt<LoginUsecase>()));
}
