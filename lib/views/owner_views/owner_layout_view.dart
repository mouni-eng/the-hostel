import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_hostel/constants.dart';
import 'package:the_hostel/size_config.dart';
import 'package:the_hostel/view_models/owner_cubit/cubit.dart';
import 'package:the_hostel/view_models/owner_cubit/states.dart';
import 'package:the_hostel/views/components/base_widget.dart';

class OwnerLayoutView extends StatelessWidget {
  const OwnerLayoutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return RentXWidget(builder: (rentxcontext) {
      return BlocConsumer<OwnerCubit, OwnerStates>(
          listener: (context, state) {},
          builder: (context, state) {
            OwnerCubit cubit = OwnerCubit.get(context);
            return Scaffold(
              body: SafeArea(
                  child: Padding(
                padding: padding,
                child: cubit.ownerViews[cubit.index],
              )),
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
                        "assets/images/booking.svg",
                        width: width(20.1),
                        height: height(20.1),
                        color: rentxcontext.theme.customTheme.headline,
                      ),
                      activeIcon: SvgPicture.asset(
                        "assets/images/booking.svg",
                        width: width(20.1),
                        height: height(20.1),
                        color: rentxcontext.theme.customTheme.primary,
                      ),
                      label: rentxcontext.translate("Bookings"),
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        "assets/images/city.svg",
                        width: width(20.1),
                        height: height(20.1),
                      ),
                      activeIcon: SvgPicture.asset(
                        "assets/images/city.svg",
                        width: width(20.1),
                        height: height(20.1),
                        color: rentxcontext.theme.customTheme.primary,
                      ),
                      label: rentxcontext.translate("Property"),
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
                  currentIndex: cubit.index,
                  onTap: (value) {
                    cubit.changeBottomNav(value);
                  },
                ),
              ),
            );
          });
    });
  }
}
