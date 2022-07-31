import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_hostel/size_config.dart';
import 'package:the_hostel/theme/app_theme.dart';
import 'package:the_hostel/view_models/auth_cubit/cubit.dart';
import 'package:the_hostel/view_models/auth_cubit/states.dart';
import 'package:the_hostel/views/components/base_widget.dart';
import 'package:the_hostel/views/components/components/custom_text.dart';
import 'package:percent_indicator/percent_indicator.dart';


class UserRegistrationScreen extends StatelessWidget {
  const UserRegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RentXWidget(
        builder: (rentXContext) => Scaffold(
              backgroundColor: AppTheme.theme.backgroundColor,
              body: SafeArea(
                  child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width(24),
                  vertical: height(24),
                ),
                child: BlocConsumer<AuthCubit, AuthStates>(
                  listener: (context, state) {
                    /*if (state is EmailConfirmedState) {
                      rentXContext.route((p0) => CompletedScreen(
                            title: 'emailVerified',
                            text: 'accountSuccessfullyVerified',
                            onBtnClick: () {
                              rentXContext.route((p0) =>
                                  state.loginResponse.role == UserRole.manager
                                      ? const CompanyRegistrationScreen()
                                      : const LayoutScreen());
                            },
                          ));
                    }*/
                  },
                  builder: (context, state) {
                    AuthCubit cubit = AuthCubit.get(context);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                            color: rentXContext.theme.customTheme.secondary,
                            fontSize: width(22),
                            fontWeight: FontWeight.w600,
                            text: rentXContext
                                .translate(cubit.headers[cubit.index])),
                        SizedBox(
                          height: height(5),
                        ),
                        Row(
                          children: [
                            CustomText(
                                color: rentXContext.theme.customTheme.primary,
                                fontSize: width(16),
                                fontWeight: FontWeight.w600,
                                text: rentXContext
                                    .translate("Step ${cubit.index + 1}")),
                            CustomText(
                                color: rentXContext
                                    .theme.customTheme.kSecondaryColor,
                                fontSize: width(16),
                                text: rentXContext.translate(" to 3 ")),
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
                          progressColor: rentXContext.theme.customTheme.primary,
                        ),
                        SizedBox(
                          height: height(30),
                        ),
                        Expanded(
                          child: PageView.builder(
                            controller: cubit.controller,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cubit.steps.length,
                            itemBuilder: (BuildContext context, int no) {
                              return cubit.steps[no];
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              )),
            ));
  }
}
