import 'package:flutter/cupertino.dart';
import 'package:the_hostel/constants.dart';
import 'package:the_hostel/views/auth_views/user_login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_hostel/models/appartment_model.dart';
import 'package:the_hostel/size_config.dart';
import 'package:the_hostel/view_models/add_property_cubit/cubit.dart';
import 'package:the_hostel/view_models/add_property_cubit/states.dart';
import 'package:the_hostel/views/components/base_widget.dart';
import 'package:the_hostel/views/components/components/custom_button.dart';
import 'package:the_hostel/views/owner_views/property_listing/basic_info_view.dart';

class ApartmentInfoView extends StatelessWidget {
  const ApartmentInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RentXWidget(builder: (rentxcontext) {
      var color = rentxcontext.theme.customTheme;
      return BlocConsumer<AddPropertyCubit, AddPropertyStates>(
          listener: (context, state) {},
          builder: (context, state) {
            AddPropertyCubit cubit = AddPropertyCubit.get(context);
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width(16),
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: cubit.apartmentFormkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PropertiesWidget(
                        title: "Elevation type",
                        length: Elevation.values.length,
                        customBuilder: (context, index) => AddPropertyComponent(
                          title: Elevation.values[index].name,
                          selected: cubit.appartmentModel.elevation ==
                              Elevation.values[index],
                          onSelected: () {
                            cubit.onChooseElevation(Elevation.values[index]);
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: PropertiesWidget(
                              title: "Floor",
                              isPhoneNumber: true,
                              onChange: (String value) {
                                cubit.onChoosefloor(int.parse(value));
                              },
                            ),
                          ),
                          SizedBox(
                            width: width(25),
                          ),
                          Expanded(
                            child: PropertiesWidget(
                              title: "BedRooms",
                              isPhoneNumber: true,
                              onChange: (String value) {
                                cubit.onChooserooms(int.parse(value));
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: PropertiesWidget(
                              title: "Bathromms",
                              isPhoneNumber: true,
                              onChange: (String value) {
                                cubit.onChoosebathrooms(int.parse(value));
                              },
                            ),
                          ),
                          SizedBox(
                            width: width(25),
                          ),
                          Expanded(
                            child: PropertiesWidget(
                              title: "Capacity",
                              isPhoneNumber: true,
                              onChange: (String value) {
                                cubit.onChoosecapacity(int.parse(value));
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: PropertiesWidget(
                              title: "Bed/Room",
                              isPhoneNumber: true,
                              onChange: (String value) {
                                cubit.onChoosecapacity(int.parse(value));
                              },
                            ),
                          ),
                          SizedBox(
                            width: width(25),
                          ),
                          Expanded(
                            child: PropertiesWidget(
                              title: "Area",
                              isPhoneNumber: true,
                              onChange: (String value) {
                                cubit.onChoosecapacity(int.parse(value));
                              },
                            ),
                          ),
                        ],
                      ),
                      PropertiesWidget(
                        title: "Gender type",
                        length: Gender.values.length,
                        customBuilder: (context, index) => AddPropertyComponent(
                          title: Gender.values[index].name,
                          selected: cubit.appartmentModel.gender ==
                              Gender.values[index],
                          onSelected: () {
                            cubit.onChooseGender(Gender.values[index]);
                          },
                        ),
                      ),
                      SizedBox(
                        height: height(40),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (cubit.index != 0)
                            TextButton(
                                onPressed: () {
                                  cubit.onBackStep();
                                },
                                child: Text(
                                  rentxcontext.translate("back"),
                                  style: TextStyle(
                                    fontSize: width(16),
                                    color:
                                        rentxcontext.theme.customTheme.headline,
                                  ),
                                )),
                          if (cubit.index == 0) Container(),
                          CustomButton(
                            text: rentxcontext.translate('Next'),
                            radius: 6,
                            fontSize: width(16),
                            btnWidth: width(132),
                            btnHeight: height(50),
                            function: () {
                              cubit.onNextValidate();
                            },
                            isUpperCase: false,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    });
    ;
  }
}
