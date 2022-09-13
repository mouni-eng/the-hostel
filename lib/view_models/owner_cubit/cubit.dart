import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_hostel/constants.dart';
import 'package:the_hostel/infrastructure/utils.dart';
import 'package:the_hostel/models/booking_model.dart';
import 'package:the_hostel/services/auth_service.dart';
import 'package:the_hostel/services/booking_service.dart';
import 'package:the_hostel/services/local/cache_helper.dart';
import 'package:the_hostel/view_models/owner_cubit/states.dart';
import 'package:the_hostel/views/owner_views/add_property_view.dart';
import 'package:the_hostel/views/owner_views/booking_view.dart';
import 'package:the_hostel/views/owner_views/profile_view.dart';

class OwnerCubit extends Cubit<OwnerStates> {
  OwnerCubit() : super(OwnerStates());

  static OwnerCubit get(context) => BlocProvider.of(context);

  final AuthService _authService = AuthService();
  final BookingService _bookingService = BookingService();
  List<ApartmentBooking> bookings = [];

  getUser() async {
    var uid = await CacheHelper.getData(key: "uid");
    if(uid != null) {
await _authService.getUser(uid: uid).then((value) {
      getAllBookings();
      printLn(userModel!.email);
    });
    }
    
    
  }

  

  List<Widget> ownerViews = [
    BookingView(),
    RealEstatesView(),
    ProfileView(),
  ];

  int index = 0;

  changeBottomNav(int value) {
    index = value;
    emit(OnChangeState());
  }

  getAllBookings() {
    _bookingService.getAllBookings().listen((event) {
      bookings = [];
      emit(GetAllBookingsLoadingState());
      if (event.docs.isEmpty) {
        emit(GetAllBookingsSuccessState());
      } else {
        for (var element in event.docs) {
          bookings.add(ApartmentBooking.fromJson(element.data()));
          emit(GetAllBookingsSuccessState());
        }
      }
    });
  }
}
