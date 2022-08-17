import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_hostel/models/appartment_model.dart';
import 'package:the_hostel/services/auth_service.dart';
import 'package:the_hostel/services/home_service.dart';
import 'package:the_hostel/services/local/cache_helper.dart';
import 'package:the_hostel/view_models/home_cubit/state.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeStates());

  static HomeCubit get(context) => BlocProvider.of(context);
  final AuthService _authService = AuthService();
  final HomeService _homeService = HomeService();

  List<AppartmentModel> recommendApartments = [];
  List<AppartmentModel> nearestApartments = [];

  getUser() async {
    emit(GetHomeUserLoadingState());
    var uid = await CacheHelper.getData(key: "uid");
    await _authService.getUser(uid: uid).then((value) {
      emit(GetHomeUserSuccessState());
    }).then((value) {
      getNearestApartments();
      
    }).then((value) {
      getRecommendApartments();
    });
  }

  getRecommendApartments() {
    emit(GetHomeRecommendLoadingState());
    _homeService.getAllApartments().then((value) {
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
    emit(GetHomeNearestLoadingState());
    _homeService.getAllApartments().then((value) {
      if (value.docs.isEmpty) {
        emit(GetHomeNearestSuccessState());
      }
      for (var apartment in value.docs) {
        nearestApartments.add(AppartmentModel.fromJson(apartment.data()));
        emit(GetHomeNearestSuccessState());
      }
    });
  }
}
