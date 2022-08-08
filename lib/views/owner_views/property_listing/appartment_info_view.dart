import 'package:flutter/cupertino.dart';
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
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PropertiesWidget(
                    title: "Elevation type",
                    customBuilder: SizedBox(
                      height: height(30),
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: Elevation.values.length,
                        separatorBuilder: (context, index) => SizedBox(
                          width: width(15),
                        ),
                        itemBuilder: (context, index) => AddPropertyComponent(
                          title: Elevation.values[index].name,
                          selected: cubit.elevation == Elevation.values[index],
                          onSelected: () {
                            cubit.onChooseElevation(Elevation.values[index]);
                          },
                        ),
                      ),
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
                          title: "Rooms",
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
                  PropertiesWidget(
                    title: "Rent type",
                    customBuilder: SizedBox(
                      height: height(30),
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: Rent.values.length,
                        separatorBuilder: (context, index) => SizedBox(
                          width: width(15),
                        ),
                        itemBuilder: (context, index) => AddPropertyComponent(
                          title: Rent.values[index].name,
                          selected: cubit.rent == Rent.values[index],
                          onSelected: () {
                            cubit.onChooseRent(Rent.values[index]);
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height(150),
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
                                color: rentxcontext.theme.customTheme.headline,
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
                          cubit.onNextStep();
                        },
                        isUpperCase: false,
                      ),
                    ],
                  ),
                ],
              ),
            );
          });
    });
    ;
  }
}
