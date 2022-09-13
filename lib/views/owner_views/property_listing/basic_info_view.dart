import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_hostel/constants.dart';
import 'package:the_hostel/models/appartment_model.dart';
import 'package:the_hostel/size_config.dart';
import 'package:the_hostel/view_models/add_property_cubit/cubit.dart';
import 'package:the_hostel/view_models/add_property_cubit/states.dart';
import 'package:the_hostel/views/auth_views/user_login/login_view.dart';
import 'package:the_hostel/views/components/base_widget.dart';
import 'package:the_hostel/views/components/components/custom_button.dart';
import 'package:the_hostel/views/components/components/custom_text.dart';

class BasicInfo extends StatelessWidget {
  const BasicInfo({Key? key}) : super(key: key);

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
                  key: cubit.basicFormkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PropertiesWidget(
                        title: "Name",
                        onChange: (String value) {
                          cubit.onChoosename(value);
                        },
                      ),
                      PropertiesWidget(
                        title: "Price",
                        isPhoneNumber: true,
                        onChange: (String value) {
                          cubit.onChoosePrice(double.parse(value));
                        },
                      ),
                      PropertiesWidget(
                        title: "Duration",
                        length: HostelDuration.values.length,
                        customBuilder: (context, index) => AddPropertyComponent(
                          title: HostelDuration.values[index].name,
                          iconData: Icons.timer_outlined,
                          selected: cubit.appartmentModel.duration ==
                              HostelDuration.values[index],
                          onSelected: () {
                            cubit.onChooseDuration(HostelDuration.values[index]);
                          },
                        ),
                      ),
                      PropertiesWidget(
                        title: "Description",
                        isAboutMe: true,
                        onChange: (String value) {
                          cubit.onChoosedescription(value);
                        },
                      ),
                      SizedBox(
                        height: height(35),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: CustomButton(
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
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    });
  }
}

class AddPropertyComponent extends StatelessWidget {
  const AddPropertyComponent({
    Key? key,
    required this.title,
    this.selected = false,
    this.iconData,
    this.onSelected,
  }) : super(key: key);

  final String? title;
  final IconData? iconData;
  final bool selected;
  final void Function()? onSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: RentXWidget(builder: (rentxcontext) {
        var color = rentxcontext.theme.customTheme;

        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: !selected ? color.inputFieldFill : color.primary),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width(16),
              vertical: height(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomText(
                    fontSize: width(14),
                    text: title!,
                    color: !selected ? color.headline3 : color.onPrimary,
                  ),
                ),
                if (iconData != null)
                  SizedBox(
                    width: width(10),
                  ),
                if (iconData != null)
                  Icon(
                    iconData,
                    size: height(20),
                    color: !selected ? color.headline3 : color.onPrimary,
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
