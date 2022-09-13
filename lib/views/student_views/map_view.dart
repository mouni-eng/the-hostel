import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_hostel/constants.dart';
import 'package:the_hostel/infrastructure/utils.dart';
import 'package:the_hostel/models/appartment_model.dart';
import 'package:the_hostel/models/location.dart';
import 'package:the_hostel/services/alert_service.dart';
import 'package:the_hostel/size_config.dart';
import 'package:the_hostel/view_models/home_cubit/cubit.dart';
import 'package:the_hostel/view_models/home_cubit/state.dart';
import 'package:the_hostel/view_models/location_cubit/cubit.dart';
import 'package:the_hostel/view_models/location_cubit/states.dart';
import 'package:the_hostel/view_models/student_cubit/cubit.dart';
import 'package:the_hostel/views/components/base_widget.dart';
import 'package:the_hostel/views/components/components/custom_text.dart';
import 'package:the_hostel/views/components/components/price_tag.dart';
import 'package:the_hostel/views/components/components/rentalPropertyWidget.dart';
import 'package:the_hostel/views/components/components/rentx_search_input.dart';
import 'package:the_hostel/views/components/widgets/map/rentx_map_card.dart';

class MapSearchScreen extends StatelessWidget {
  const MapSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return RentXWidget(
      builder: (rentxcontext) => BlocConsumer<LocationCubit, LocationStates>(
        listener: (context, state) {
          if (state is LocationErrorState) {
            AlertService.showSnackbarAlert(
                state.error.toString(), rentxcontext, SnackbarType.error);
          }
        },
        builder: (context, state) {
          LocationCubit cubit = LocationCubit.get(context);

          return Stack(
            children: [
              RentXMapCard(
                width: double.infinity,
                location: cubit.location,
                controller: cubit.mapController,
                markers: cubit.allApartments.map((e) {
                  return RentXMapMarker(
                      point: RentXLatLong(
                          e.address!.latitude!, e.address!.longitude!),
                      width: width(1000),
                      height: height(25),
                      builder: (context) => GestureDetector(
                            onTap: () {
                              cubit.chooseApartment(e);
                            },
                            child: FittedBox(
                              fit: BoxFit.fitHeight,
                              child: Container(
                                height: height(25),
                                padding: EdgeInsets.symmetric(
                                  horizontal: width(10),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color:
                                      rentxcontext.theme.customTheme.onPrimary,
                                  boxShadow: [
                                    boxShadow,
                                  ],
                                ),
                                child: Center(
                                  child: PriceTag(
                                    price: e.price!.toString(),
                                    showDuration: false,
                                  ),
                                ),
                              ),
                            ),
                          ));
                }).toList(),
              ),
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width(16),
                    vertical: height(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SingleChildScrollView(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomButtonSearchScreen(
                              rentxcontext: rentxcontext,
                              onTap: () {
                                StudentCubit.get(context)
                                    .chooseBottomNavIndex(0);
                              },
                              icon:
                                  const Icon(Icons.arrow_back_ios_new_rounded),
                            ),
                            SizedBox(
                              width: width(8),
                            ),
                            Expanded(
                              child: MapSearchTextField(
                                isVisible: cubit.isVisible,
                                updateLocation: cubit.updateLocation,
                                searchLocation: cubit.searchLocation,
                                onDismiss: cubit.searchOnChange,
                                onTap: cubit.searchOnTap,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomButtonSearchScreen(
                            rentxcontext: rentxcontext,
                            icon: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: width(10),
                                vertical: height(10),
                              ),
                              child: SvgPicture.asset(
                                "assets/images/gps.svg",
                              ),
                            ),
                            onTap: () {
                              cubit.getCurrentLocation();
                            },
                          ),
                          Column(
                            children: [
                              CustomButtonSearchScreen(
                                rentxcontext: rentxcontext,
                                icon: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: width(10),
                                    vertical: height(10),
                                  ),
                                  child: SvgPicture.asset(
                                      "assets/images/minus.svg"),
                                ),
                                onTap: () =>
                                    cubit.mapController.zoomOut?.call(),
                              ),
                              SizedBox(
                                height: height(8),
                              ),
                              CustomButtonSearchScreen(
                                rentxcontext: rentxcontext,
                                icon: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: width(10),
                                    vertical: height(10),
                                  ),
                                  child:
                                      SvgPicture.asset("assets/images/add.svg"),
                                ),
                                onTap: () => cubit.mapController.zoomIn?.call(),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height(14),
                      ),
                      if (cubit.currentApartment != null)
                        BlocConsumer<HomeCubit, HomeStates>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              HomeCubit homeCubit = HomeCubit.get(context);
                              return HorizontalPropertyWidget(
                                  appartmentModel: cubit.currentApartment!,
                                  isFavourite: homeCubit.favouriteApartments[
                                          cubit.currentApartment!.apUid] ??
                                      false,
                                  rating: StringUtil.ratingUtil(
                                          homeCubit.reviewsApartments[
                                              cubit.currentApartment!.apUid]!)
                                      .toString(),
                                  onTap: () {
                                    homeCubit.toggleFavourite(
                                        appartmentModel:
                                            cubit.currentApartment!);
                                  });
                            }),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class MapSearchTextField extends StatelessWidget {
  const MapSearchTextField({
    Key? key,
    required this.isVisible,
    required this.updateLocation,
    required this.searchLocation,
    required this.onDismiss,
    required this.onTap,
  }) : super(key: key);

  final Function(RentXLocation) updateLocation;
  final Function(String) searchLocation;
  final void Function() onDismiss;
  final void Function() onTap;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return RentXWidget(
      builder: (rentxcontext) => MapSearchBar<RentXLocation>(
        isVissible: isVisible,
        onDismiss: onDismiss,
        onTap: onTap,
        leadingIcon: Padding(
          padding: EdgeInsets.symmetric(
            vertical: height(14),
          ),
          child: SvgPicture.asset(
            "assets/images/search.svg",
          ),
        ),
        suffixIcon: Padding(
          padding: EdgeInsets.symmetric(
            vertical: height(14),
          ),
          child: SvgPicture.asset("assets/images/close1.svg"),
        ),
        onChange: (address) => searchLocation(address),
        placeholder: 'Search here...',
        itemBuilder: (item) => SizedBox(
          height: height(46),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width(14),
                  vertical: height(14),
                ),
                child: item.locationType != RentXLocationType.city
                    ? SvgPicture.asset(
                        "assets/img/location.svg",
                        color: rentxcontext.theme.customTheme.headline,
                      )
                    : SvgPicture.asset(
                        "assets/img/building.svg",
                        color: rentxcontext.theme.customTheme.headline,
                      ),
              ),
              SizedBox(
                width: width(5),
              ),
              Expanded(
                child: CustomText(
                  color: rentxcontext.theme.customTheme.headline2,
                  fontSize: width(12),
                  text: item.fullAddress(),
                  maxlines: 1,
                ),
              ),
            ],
          ),
        ),
        onItemClick: (location) {
          updateLocation(location);
        },
        valueProvider: (item) => item.fullAddress(),
      ),
    );
  }
}

class CustomButtonSearchScreen extends StatelessWidget {
  const CustomButtonSearchScreen({
    Key? key,
    required this.rentxcontext,
    this.onTap,
    required this.icon,
  }) : super(key: key);

  final RentXContext rentxcontext;
  final Function()? onTap;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width(46),
        height: height(46),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: rentxcontext.theme.customTheme.onPrimary,
          boxShadow: [
            boxShadow,
          ],
        ),
        child: icon,
      ),
    );
  }
}
