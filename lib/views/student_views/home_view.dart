import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_hostel/constants.dart';
import 'package:the_hostel/extensions/string_extension.dart';
import 'package:the_hostel/infrastructure/utils.dart';
import 'package:the_hostel/models/appartment_model.dart';
import 'package:the_hostel/size_config.dart';
import 'package:the_hostel/theme/custom_theme.dart';
import 'package:the_hostel/view_models/home_cubit/cubit.dart';
import 'package:the_hostel/view_models/home_cubit/state.dart';
import 'package:the_hostel/views/components/base_widget.dart';
import 'package:the_hostel/views/components/components/back_button.dart';
import 'package:the_hostel/views/components/components/custom_form_field.dart';
import 'package:the_hostel/views/components/components/custom_text.dart';
import 'package:the_hostel/views/components/components/rentalPropertyWidget.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RentXWidget(builder: (rentxcontext) {
      var color = rentxcontext.theme.customTheme;
      return BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {},
          builder: (context, state) {
            HomeCubit cubit = HomeCubit.get(context);
            return ConditionalBuilder(
                condition: state is! GetHomeUserLoadingState,
                fallback: (context) => loading,
                builder: (context) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HomeHeaderWidget(),
                        SizedBox(
                          height: height(25),
                        ),
                        HomeFilteringWidget(),
                        SizedBox(
                          height: height(25),
                        ),
                        HomeFilteringByRentWidget(),
                        SizedBox(
                          height: height(25),
                        ),
                        HomeHeaderTitle(
                          title: "Popular Nearest You",
                          onTap: () {},
                        ),
                        SizedBox(
                          height: height(25),
                        ),
                        ConditionalBuilder(
                          condition: state is! GetHomeNearestLoadingState,
                          fallback: (context) => loading,
                          builder: (context) {
                            return SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                    cubit.nearestApartments.length,
                                    (index) => VerticalPropertyWidget(
                                          contWidth: 230,
                                          appartmentModel: cubit.nearestApartments[index],
                                        )),
                              ),
                            );
                          }
                        ),
                        SizedBox(
                          height: height(25),
                        ),
                        HomeHeaderTitle(
                          title: "Recommend For You",
                          onTap: () {},
                        ),
                        SizedBox(
                          height: height(25),
                        ),
                        ConditionalBuilder(
                          condition: state is! GetHomeRecommendLoadingState,
                          fallback: (context) => loading,
                          builder: (context) {
                            return ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => HorizontalPropertyWidget(
                                          appartmentModel: cubit.nearestApartments[index],
                                        ),
                              itemCount: cubit.nearestApartments.length,
                              separatorBuilder: (context, index) => SizedBox(
                                width: width(15),
                              ),
                            );
                          }
                        ),
                        /*ListView.separated(
                          itemBuilder: itemBuilder, 
                          separatorBuilder: separatorBuilder, 
                          itemCount: itemCount
                        ),*/
                      ],
                    ),
                  );
                });
          });
    });
  }
}

class HomeHeaderTitle extends StatelessWidget {
  const HomeHeaderTitle({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return RentXWidget(builder: (rentxcontext) {
      var color = rentxcontext.theme.customTheme;

      return Row(
        children: [
          CustomText(
            fontSize: width(16),
            text: title,
            fontWeight: FontWeight.w600,
            color: color.headline,
          ),
          Spacer(),
          GestureDetector(
            onTap: onTap,
            child: CustomText(
              fontSize: width(12),
              text: "View All",
              fontWeight: FontWeight.w400,
              color: color.primary,
            ),
          )
        ],
      );
    });
  }
}

class HomeFilteringByRentWidget extends StatelessWidget {
  const HomeFilteringByRentWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
          children: List.generate(
        Rent.values.length,
        (index) => FilteringWidget(
          title: Rent.values[index].name,
          icon: Rent.values[index].icon!,
        ),
      )),
    );
  }
}

class FilteringWidget extends StatelessWidget {
  const FilteringWidget({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return RentXWidget(builder: (rentxcontext) {
      var color = rentxcontext.theme.customTheme;

      return Container(
        margin: EdgeInsets.only(
          right: width(10),
        ),
        padding: EdgeInsets.all(width(8)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: color.inputFieldBorder,
          ),
        ),
        child: Row(
          children: [
            CustomText(
              fontSize: width(12),
              text: title.capitalize(),
              color: color.primary,
            ),
            SizedBox(
              width: width(15),
            ),
            Icon(
              icon,
              color: color.headline3,
            ),
          ],
        ),
      );
    });
  }
}

class HomeFilteringWidget extends StatelessWidget {
  const HomeFilteringWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RentXWidget(builder: (rentxcontext) {
      var color = rentxcontext.theme.customTheme;
      return Row(
        children: [
          Expanded(
            child: SizedBox(
              height: height(46),
              child: CustomFormField(
                context: context,
                prefix: Padding(
                  padding: padding,
                  child: SvgPicture.asset("assets/images/search.svg"),
                ),
                hintText: "Search your house....",
              ),
            ),
          ),
          SizedBox(
            width: width(15),
          ),
          CustomBorderWidget(
            rentxcontext: rentxcontext,
            iconData: Padding(
              padding: EdgeInsets.all(width(6)),
              child: SvgPicture.asset(
                "assets/images/filter.svg",
                color: color.primary,
              ),
            ),
          ),
        ],
      );
    });
  }
}

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RentXWidget(builder: (rentxcontext) {
      var color = rentxcontext.theme.customTheme;
      return Row(
        children: [
          SvgPicture.asset(
            "assets/images/remind.svg",
            color: color.primary,
          ),
          SizedBox(
            width: width(20),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  fontSize: width(14),
                  text: "Location",
                  height: 1.6,
                  color: color.primary,
                ),
                CustomText(
                  fontSize: width(14),
                  maxlines: 2,
                  height: 1.1,
                  text: userModel!.address!.fullAddress(),
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
          Spacer(),
          CustomNetworkImage(
            imgWidth: 60,
            imgHeight: 65,
            radius: 12,
            url: userModel!.profilePictureId!,
            avatarLetters: NameUtil.getInitials(
              userModel!.name,
              userModel!.surname,
            ),
          ),
        ],
      );
    });
  }
}
