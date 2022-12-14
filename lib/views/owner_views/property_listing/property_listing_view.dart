import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_hostel/constants.dart';
import 'package:the_hostel/size_config.dart';
import 'package:the_hostel/theme/app_theme.dart';
import 'package:the_hostel/view_models/add_property_cubit/cubit.dart';
import 'package:the_hostel/view_models/add_property_cubit/states.dart';
import 'package:the_hostel/views/components/base_widget.dart';
import 'package:the_hostel/views/components/components/custom_text.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PropertyListingView extends StatelessWidget {
  const PropertyListingView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RentXWidget(
      builder: (rentXContext) => Scaffold(
          backgroundColor: AppTheme.theme.backgroundColor,
          body: BlocConsumer<AddPropertyCubit, AddPropertyStates>(
              listener: (context, state) {},
              builder: (context, state) {
                AddPropertyCubit cubit = AddPropertyCubit.get(context);
                return SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: padding,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                                color: rentXContext.theme.customTheme.secondary,
                                fontSize: width(22),
                                fontWeight: FontWeight.w600,
                                text: rentXContext
                                    .translate(cubit.header[cubit.index])),
                            SizedBox(
                              height: height(5),
                            ),
                            Row(
                              children: [
                                CustomText(
                                    color:
                                        rentXContext.theme.customTheme.primary,
                                    fontSize: width(16),
                                    fontWeight: FontWeight.w600,
                                    text: rentXContext
                                        .translate("Step ${cubit.index + 1}")),
                                CustomText(
                                    color: rentXContext
                                        .theme.customTheme.kSecondaryColor,
                                    fontSize: width(16),
                                    text: rentXContext.translate(" to 4 ")),
                              ],
                            ),
                            SizedBox(
                              height: height(14),
                            ),
                            LinearPercentIndicator(
                              width: width(320),
                              lineHeight: height(5),
                              animation: true,
                              barRadius: const Radius.circular(6),
                              percent: cubit.percent,
                              padding: EdgeInsets.zero,
                              backgroundColor:
                                  rentXContext.theme.customTheme.onPrimary,
                              progressColor:
                                  rentXContext.theme.customTheme.primary,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height(30),
                      ),
                      Expanded(
                        child: PageView.builder(
                          controller: cubit.controller,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cubit.steps.length,
                          itemBuilder: (context, no) =>
                              cubit.steps[cubit.index],
                        ),
                      ),
                    ],
                  ),
                );
              })),
    );
  }
}
