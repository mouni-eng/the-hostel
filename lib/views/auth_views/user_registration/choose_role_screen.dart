import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_hostel/models/signup_model.dart';
import 'package:the_hostel/size_config.dart';
import 'package:the_hostel/view_models/auth_cubit/cubit.dart';
import 'package:the_hostel/view_models/auth_cubit/states.dart';
import 'package:the_hostel/views/auth_views/user_registration/userRegistration.dart';
import 'package:the_hostel/views/components/base_widget.dart';
import 'package:the_hostel/views/components/components/custom_button.dart';
import 'package:the_hostel/views/components/components/custom_text.dart';

class ChooseRoleScreen extends StatelessWidget {
  const ChooseRoleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RentXWidget(
          builder: (rentxcontext) => BlocConsumer<AuthCubit, AuthStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  AuthCubit cubit = AuthCubit.get(context);
                  return SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: width(16),
                        vertical: height(16),
                      ),
                      child: Column(
                        children: [
                          CustomText(
                              color: rentxcontext.theme.customTheme.headline,
                              fontSize: width(24),
                              fontWeight: FontWeight.w600,
                              text: "Choose your role"),
                          SizedBox(
                            height: height(24),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CategoryCard(
                                svgAsset: "assets/images/peoples.svg",
                                rentxcontext: rentxcontext,
                                title: UserRole.student,
                              ),
                              CategoryCard(
                                svgAsset: "assets/images/peoples.svg",
                                rentxcontext: rentxcontext,
                                title: UserRole.owner,
                              ),
                            ],
                          ),
                          const Spacer(),
                          CustomButton(
                            fontSize: width(16),
                            btnWidth: double.infinity,
                            isUpperCase: false,
                            function: () {
                              cubit.signUpRequest.role = cubit.category;

                              rentxcontext
                                  .route((p0) => UserRegistrationLayout());
                            },
                            text: "Continue",
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard(
      {Key? key,
      required this.rentxcontext,
      required this.title,
      required this.svgAsset})
      : super(key: key);

  final RentXContext rentxcontext;
  final UserRole title;
  final String svgAsset;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        return GestureDetector(
          onTap: () {
            cubit.onChangeCategory(title);
          },
          child: Container(
            width: width(150),
            height: height(150),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                width: 3,
                color: cubit.category == title
                    ? rentxcontext.theme.customTheme.primary
                    : rentxcontext.theme.customTheme.outerBorder,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                title == UserRole.student
                    ? SvgPicture.asset(
                        "assets/images/people.svg",
                        width: width(38),
                        height: height(38),
                        color: cubit.category == title
                            ? rentxcontext.theme.customTheme.primary
                            : rentxcontext.theme.customTheme.headline3,
                      )
                    : SvgPicture.asset(
                        svgAsset,
                        width: width(38),
                        height: height(38),
                        color: cubit.category == title
                            ? rentxcontext.theme.customTheme.primary
                            : rentxcontext.theme.customTheme.headline3,
                      ),
                SizedBox(
                  height: height(10),
                ),
                CustomText(
                  color: cubit.category == title
                      ? rentxcontext.theme.customTheme.primary
                      : rentxcontext.theme.customTheme.headline3,
                  fontSize: width(16),
                  fontWeight: FontWeight.w600,
                  text: title.name,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
