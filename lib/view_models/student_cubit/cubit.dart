import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_hostel/services/auth_service.dart';
import 'package:the_hostel/services/local/cache_helper.dart';
import 'package:the_hostel/view_models/student_cubit/states.dart';
import 'package:the_hostel/views/owner_views/profile_view.dart';
import 'package:the_hostel/views/student_views/home_view.dart';
import 'package:the_hostel/views/student_views/map_view.dart';
import 'package:the_hostel/views/student_views/wishlist_view.dart';

class StudentCubit extends Cubit<StudentStates> {
  StudentCubit() : super(StudentStates());

  static StudentCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    HomeView(),
    MapSearchView(),
    WishListView(),
    ProfileView(),
  ];

  int bottomNavIndex = 0;

  chooseBottomNavIndex(int value) {
    bottomNavIndex = value;
    emit(OnChangeStudentState());
  }
}
