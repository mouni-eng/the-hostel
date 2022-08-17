import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_hostel/constants.dart';
import 'package:the_hostel/size_config.dart';
import 'package:the_hostel/view_models/student_cubit/cubit.dart';
import 'package:the_hostel/view_models/student_cubit/states.dart';
import 'package:the_hostel/views/components/base_widget.dart';

class StudentLayoutView extends StatelessWidget {
  const StudentLayoutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return RentXWidget(
      builder: (rentxcontext) => BlocConsumer<StudentCubit, StudentStates>(
        listener: (context, state) {
          /*if (state is ChooseBottomNavState) {
            if (state.index == 1) {
              SearchCubit.get(context).getMapRentals();
              state.completeNavigation(true);
            } else if (state.index == 2) {
              rentxcontext
                  .requireAuth(
                      () => ClientBookingsCubit.get(context).getBookings())
                  .then((value) => state.completeNavigation(value));
            } else if (state.index == 3) {
              rentxcontext
                  .requireAuth(() => ProfileCubit.get(context).getProfileData())
                  .then((value) => state.completeNavigation(value));
            } else {
              state.completeNavigation(true);
            }
          }*/
        },
        builder: (context, state) {
          StudentCubit cubit = StudentCubit.get(context);
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Padding(
                padding: padding,
                child: cubit.screens[cubit.bottomNavIndex],
              ),
            ),
            bottomNavigationBar: SizedBox(
              width: double.infinity,
              height: height(70),
              child: BottomNavigationBar(
                selectedLabelStyle: TextStyle(
                  color: rentxcontext.theme.customTheme.primary,
                  fontSize: width(12),
                ),
                unselectedLabelStyle: TextStyle(
                  color: rentxcontext.theme.customTheme.headline2,
                  fontSize: width(12),
                ),
                items: [
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      "assets/images/home.svg",
                      width: width(20.1),
                      height: height(20.1),
                      color: rentxcontext.theme.customTheme.headline,
                    ),
                    activeIcon: SvgPicture.asset(
                      "assets/images/home.svg",
                      width: width(20.1),
                      height: height(20.1),
                      color: rentxcontext.theme.customTheme.primary,
                    ),
                    label: rentxcontext.translate("Explore"),
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      "assets/images/search-nav.svg",
                      width: width(20.1),
                      height: height(20.1),
                    ),
                    activeIcon: SvgPicture.asset(
                      "assets/images/search-nav.svg",
                      width: width(20.1),
                      height: height(20.1),
                      color: rentxcontext.theme.customTheme.primary,
                    ),
                    label: rentxcontext.translate("Search"),
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      "assets/images/building.svg",
                      width: width(20.1),
                      height: height(20.1),
                      color: rentxcontext.theme.customTheme.headline,
                    ),
                    activeIcon: SvgPicture.asset(
                      "assets/images/building.svg",
                      width: width(20.1),
                      height: height(20.1),
                      color: rentxcontext.theme.customTheme.primary,
                    ),
                    label: rentxcontext.translate("Wishlist"),
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      "assets/images/people-nav.svg",
                      width: width(20.1),
                      height: height(20.1),
                    ),
                    activeIcon: SvgPicture.asset(
                      "assets/images/people-nav.svg",
                      width: width(20.1),
                      height: height(20.1),
                      color: rentxcontext.theme.customTheme.primary,
                    ),
                    label: rentxcontext.translate("Profile"),
                  ),
                ],
                currentIndex: cubit.bottomNavIndex,
                onTap: (value) {
                  cubit.chooseBottomNavIndex(value);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
