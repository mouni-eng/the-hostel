import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_hostel/constants.dart';
import 'package:the_hostel/extensions/string_extension.dart';
import 'package:the_hostel/infrastructure/helper/eg.dart';
import 'package:the_hostel/infrastructure/utils.dart';
import 'package:the_hostel/models/address.dart';
import 'package:the_hostel/models/appartment_model.dart';
import 'package:the_hostel/models/booking_model.dart';
import 'package:the_hostel/models/cities_model.dart';
import 'package:the_hostel/models/transportation_model.dart';
import 'package:the_hostel/services/favourite_service.dart';
import 'package:the_hostel/size_config.dart';
import 'package:the_hostel/theme/custom_theme.dart';
import 'package:the_hostel/view_models/home_cubit/cubit.dart';
import 'package:the_hostel/view_models/home_cubit/state.dart';
import 'package:the_hostel/views/auth_views/user_login/login_view.dart';
import 'package:the_hostel/views/components/base_widget.dart';
import 'package:the_hostel/views/components/components/back_button.dart';
import 'package:the_hostel/views/components/components/custom_button.dart';
import 'package:the_hostel/views/components/components/custom_dropDown.dart';
import 'package:the_hostel/views/components/components/custom_form_field.dart';
import 'package:the_hostel/views/components/components/custom_text.dart';
import 'package:the_hostel/views/components/components/rentalPropertyWidget.dart';
import 'package:the_hostel/views/student_views/all_hostels_view.dart';
import 'package:the_hostel/views/student_views/qr_code_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: RentXWidget(builder: (rentxcontext) {
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
                          /*HomeFilteringWidget(),*/
                          if (cubit.booking != null)
                            HomeNotificationBar(
                              booking: cubit.booking!,
                            ),
                          SizedBox(
                            height: height(25),
                          ),
                          HomeFilteringByRentWidget(),
                          SizedBox(
                            height: height(25),
                          ),
                          HomeHeaderTitle(
                            title: "Stay with others!",
                            onTap: () async {
                              await cubit.getAllApartments();
                              rentxcontext.route((context) => AllHostelsView());
                            },
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
                                              appartmentModel: cubit
                                                  .nearestApartments[index],
                                              isFavourite: cubit
                                                          .favouriteApartments[
                                                      cubit
                                                          .nearestApartments[
                                                              index]
                                                          .apUid] ??
                                                  false,
                                              rating: cubit.reviewsApartments
                                                      .isNotEmpty
                                                  ? StringUtil.ratingUtil(cubit
                                                              .reviewsApartments[
                                                          cubit
                                                              .nearestApartments[
                                                                  index]
                                                              .apUid]!)
                                                      .toString()
                                                  : "NA",
                                              onTap: () {
                                                cubit.toggleFavourite(
                                                  appartmentModel: cubit
                                                      .nearestApartments[index],
                                                );
                                              },
                                            )),
                                  ),
                                );
                              }),
                          SizedBox(
                            height: height(25),
                          ),
                          HomeHeaderTitle(
                            title: "Recommend For You",
                            onTap: () async {
                              await cubit.getAllApartments();
                              rentxcontext.route((context) => AllHostelsView());
                            },
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
                                  itemBuilder: (context, index) =>
                                      HorizontalPropertyWidget(
                                    appartmentModel:
                                        cubit.recommendApartments[index],
                                    isFavourite: cubit.favouriteApartments[cubit
                                            .recommendApartments[index]
                                            .apUid] ??
                                        false,
                                    rating: cubit.reviewsApartments.isNotEmpty
                                        ? StringUtil.ratingUtil(
                                                cubit.reviewsApartments[cubit
                                                    .recommendApartments[index]
                                                    .apUid]!)
                                            .toString()
                                        : "NA",
                                    onTap: () {
                                      cubit.toggleFavourite(
                                        appartmentModel:
                                            cubit.recommendApartments[index],
                                      );
                                    },
                                  ),
                                  itemCount: cubit.recommendApartments.length,
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    height: height(15),
                                  ),
                                );
                              }),
                          SizedBox(
                            height: height(25),
                          ),
                          const InfoWidget(
                            title: "Transportation",
                            subTilte:
                                "Will be available soon, So please vote for the following rides and it will be available once the voted users exceeds the minimum number of users.",
                          ),
                          SizedBox(
                            height: height(25),
                          ),
                          const InfoWidget(
                            title: "Daily Rides",
                            subTilte:
                                "The daily rides will take you to and from your hostel home and universities everyday according to your schedule and the payment will be in advance the night be for your ride and we will notify you to pay through the app. (once the ride is available we will ask you to enter your schedule of weekly rides)",
                          ),
                          SizedBox(
                            height: height(25),
                          ),
                          if (state is! GetDailyTranspLoadingState)
                            TransportationCard(
                              transportationModel: cubit.dailyModel,
                              loader: state is UpdateTranspLoadingState,
                              btnText: userModel!.universty != null &&
                                      cubit.booking != null
                                  ? "Vote"
                                  : "Complete your info to continue",
                              onTap: () {
                                if (userModel!.universty == null ||
                                    cubit.booking == null) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => CustomDialog(
                                      builder: DailyCustomWidget(
                                        onChange: (value) {
                                          cubit.onChooseUniversty(value);
                                        },
                                        loader:
                                            state is UpdateTranspLoadingState,
                                        onTap: () async {
                                          if (cubit.universty != null &&
                                              cubit.booking == null) {
                                            await cubit.updateUniversty();
                                            rentxcontext.route((context) =>
                                                const AllHostelsView());
                                          } else if (cubit.universty != null) {
                                            await cubit.updateUniversty();
                                          }
                                        },
                                      ),
                                    ),
                                  );
                                } else {
                                  cubit.vote(
                                      transportationModel: TransportationModel(
                                    from: userModel!.universty,
                                    to: cubit.booking!.appartmentModel!.name,
                                    minNumber: "12",
                                    transportationType: Transportation.daily,
                                    voted: StringUtil.voteUtil(
                                            cubit.dailyModel.voted)
                                        .toString(),
                                  ));
                                }
                              },
                            ),
                          SizedBox(
                            height: height(25),
                          ),
                          const InfoWidget(
                              title: "Weekly Rides",
                              subTilte:
                                  "The weekly rides will take you to and from your hostel home and government at the beginning and end of every weekend  according to your chosen days (once the ride is available we will ask you to enter your schedule of weekly rides"),
                          SizedBox(
                            height: height(25),
                          ),
                          if (state is! GetWeeklyTranspLoadingState)
                            TransportationCard(
                              transportationModel: cubit.weeklyModel,
                              loader: state is UpdateTranspLoadingState,
                              btnText: userModel!.government != null
                                  ? "Vote"
                                  : "Complete your info to continue",
                              onTap: () {
                                if (userModel!.government == null) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => CustomDialog(
                                      builder: WeeklyTranspDialog(
                                        loader:
                                            state is UpdateTranspLoadingState,
                                        onChange: (value) {
                                          cubit.onChooseGovernoment(value);
                                        },
                                        onTap: () {
                                          if (cubit.governoment != null) {
                                            cubit.updateGovernoment();
                                          }
                                        },
                                      ),
                                    ),
                                  );
                                } else {
                                  cubit.vote(
                                      transportationModel: TransportationModel(
                                    from: userModel!.government,
                                    to: "Badr City",
                                    minNumber: "30",
                                    transportationType: Transportation.weekly,
                                    voted: StringUtil.voteUtil(
                                            cubit.weeklyModel.voted)
                                        .toString(),
                                  ));
                                }
                              },
                            ),
                          SizedBox(
                            height: height(15),
                          ),
                        ],
                      ),
                    );
                  });
            });
      }),
    );
  }
}

class DailyCustomWidget extends StatelessWidget {
  const DailyCustomWidget({
    Key? key,
    this.onChange,
    this.onTap,
    this.loader = false,
  }) : super(key: key);

  final Function(String?)? onChange;
  final Function()? onTap;
  final bool loader;

  @override
  Widget build(BuildContext context) {
    return RentXWidget(builder: (rentxcontext) {
      var color = rentxcontext.theme.customTheme;
      return Column(
        children: [
          CustomText(
            fontSize: width(18),
            text: "Complete your info",
            fontWeight: FontWeight.w600,
          ),
          SizedBox(
            height: height(25),
          ),
          CustomDropDownBox(
            context: context,
            hint: "Universty",
            dropItems: [
              DropdownMenuItem(
                value: "Badr Universty",
                child: CustomText(fontSize: width(14), text: "Badr Universty"),
              ),
              DropdownMenuItem(
                value: "ERU Universty",
                child: CustomText(fontSize: width(14), text: "ERU Universty"),
              ),
            ],
            label: "Your College",
            onChange: onChange,
            validate: (value) => "Enter your College",
          ),
          const Spacer(),
          CustomButton(
            btnWidth: double.infinity,
            fontSize: width(14),
            function: onTap,
            text: HomeCubit.get(context).booking != null
                ? "Submit"
                : "Choose your Hostel",
          ),
        ],
      );
    });
  }
}

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    Key? key,
    required this.builder,
  }) : super(key: key);

  final Widget builder;

  @override
  Widget build(BuildContext context) {
    return RentXWidget(builder: (rentxcontext) {
      var color = rentxcontext.theme.customTheme;
      return Dialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Container(
          padding: padding,
          width: double.infinity,
          height: height(500),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: color.onPrimary,
          ),
          child: builder,
        ),
      );
    });
  }
}

class WeeklyTranspDialog extends StatelessWidget {
  const WeeklyTranspDialog({
    Key? key,
    this.onChange,
    this.onTap,
    required this.loader,
  }) : super(key: key);

  final Function(String?)? onChange;
  final Function()? onTap;
  final bool loader;

  @override
  Widget build(BuildContext context) {
    return RentXWidget(builder: (rentxcontext) {
      var color = rentxcontext.theme.customTheme;
      return Column(children: [
        CustomText(
          fontSize: width(18),
          text: "Choose your Governoment",
          fontWeight: FontWeight.w600,
        ),
        SizedBox(
          height: height(35),
        ),
        Container(
          decoration: BoxDecoration(color: color.onPrimary),
          child: CustomDropDownBox(
              context: context,
              hint: "Governoment",
              dropItems: List.generate(cities.length, (index) {
                return DropdownMenuItem<String>(
                  value: CityModel.fromJson(cities[index]).city,
                  child: CustomText(
                      fontSize: width(14),
                      text: CityModel.fromJson(cities[index]).city),
                );
              }),
              label: "Your City",
              onChange: onChange,
              validate: (value) {
                if (value == null) {
                  return "";
                } else {
                  return null;
                }
              }),
        ),
        const Spacer(),
        CustomButton(
          showLoader: loader,
          btnWidth: double.infinity,
          fontSize: width(14),
          function: onTap,
          text: "Submit",
        ),
      ]);
    });
  }
}

class TransportationCard extends StatelessWidget {
  const TransportationCard({
    Key? key,
    this.onTap,
    this.transportationModel,
    required this.btnText,
    this.loader = false,
  }) : super(key: key);

  final Function()? onTap;
  final TransportationModel? transportationModel;
  final String btnText;
  final bool? loader;

  @override
  Widget build(BuildContext context) {
    return RentXWidget(builder: (rentxcontext) {
      var color = rentxcontext.theme.customTheme;
      return Container(
        width: double.infinity,
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [boxShadow],
          color: color.onPrimary,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  fontSize: width(16),
                  text: transportationModel!.from ?? "?",
                ),
                Icon(
                  Icons.compare_arrows_outlined,
                  color: color.headline3,
                ),
                CustomText(
                  fontSize: width(16),
                  text: transportationModel!.to ?? "",
                ),
              ],
            ),
            SizedBox(
              height: height(15),
            ),
            const Divider(
              thickness: 0.8,
            ),
            SizedBox(
              height: height(15),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  fontSize: width(14),
                  text: "Number of voted users",
                ),
                CustomText(
                  fontSize: width(14),
                  text: transportationModel!.voted ?? "?",
                ),
              ],
            ),
            SizedBox(
              height: height(20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  fontSize: width(14),
                  text: "Minimum number to launch the ride",
                ),
                CustomText(
                  fontSize: width(14),
                  text: transportationModel!.minNumber ?? "?",
                ),
              ],
            ),
            SizedBox(
              height: height(25),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: CustomButton(
                showLoader: loader,
                enabled: transportationModel!.voted == "?",
                fontSize: width(14),
                btnHeight: height(50),
                function: onTap,
                text: btnText,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class InfoWidget extends StatelessWidget {
  const InfoWidget({
    Key? key,
    required this.title,
    required this.subTilte,
  }) : super(key: key);

  final String title, subTilte;

  @override
  Widget build(BuildContext context) {
    return RentXWidget(builder: (rentxcontext) {
      var color = rentxcontext.theme.customTheme;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            fontSize: width(18),
            text: title,
            fontWeight: FontWeight.w600,
            color: color.headline,
          ),
          SizedBox(
            height: height(15),
          ),
          CustomText(
            fontSize: width(14),
            text: subTilte,
            fontWeight: FontWeight.w400,
            maxlines: 6,
            color: color.headline3,
          ),
        ],
      );
    });
  }
}

class HomeNotificationBar extends StatelessWidget {
  const HomeNotificationBar({
    Key? key,
    required this.booking,
  }) : super(key: key);

  final ApartmentBooking booking;

  @override
  Widget build(BuildContext context) {
    return RentXWidget(builder: (rentxcontext) {
      var color = rentxcontext.theme.customTheme;
      return GestureDetector(
        onTap: () {
          rentxcontext.route((context) => QrCodeGeneratorView(qrCode: booking.apUid!,));
        },
        child: Container(
          width: double.infinity,
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [boxShadow],
            color: color.primary,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.home,
                    color: color.onPrimary,
                  ),
                  SizedBox(
                    width: width(10),
                  ),
                  CustomText(
                    fontSize: width(18),
                    text: "Home Rent",
                    fontWeight: FontWeight.w600,
                    color: color.onPrimary,
                  ),
                ],
              ),
              SizedBox(
                height: height(10),
              ),
              CustomText(
                fontSize: width(16),
                text:
                    "${DateUtil.displayDiffrence(DateTime.now(), booking.toDate!)} Left for the Rent Renewal",
                fontWeight: FontWeight.w400,
                color: color.onPrimary,
              ),
            ],
          ),
        ),
      );
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
    return RentXWidget(builder: (rentxcontext) {
      return SizedBox(
        height: height(50),
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => FilteringWidget(
            onTap: () {
              HomeCubit.get(context).getFilterdApartment(Rent.values[index]);
              rentxcontext.route((context) => AllHostelsView()).then((value) {
                HomeCubit.get(context).getAllApartments();
              });
            },
            title: Rent.values[index].name,
            icon: Rent.values[index].icon!,
          ),
          separatorBuilder: (context, index) => SizedBox(
            width: width(20),
          ),
          itemCount: Rent.values.length,
        ),
      );
    });
  }
}

class FilteringWidget extends StatelessWidget {
  const FilteringWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return RentXWidget(builder: (rentxcontext) {
      var color = rentxcontext.theme.customTheme;

      return GestureDetector(
        onTap: onTap,
        child: Container(
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
