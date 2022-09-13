import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_hostel/constants.dart';
import 'package:the_hostel/models/appartment_model.dart';
import 'package:the_hostel/models/booking_model.dart';
import 'package:the_hostel/models/review_model.dart';
import 'package:the_hostel/models/transportation_model.dart';
import 'package:the_hostel/services/auth_service.dart';
import 'package:the_hostel/services/booking_service.dart';
import 'package:the_hostel/services/favourite_service.dart';
import 'package:the_hostel/services/home_service.dart';
import 'package:the_hostel/services/local/cache_helper.dart';
import 'package:the_hostel/services/transportation_service.dart';
import 'package:the_hostel/view_models/home_cubit/state.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeStates());

  static HomeCubit get(context) => BlocProvider.of(context);
  final AuthService _authService = AuthService();
  final HomeService _homeService = HomeService();
  final BookingService _bookingService = BookingService();
  final FavouriteService _favouriteService = FavouriteService();
  final TransportationService _transportationService = TransportationService();

  List<AppartmentModel> recommendApartments = [];
  List<AppartmentModel> allApartments = [];
  List<AppartmentModel> nearestApartments = [];
  Map<String, bool> favouriteApartments = {};
  Map<String, List<ReviewModel>> reviewsApartments = {};
  TransportationModel dailyModel = TransportationModel.instance();
  TransportationModel weeklyModel = TransportationModel.instance();
  ApartmentBooking? booking;
  String? governoment, universty;

  getUser() async {
    emit(GetHomeUserLoadingState());
    var uid = await CacheHelper.getData(key: "uid");
    await _authService.getUser(uid: uid).then((value) {
      getBooking();
      emit(GetHomeUserSuccessState());
    }).then((value) {
      getFavouriteApartments();
    }).then((value) {
      getAllApartments();
    }).then((value) {
      getNearestApartments();
    }).then((value) {
      getRecommendApartments();
    }).then((value) {
      getDailyTransportationModel();
    }).then((value) {
      getWeeklyTransportationModel();
    });
  }

  getAllApartments() {
    reviewsApartments = {};
    allApartments = [];
    emit(GetAllApartmentsLoadingState());
    _homeService.getAllApartments().then((value) {
      for (var apartment in value.docs) {
        _homeService
            .getReviews(
                apartmentModel: AppartmentModel.fromJson(apartment.data()))
            .then((value) {
          print(value.length);
          reviewsApartments.addAll(
              {AppartmentModel.fromJson(apartment.data()).apUid!: value});
          emit(GetAllApartmentsSuccessState());
        });
        allApartments.add(AppartmentModel.fromJson(apartment.data()));
        emit(GetAllApartmentsSuccessState());
      }
    }).catchError((error) {
      emit(GetAllApartmentsErrorState());
    });
  }

  getFilterdApartment(
    Rent type,
  ) {
    if (type == Rent.appartment) {
      allApartments =
          allApartments.where((element) => element.booked == 0).toList();
      print(allApartments.length);
      emit(OnChangeHomeState());
    } else if (type == Rent.room) {
      allApartments = allApartments
          .where((element) =>
              element.booked! < element.capacity! &&
              element.booked! >= element.bedPerRoom!)
          .toList();
      print(allApartments.length);
      emit(OnChangeHomeState());
    } else {
      allApartments = allApartments
          .where((element) => element.booked! < element.capacity!)
          .toList();
      emit(OnChangeHomeState());
    }
  }

  searchApartment(String? value) {
    allApartments = allApartments
        .where((element) => element.name!.toLowerCase().startsWith(value!))
        .toList();
    emit(OnChangeHomeState());
  }

  getBooking() {
    _bookingService.getBooking().then((value) {
      if (value.data() != null) {
        booking = ApartmentBooking.fromJson(value.data()!);
        emit(OnChangeHomeState());
      }
    }).catchError((error) {});
  }

  getRecommendApartments() {
    recommendApartments = [];
    emit(GetHomeRecommendLoadingState());
    _homeService.getRecommendApartment().then((value) {
      if (value.docs.isEmpty) {
        emit(GetHomeRecommendSuccessState());
      }
      for (var apartment in value.docs) {
        recommendApartments.add(AppartmentModel.fromJson(apartment.data()));
        emit(GetHomeRecommendSuccessState());
      }
    });
  }

  getNearestApartments() {
    nearestApartments = [];
    emit(GetHomeNearestLoadingState());
    _homeService.getStayWithUsApartment().then((value) {
      if (value.docs.isEmpty) {
        emit(GetHomeNearestSuccessState());
      }
      for (var apartment in value.docs) {
        nearestApartments.add(AppartmentModel.fromJson(apartment.data()));
        emit(GetHomeNearestSuccessState());
      }
    });
  }

  getFavouriteApartments() {
    emit(GetHomeFavouriteLoadingState());
    _favouriteService.getFavouriteApartments().listen((value) {
      favouriteApartments.clear();
      if (value.docs.isEmpty) {
        emit(GetHomeFavouriteSuccessState());
      } else {
        for (var apartment in value.docs) {
          favouriteApartments.addAll(
              {AppartmentModel.fromJson(apartment.data()).apUid!: true});
          print(favouriteApartments.length);
          emit(GetHomeFavouriteSuccessState());
        }
      }
    });
  }

  getDailyTransportationModel() {
    emit(GetDailyTranspLoadingState());
    _transportationService
        .getTransportation(Transportation.daily)
        .then((value) {
      if (value.docs.isNotEmpty) {
        dailyModel = TransportationModel.fromJson(value.docs.first.data());
        _transportationService
            .getVotedNumber(name: dailyModel.to!)
            .then((value) {
          dailyModel.voted = value.toString();
        });
        emit(GetDailyTranspSuccessState());
      } else {
        dailyModel = TransportationModel(
          from: userModel!.universty ?? "Universty",
          to: booking != null
              ? booking!.appartmentModel!.name
              : "The Hostel Home",
          minNumber: "?",
          transportationType: Transportation.daily,
          voted: "?",
        );
        emit(GetDailyTranspSuccessState());
      }
    }).catchError((error) {
      print(error.toString());
      emit(GetDailyTranspErrorState());
    });
  }

  getWeeklyTransportationModel() {
    emit(GetWeeklyTranspLoadingState());
    _transportationService
        .getTransportation(Transportation.weekly)
        .then((value) {
      if (value.docs.isNotEmpty) {
        weeklyModel = TransportationModel.fromJson(value.docs.first.data());
        _transportationService
            .getVotedNumber(name: weeklyModel.to!)
            .then((value) {
          weeklyModel.voted = value.toString();
        });
        emit(GetWeeklyTranspSuccessState());
      } else {
        weeklyModel = TransportationModel(
          from: userModel!.government ?? "Govenoment",
          to: "Badr City",
          minNumber: "?",
          transportationType: Transportation.weekly,
          voted: "?",
        );
        emit(GetWeeklyTranspSuccessState());
      }
    }).catchError((error) {
      print(error.toString());
      emit(GetWeeklyTranspErrorState());
    });
  }

  onChooseGovernoment(value) {
    governoment = value;
    emit(OnChangeHomeState());
  }

  onChooseUniversty(value) {
    universty = value;
    emit(OnChangeHomeState());
  }

  updateGovernoment() {
    emit(UpdateTranspLoadingState());
    _transportationService.updateGovernoment(governoment!).then((value) {
      getUser();
      emit(UpdateTranspSuccessState());
    }).catchError((error) {
      emit(UpdateTranspErrorState());
    });
  }

  updateUniversty() {
    emit(UpdateTranspLoadingState());
    _transportationService.updateUniversty(universty!).then((value) {
      getUser();
      emit(UpdateTranspSuccessState());
    }).catchError((error) {
      emit(UpdateTranspErrorState());
    });
  }

  vote({TransportationModel? transportationModel}) {
    emit(UpdateTranspLoadingState());
    _transportationService
        .addTransportation(transportationModel: transportationModel!)
        .then((value) {
      getUser();
      emit(UpdateTranspSuccessState());
    }).catchError((error) {
      emit(UpdateTranspErrorState());
    });
  }
  /*toggleFavourite(AppartmentModel apartment) {
    if (!FavouriteService.inFavouriteCheck(
        apartment: apartment, favouriteApartments: favouriteApartments)) {
      emit(GetHomeFavouriteLoadingState());
      favouriteApartments.add(apartment);
      _favouriteService.addToFavourite(apartment: apartment).then((value) {
        emit(GetHomeFavouriteSuccessState());
      }).catchError((error) {
        emit(GetHomeFavouriteErrorState());
      });
    } else {
      emit(GetHomeFavouriteLoadingState());
      favouriteApartments.remove(apartment);
      _favouriteService.deleteFromFavourite(apartment: apartment).then((value) {
        print(favouriteApartments.length);
        emit(GetHomeFavouriteSuccessState());
      }).catchError((error) {
        favouriteApartments.add(apartment);
        emit(GetHomeFavouriteErrorState());
      });
    }
  }*/

  toggleFavourite({required AppartmentModel appartmentModel}) {
    if (favouriteApartments[appartmentModel.apUid!] != null) {
      if (favouriteApartments[appartmentModel.apUid!]!) {
        _favouriteService.deleteFromFavourite(apartment: appartmentModel);
        emit(OnChangeHomeState());
      } else {
        _favouriteService.addToFavourite(apartment: appartmentModel);
        emit(OnChangeHomeState());
      }
    } else {
      _favouriteService.addToFavourite(apartment: appartmentModel);
      emit(OnChangeHomeState());
    }
  }
}
