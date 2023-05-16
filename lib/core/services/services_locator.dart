import 'package:get_it/get_it.dart';

import '../../Authentication/data/datasource/authentication_remote_data_source.dart';
import '../../Authentication/data/repository/authentication_repository.dart';
import '../../Authentication/domain/repository/base_authentication_repository.dart';
import '../../Authentication/domain/usecase/get_user_details_usecase.dart';
import '../../Authentication/domain/usecase/login_usecase.dart';
import '../../Authentication/domain/usecase/logout_usecase.dart';
import '../../Authentication/domain/usecase/registration_usecase.dart';
import '../../Authentication/presentation/controller/authentication_bloc.dart';

import '../../TourismPlaces/data/datasource/tourism_place_remote_data_source.dart';
import '../../TourismPlaces/data/repository/tourism_place_repository.dart';
import '../../TourismPlaces/domain/repository/base_tourism_place_repository.dart';
import '../../TourismPlaces/domain/usecase/get_tourism_place_usecase.dart';
import '../../TourismPlaces/presentation/controller/tourism_place_bloc.dart';
import '../../hotels/data/datasource/hotel_remote_data_source.dart';
import '../../hotels/data/repository/hotel_repository.dart';
import '../../hotels/domain/repository/base_hotel_repository.dart';
import '../../hotels/domain/usecase/get_hotel_usecase.dart';
import '../../hotels/presentation/controller/hotels_bloc.dart';
import '../local_data_shared_preferences/access_token_shared_preferences.dart';

final getIt = GetIt.instance;

class ServicesLocator {
  void init() {
/* ****** Authentication  ServicesLocator ****** */

    /* ****** Access Token ****** */
    getIt.registerLazySingleton(() => AccessToken());

    /* ****** GetUserDetails ****** */
    /// Bloc
    getIt.registerFactory(() => AuthenticationBloc(
          getIt(),
          getIt(),
          getIt(),
          getIt(),
        ));

    /// Use Cases
    getIt.registerLazySingleton(() => GetUserDetailsUsecase(getIt()));

    /// Repository
    getIt.registerLazySingleton<BaseAuthenticationRepository>(
        () => AuthenticationRerpository(getIt()));

    /// Data Source
    getIt.registerLazySingleton<BaseAuthenticationRemoteDataSource>(
        () => AuthenticationRemoteDataSource());

    /* ****** Registration ****** */
    /// Use Cases
    getIt.registerLazySingleton(() => RegisterationUsecase(getIt()));

    /* ****** Login ****** */
    /// Use Cases
    getIt.registerLazySingleton(() => LoginUsecase(getIt()));
    /* ****** Logout ****** */
    /// Use Cases
    getIt.registerLazySingleton(() => LogoutUsecase(getIt()));

/* ****** Hotel ServicesLocator ****** */
    /// Bloc
    getIt.registerFactory(() => HotelsBloc(getIt()));

    /// Use Cases
    getIt.registerLazySingleton(() => GetHotelUsecase(getIt()));

    /// Repository
    getIt.registerLazySingleton<BaseHotelRepository>(
        () => HotelRerpository(getIt()));

    /// DATA SOURCE
    getIt.registerLazySingleton<BaseHotelRemoteDataSource>(
        () => HotelRemoteDataSource());

/* ****** Tourism Places ServicesLocator ****** */
    /// Bloc
    getIt.registerFactory(() => TourismPlaceBloc(getIt()));

    /// Use Cases
    getIt.registerLazySingleton(() => GetTourismPlaceUsecase(getIt()));

    /// Repository
    getIt.registerLazySingleton<BaseTourismPlaceRepository>(
        () => TourismPlaceRerpository(getIt()));

    /// DATA SOURCE
    getIt.registerLazySingleton<BaseTourismPlaceRemoteDataSource>(
        () => TourismPlaceRemoteDataSource());
  }
}
