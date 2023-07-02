import 'package:fayoumtour/TourismPlaces/domain/usecase/rateUsecases/get_place_rate_by_user.dart';
import 'package:fayoumtour/hotels/domain/usecase/hotel_reservation/get_hotel_usecase_by_user.dart';
import 'package:fayoumtour/hotels/domain/usecase/rateUsecases/get_hotel_rate_by_user_usecase.dart';
import 'package:get_it/get_it.dart';

import '../../Authentication/data/datasource/authentication_remote_data_source.dart';
import '../../Authentication/data/repository/authentication_repository.dart';
import '../../Authentication/domain/repository/base_authentication_repository.dart';
import '../../Authentication/domain/usecase/change_password_usecase.dart';
import '../../Authentication/domain/usecase/get_user_details_usecase.dart';
import '../../Authentication/domain/usecase/login_usecase.dart';
import '../../Authentication/domain/usecase/logout_usecase.dart';
import '../../Authentication/domain/usecase/registration_usecase.dart';
import '../../Authentication/domain/usecase/reset_password_confirm_usecase.dart';
import '../../Authentication/domain/usecase/reset_password_usecase.dart';
import '../../Authentication/domain/usecase/update_user_details_usecase.dart';
import '../../Authentication/presentation/controller/authentication_bloc.dart';

import '../../TourismPlaces/data/datasource/tourism_place_remote_data_source.dart';
import '../../TourismPlaces/data/repository/tourism_place_repository.dart';
import '../../TourismPlaces/domain/repository/base_tourism_place_repository.dart';
import '../../TourismPlaces/domain/usecase/add_tourism_place_usecase.dart';
import '../../TourismPlaces/domain/usecase/delete_tourism_place_usecase.dart';
import '../../TourismPlaces/domain/usecase/favorite/get_place_favorite_usecase.dart';
import '../../TourismPlaces/domain/usecase/favorite/update_or_create_tourism_place_favorite_usecase.dart';
import '../../TourismPlaces/domain/usecase/get_tourism_place_by_id_usecase.dart';
import '../../TourismPlaces/domain/usecase/get_tourism_place_usecase.dart';
import '../../TourismPlaces/domain/usecase/model1_usecase.dart';
import '../../TourismPlaces/domain/usecase/ordering_by_fields.dart';
import '../../TourismPlaces/domain/usecase/rateUsecases/get_all_tourism_place_rate_usecase.dart';
import '../../TourismPlaces/domain/usecase/rateUsecases/get_tourism_place_rate_by_id_usecase.dart';
import '../../TourismPlaces/domain/usecase/rateUsecases/update_or_create_tourism_place_rate.dart';
import '../../TourismPlaces/domain/usecase/search_by_fields_usecase.dart';
import '../../TourismPlaces/domain/usecase/search_by_rate_usecase.dart';
import '../../TourismPlaces/domain/usecase/update_tourism_place_usecase.dart';
import '../../TourismPlaces/presentation/controller/tourism_place_bloc.dart';
import '../../hotels/data/datasource/hotel_remote_data_source.dart';
import '../../hotels/data/repository/hotel_repository.dart';
import '../../hotels/domain/repository/base_hotel_repository.dart';
import '../../hotels/domain/usecase/add_hotel_usecase.dart';
import '../../hotels/domain/usecase/delete_hotel_usecase.dart';
import '../../hotels/domain/usecase/favorite/get_hotel_favorite_usecase.dart';
import '../../hotels/domain/usecase/favorite/update_or_create_hotel_favorite_usecase.dart';
import '../../hotels/domain/usecase/get_hotel_by_id_usecase.dart';
import '../../hotels/domain/usecase/get_hotel_usecase.dart';
import '../../hotels/domain/usecase/hotel_reservation/add_hotel_usecase.dart';
import '../../hotels/domain/usecase/hotel_reservation/delete_hotel_usecase.dart';
import '../../hotels/domain/usecase/hotel_reservation/get_hotel_usecase.dart';
import '../../hotels/domain/usecase/hotel_reservation/update_hotel_usecase.dart';
import '../../hotels/domain/usecase/ordering_by_fields.dart';
import '../../hotels/domain/usecase/rateUsecases/get_all_hotel_rate_usecase.dart';
import '../../hotels/domain/usecase/rateUsecases/get_hotel_rate_by_id_usecase.dart';
import '../../hotels/domain/usecase/rateUsecases/update_or_create_hotel_rate.dart';
import '../../hotels/domain/usecase/search_by_fields_usecase.dart';
import '../../hotels/domain/usecase/search_by_rate_usecase.dart';
import '../../hotels/domain/usecase/update_hotel_usecase.dart';
import '../../hotels/presentation/controller/hotels_bloc.dart';
import '../../post/data/datasource/post_remote_data_source.dart';
import '../../post/data/repository/post_repository.dart';
import '../../post/domain/repository/base_post_repository.dart';
import '../../post/domain/usecase/add_post_usecase.dart';
import '../../post/domain/usecase/comment/add_comment_usecase.dart';
import '../../post/domain/usecase/comment/delete_comment_usecase.dart';
import '../../post/domain/usecase/comment/get_comment_usecase.dart';
import '../../post/domain/usecase/comment/update_comment_usecase.dart';
import '../../post/domain/usecase/delete_post_usecase.dart';
import '../../post/domain/usecase/get_post_by_id_usecase.dart';
import '../../post/domain/usecase/get_post_usecase.dart';
import '../../post/domain/usecase/like/add_like.dart';
import '../../post/domain/usecase/like/get_like.dart';
import '../../post/domain/usecase/update_post_usecase.dart';
import '../../post/presentation/controller/bloc/post_bloc.dart';
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
          getIt(),
          getIt(),
          getIt(),
          getIt(),
        ));

    /// Repository
    getIt.registerLazySingleton<BaseAuthenticationRepository>(
        () => AuthenticationRerpository(getIt()));

    /// Data Source
    getIt.registerLazySingleton<BaseAuthenticationRemoteDataSource>(
        () => AuthenticationRemoteDataSource());

    /// Use Cases
    /* ****** UserDetails ****** */
    getIt.registerLazySingleton(() => GetUserDetailsUsecase(getIt()));

    /* ****** Registration ****** */
    getIt.registerLazySingleton(() => RegisterationUsecase(getIt()));

    /* ****** Login ****** */
    getIt.registerLazySingleton(() => LoginUsecase(getIt()));

    /* ****** ChangePassword ****** */
    getIt.registerLazySingleton(() => ChangePasswordUsecase(getIt()));
    /* ****** UpdateUserDetails ****** */
    getIt.registerLazySingleton(() => UpdateUserDetailsUsecase(getIt()));
    /* ****** ResetPassword ****** */
    getIt.registerLazySingleton(() => ResetPasswordUsecase(getIt()));
    /* ****** ResetPasswordConfirm ****** */
    getIt.registerLazySingleton(() => ResetPasswordConfirmUsecase(getIt()));

    /* ****** Logout ****** */
    getIt.registerLazySingleton(() => LogoutUsecase(getIt()));

/* ****** Hotel ServicesLocator ****** */
    /// Bloc
    getIt.registerFactory(() => HotelsBloc(
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt()));

    /// Use Cases
    getIt.registerLazySingleton(() => GetHotelUsecase(getIt()));
    getIt.registerLazySingleton(() => GetHotelByIdUsecase(getIt()));
    getIt.registerLazySingleton(() => AddHotelUsecase(getIt()));
    getIt.registerLazySingleton(() => UpdateHotelUsecase(getIt()));
    getIt.registerLazySingleton(() => DeleteHotelUsecase(getIt()));
    getIt.registerLazySingleton(() => SearchByFieldsHotelUsecase(getIt()));
    getIt.registerLazySingleton(() => OrderingHotelByFieldsUsecase(getIt()));
    getIt.registerLazySingleton(() => SearchHotelByRateUsecase(getIt()));
    getIt.registerLazySingleton(() => GetHotelRateUsecase(getIt()));
    getIt.registerLazySingleton(() => GetHotelRateByIdUsecase(getIt()));
    getIt.registerLazySingleton(() => UpdateCreateHotelRateUsecase(getIt()));
    getIt.registerLazySingleton(() => GetHotelRateByUserUsecase(getIt()));
    getIt
        .registerLazySingleton(() => UpdateCreateHotelFavoriteUsecase(getIt()));
    getIt.registerLazySingleton(() => GetHotelFavoriteUsecase(getIt()));
    // HotelReservation
    getIt.registerLazySingleton(() => GetHotelReservationUsecase(getIt()));
    getIt
        .registerLazySingleton(() => GetHotelReservationByUserUsecase(getIt()));
    getIt.registerLazySingleton(() => AddHotelReservationUsecase(getIt()));
    getIt.registerLazySingleton(() => UpdateHotelReservationUsecase(getIt()));
    getIt.registerLazySingleton(() => DeleteHotelReservationUsecase(getIt()));

    /// Repository
    getIt.registerLazySingleton<BaseHotelRepository>(
        () => HotelRerpository(getIt()));

    /// DATA SOURCE
    getIt.registerLazySingleton<BaseHotelRemoteDataSource>(
        () => HotelRemoteDataSource());

/* ****** Tourism Places ServicesLocator ****** */
    /// Bloc
    getIt.registerFactory(() => TourismPlaceBloc(
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt()));

    /// Use Cases
    getIt.registerLazySingleton(() => GetTourismPlaceUsecase(getIt()));
    getIt.registerLazySingleton(() => GetTourismPlaceByIdUsecase(getIt()));
    getIt.registerLazySingleton(() => AddTourismPlaceUsecase(getIt()));
    getIt.registerLazySingleton(() => UpdateTourismPlaceUsecase(getIt()));
    getIt.registerLazySingleton(() => DeleteTourismPlaceUsecase(getIt()));
    //Model1Usecase
    getIt.registerLazySingleton(() => Model1Usecase(getIt()));
    getIt.registerLazySingleton(
        () => SearchByFieldsTourismPlaceUsecase(getIt()));
    getIt.registerLazySingleton(() => SearchTourismPlaceByRateUsecase(getIt()));
    getIt.registerLazySingleton(
        () => OrderingTourismPlaceByFieldsUsecase(getIt()));
    getIt.registerLazySingleton(() => GetTourismPlaceRateUsecase(getIt()));
    getIt.registerLazySingleton(() => GetTourismPlaceRateByIdUsecase(getIt()));
    getIt.registerLazySingleton(
        () => UpdateCreateTourismPlaceRateUsecase(getIt()));
    getIt
        .registerLazySingleton(() => GetTourismPlaceRateByUserUsecase(getIt()));

    getIt.registerLazySingleton(
        () => UpdateCreateTourismPlaceFavoriteUsecase(getIt()));
    getIt.registerLazySingleton(() => GetTourismPlaceFavoriteUsecase(getIt()));

    /// Repository
    getIt.registerLazySingleton<BaseTourismPlaceRepository>(
        () => TourismPlaceRerpository(getIt()));

    /// DATA SOURCE
    getIt.registerLazySingleton<BaseTourismPlaceRemoteDataSource>(
        () => TourismPlaceRemoteDataSource());

    /* ****** Posts ServicesLocator ****** */
    /// Bloc
    getIt.registerFactory(() => PostBloc(getIt(), getIt(), getIt(), getIt(),
        getIt(), getIt(), getIt(), getIt(), getIt(), getIt(), getIt()));

    /// Use Cases
    getIt.registerLazySingleton(() => GetPostUsecase(getIt()));
    getIt.registerLazySingleton(() => GetPostByIdUsecase(getIt()));

    getIt.registerLazySingleton(() => AddPostUsecase(getIt()));
    getIt.registerLazySingleton(() => UpdatePostUsecase(getIt()));
    getIt.registerLazySingleton(() => DeletePostUsecase(getIt()));
    // Comment
    getIt.registerLazySingleton(() => GetCommentUsecase(getIt()));
    getIt.registerLazySingleton(() => AddCommentUsecase(getIt()));
    getIt.registerLazySingleton(() => UpdateCommentUsecase(getIt()));
    getIt.registerLazySingleton(() => DeleteCommentUsecase(getIt()));

    // Like
    getIt.registerLazySingleton(() => GetLikeUsecase(getIt()));
    getIt.registerLazySingleton(() => AddLikeUsecase(getIt()));

    // getIt.registerLazySingleton(() => SearchByFieldsPostUsecase(getIt()));
    // getIt.registerLazySingleton(() => OrderingPostByFieldsUsecase(getIt()));

    /// Repository
    getIt.registerLazySingleton<BasePostRepository>(
        () => PostRerpository(getIt()));

    /// DATA SOURCE
    getIt.registerLazySingleton<BasePostRemoteDataSource>(
        () => PostRemoteDataSource());
  }
}
