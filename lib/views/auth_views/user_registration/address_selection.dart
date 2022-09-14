import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_hostel/constants.dart';
import 'package:the_hostel/models/signup_model.dart';
import 'package:the_hostel/services/alert_service.dart';
import 'package:the_hostel/size_config.dart';
import 'package:the_hostel/view_models/add_property_cubit/cubit.dart';
import 'package:the_hostel/view_models/add_property_cubit/states.dart';
import 'package:the_hostel/view_models/location_cubit/cubit.dart';
import 'package:the_hostel/view_models/location_cubit/states.dart';
import 'package:the_hostel/views/components/base_widget.dart';
import 'package:the_hostel/views/components/components/custom_button.dart';
import 'package:the_hostel/views/components/components/custom_form_field.dart';
import 'package:the_hostel/views/components/components/custom_text.dart';
import 'package:the_hostel/views/components/widgets/map/rentx_location_searchbar.dart';
import 'package:the_hostel/views/components/widgets/map/rentx_map_card.dart';
import 'package:the_hostel/views/owner_views/owner_layout_view.dart';
import 'package:the_hostel/views/student_views/layout_view.dart';

class AddressSelection extends StatelessWidget {
  const AddressSelection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return RentXWidget(
      builder: (rentxcontext) => BlocConsumer<LocationCubit, LocationStates>(
          builder: (context, state) {
        LocationCubit cubit = LocationCubit.get(context);
        return Scaffold(
          backgroundColor: rentxcontext.theme.customTheme.onPrimary,
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Stack(
                    children: [
                      RentXMapCard(
                        onPositionTap: (pos) => cubit.setPosition(pos),
                        width: double.infinity,
                        height: height(503),
                        location: cubit.location,
                        controller: cubit.mapController,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: width(16),
                          vertical: height(16),
                        ),
                        child: RentXLocationSearchbar(
                            isVisible: cubit.isVisible,
                            onTap: cubit.searchOnTap,
                            onDismiss: cubit.searchOnChange,
                            locationProvider: (address) =>
                                cubit.searchLocation(address),
                            onLocationPick: (location) {
                              cubit.updateLocation(location);
                            }),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height(24),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width(24),
                    ),
                    child: Column(
                      children: [
                        GestureDetector(
                            onTap: () {
                              cubit.getCurrentLocation();
                            },
                            child: const GetCurrentLocation()),
                        SizedBox(
                          height: height(24),
                        ),
                        Container(
                          width: double.infinity,
                          height: height(150),
                          padding: EdgeInsets.symmetric(
                            horizontal: width(16),
                            vertical: height(16),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: rentxcontext.theme.customTheme.onPrimary,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF000000)
                                    .withOpacity(0.06), //color of shadow
                                //spread radius
                                blurRadius: width(30), // blur radius
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                color: rentxcontext.theme.customTheme.headline,
                                fontSize: width(14),
                                text: "Additional Details",
                              ),
                              const Divider(
                                thickness: 0.8,
                              ),
                              SizedBox(
                                height: height(16),
                              ),
                              CustomFormField(
                                context: context,
                                hintText: 'Enter details',
                                onChange: (value) {
                                  cubit.notesChange(value);
                                },
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return "";
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height(16),
                        ),
                        CustomButton(
                          showLoader: state is LocationLoadingState,
                          text: rentxcontext.translate("Submit"),
                          radius: 6,
                          fontSize: width(16),
                          btnWidth: double.infinity,
                          function: () {
                            if (cubit.address != null) {
                              cubit.updateUserLocation();
                            }
                          },
                          isUpperCase: false,
                        ),
                        SizedBox(
                          height: height(20),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }, listener: (context, state) {
        if (state is LocationErrorState) {
          AlertService.showSnackbarAlert(
            state.error ?? '',
            rentxcontext,
            SnackbarType.error,
          );
        } else if (state is LocationSuccessState) {
          if (userModel!.role == UserRole.student) {
            rentxcontext.route((context) => const StudentLayoutView());
          } else {
            rentxcontext.route((context) => const OwnerLayoutView());
          }
        }
      }),
    );
  }
}

class GetCurrentLocation extends StatelessWidget {
  const GetCurrentLocation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RentXWidget(
      builder: (rentxcontext) => Container(
        width: double.infinity,
        height: height(74),
        padding: EdgeInsets.symmetric(
          horizontal: width(16),
          vertical: height(16),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: rentxcontext.theme.customTheme.onPrimary,
          boxShadow: [
            BoxShadow(
              color:
                  const Color(0xFF000000).withOpacity(0.06), //color of shadow
              //spread radius
              blurRadius: width(30), // blur radius
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            SvgPicture.asset("assets/images/gps.svg"),
            SizedBox(
              width: width(8),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  color: rentxcontext.theme.customTheme.primary,
                  fontSize: width(16),
                  text: "Current Location",
                ),
                SizedBox(
                  height: height(2),
                ),
                CustomText(
                  color: rentxcontext.theme.customTheme.headline3,
                  fontSize: width(12),
                  height: 1,
                  text: "Using GPS",
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
            const Spacer(),
            SvgPicture.asset("assets/images/arrow-left.svg"),
          ],
        ),
      ),
    );
  }
}

class AddressApartmentSelection extends StatelessWidget {
  const AddressApartmentSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RentXWidget(
      builder: (rentxcontext) => BlocConsumer<LocationCubit, LocationStates>(
          builder: (context, state) {
        LocationCubit cubit = LocationCubit.get(context);
        return Scaffold(
          backgroundColor: rentxcontext.theme.customTheme.onPrimary,
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Stack(
                    children: [
                      RentXMapCard(
                        onPositionTap: (pos) => cubit.setPosition(pos),
                        width: double.infinity,
                        height: height(503),
                        location: cubit.location,
                        controller: cubit.mapController,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: width(16),
                          vertical: height(16),
                        ),
                        child: RentXLocationSearchbar(
                            isVisible: cubit.isVisible,
                            onTap: cubit.searchOnTap,
                            onDismiss: cubit.searchOnChange,
                            locationProvider: (address) =>
                                cubit.searchLocation(address),
                            onLocationPick: (location) {
                              cubit.updateLocation(location);
                            }),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height(24),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width(24),
                    ),
                    child: Column(
                      children: [
                        GestureDetector(
                            onTap: () {
                              cubit.getCurrentLocation();
                            },
                            child: const GetCurrentLocation()),
                        SizedBox(
                          height: height(24),
                        ),
                        Container(
                          width: double.infinity,
                          height: height(150),
                          padding: EdgeInsets.symmetric(
                            horizontal: width(16),
                            vertical: height(16),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: rentxcontext.theme.customTheme.onPrimary,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF000000)
                                    .withOpacity(0.06), //color of shadow
                                //spread radius
                                blurRadius: width(30), // blur radius
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                color: rentxcontext.theme.customTheme.headline,
                                fontSize: width(14),
                                text: "Additional Details",
                              ),
                              const Divider(
                                thickness: 0.8,
                              ),
                              SizedBox(
                                height: height(16),
                              ),
                              CustomFormField(
                                context: context,
                                hintText: 'Enter details',
                                onChange: (value) {
                                  cubit.notesChange(value);
                                },
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return "";
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height(16),
                        ),
                        BlocConsumer<AddPropertyCubit, AddPropertyStates>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              return CustomButton(
                                showLoader: state is AddApartmentLoadingState,
                                text: rentxcontext.translate("Submit"),
                                radius: 6,
                                fontSize: width(16),
                                btnWidth: double.infinity,
                                function: () async {
                                  if (cubit.address != null) {
                                    await AddPropertyCubit.get(context)
                                        .onChooseAddress(cubit.address!);
                                    rentxcontext.pop();
                                  }
                                },
                                isUpperCase: false,
                              );
                            }),
                        SizedBox(
                          height: height(20),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }, listener: (context, state) {
        if (state is LocationErrorState) {
          AlertService.showSnackbarAlert(
            state.error ?? '',
            rentxcontext,
            SnackbarType.error,
          );
        } else if (state is LocationSuccessState) {
          if (userModel!.role == UserRole.student) {
            rentxcontext.route((context) => const StudentLayoutView());
          } else {
            rentxcontext.route((context) => const OwnerLayoutView());
          }
        }
      }),
    );
  }
}
