import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_hostel/models/appartment_model.dart';
import 'package:the_hostel/services/favourite_service.dart';
import 'package:the_hostel/view_models/wishList_cubit/states.dart';

class WishListCubit extends Cubit<WishListStates> {
  WishListCubit() : super(WishListStates());

  static WishListCubit get(context) => BlocProvider.of(context);

  final FavouriteService _favouriteService = FavouriteService();

  List<AppartmentModel> wishList = [];

  getAllFavourites() {
    
    emit(GetWishListLoadingState());
    _favouriteService.getFavouriteApartments().listen((value) {
      wishList = [];
      if (value.docs.isEmpty) {
        emit(GetWishListSuccessState());
      } else {
        for (var apartment in value.docs) {
          wishList.add(AppartmentModel.fromJson(apartment.data()));
          print(wishList.length);
          emit(GetWishListSuccessState());
        }
      }
    });
  }

  deleteFromWishList({required AppartmentModel model}) {
    _favouriteService.deleteFromFavourite(apartment: model);
  }
}
