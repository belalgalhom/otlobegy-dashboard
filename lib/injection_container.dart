import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:otlob_admin/core/api/token_interceptor.dart';
import 'package:otlob_api/otlob_api.dart';
import 'package:otlob_admin/features/auth/data/auth_repository.dart';
import 'package:otlob_admin/features/auth/presentation/auth_bloc.dart';
import 'package:otlob_admin/features/vendors/data/vendor_repository.dart';
import 'package:otlob_admin/features/vendors/presentation/vendor_bloc.dart';
import 'package:otlob_admin/features/vendors/presentation/vertical_bloc.dart';
import 'package:otlob_admin/features/users/data/users_repository.dart';
import 'package:otlob_admin/features/users/presentation/user_bloc.dart';
import 'package:otlob_admin/features/zones/data/zones_repository.dart';
import 'package:otlob_admin/features/zones/presentation/zone_bloc.dart';
import 'package:otlob_admin/core/localization/language_cubit.dart';
import 'package:otlob_admin/core/theme/theme_cubit.dart';
import 'package:otlob_admin/features/settings/data/settings_repository.dart';
import 'package:otlob_admin/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:otlob_admin/features/promotions/presentation/promotion_bloc.dart';
import 'package:otlob_admin/features/chat/data/chat_repository.dart';
import 'package:otlob_admin/features/chat/presentation/chat_bloc.dart';
import 'package:otlob_admin/features/tickets/data/ticket_repository.dart';
import 'package:otlob_admin/features/tickets/presentation/ticket_bloc.dart';
import 'package:otlob_admin/core/services/socket_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  sl.registerLazySingleton(() => SocketService());
  sl.registerLazySingleton(() {
    final dio = Dio();
    dio.options.baseUrl = 'https://api.otlob-egy.online';
    dio.options.connectTimeout = const Duration(seconds: 15);
    dio.options.receiveTimeout = const Duration(seconds: 15);
    
    dio.interceptors.add(TokenInterceptor(sl(), dio));
    return OtlobApi(dio: dio, basePathOverride: 'https://api.otlob-egy.online');
  });

  // Repositories
  sl.registerLazySingleton(() => AuthRepository(sl(), sl()));
  sl.registerLazySingleton(() => VendorRepository(sl()));
  sl.registerLazySingleton(() => UsersRepository(sl()));
  sl.registerLazySingleton(() => ZonesRepository(sl()));
  sl.registerLazySingleton(() => SettingsRepository(sl()));
  sl.registerLazySingleton(() => ChatRepository(sl()));
  sl.registerLazySingleton(() => TicketRepository(sl()));

  // Blocs
  sl.registerFactory(() => AuthBloc(sl()));
  sl.registerFactory(() => VendorBloc(sl()));
  sl.registerFactory(() => UserBloc(sl()));
  sl.registerFactory(() => ZoneBloc(sl()));
  sl.registerFactory(() => VerticalBloc(sl()));
  sl.registerFactory(() => SettingsBloc(sl()));
  sl.registerFactory(() => PromotionBloc(sl()));
  sl.registerFactory(() => ChatBloc(sl()));
  sl.registerFactory(() => TicketBloc(sl()));
  sl.registerLazySingleton(() => LanguageCubit(sl()));
  sl.registerLazySingleton(() => ThemeCubit(sl()));
}
