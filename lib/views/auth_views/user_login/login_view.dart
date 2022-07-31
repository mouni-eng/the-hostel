import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_hostel/constants.dart';
import 'package:the_hostel/services/alert_service.dart';
import 'package:the_hostel/size_config.dart';
import 'package:the_hostel/view_models/auth_cubit/cubit.dart';
import 'package:the_hostel/view_models/auth_cubit/states.dart';
import 'package:the_hostel/views/auth_views/passwordReset_screen.dart';
import 'package:the_hostel/views/auth_views/user_registration/choose_role_screen.dart';
import 'package:the_hostel/views/components/base_widget.dart';
import 'package:the_hostel/views/components/components/custom_button.dart';
import 'package:the_hostel/views/components/components/custom_form_field.dart';
import 'package:the_hostel/views/components/components/custom_text.dart';
import 'package:the_hostel/views/student_views/layout_view.dart';

class LogInView extends StatelessWidget {
  const LogInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RentXWidget(
      builder: (rentxcontext) =>
          BlocConsumer<AuthCubit, AuthStates>(listener: (context, state) {
        if (state is LogInErrorState) {
          AlertService.showSnackbarAlert(
              state.error.toString(), rentxcontext, SnackbarType.error);
        } else if (state is LogInSuccessState) {
          rentxcontext.route((context) => const StudentLayoutView());
        }
      }, builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        return Scaffold(
          body: SafeArea(
              child: Padding(
            padding: padding,
            child: Form(
                key: cubit.formkey,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height(18),
                      ),
                      Center(
                        child: SvgPicture.asset(
                          "assets/images/logIn.svg",
                          width: width(235),
                          height: height(165),
                        ),
                      ),
                      SizedBox(
                        height: height(25),
                      ),
                      CustomText(
                        color: rentxcontext.theme.customTheme.headline,
                        fontSize: width(28),
                        text: "login",
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(
                        height: height(10),
                      ),
                      CustomText(
                        color: rentxcontext.theme.customTheme.headline3,
                        fontSize: width(14),
                        text: "Welcome back! Please enter your details.",
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(
                        height: height(35),
                      ),
                      PropertiesWidget(
                        title: "Username",
                        textEditingController: cubit.userNameController,
                        onChange: (value) {
                          cubit.onChangeEmailAddress(value);
                        },
                      ),
                      PropertiesWidget(
                        title: "Password",
                        onChange: (value) {
                          cubit.onChangePassword(value);
                        },
                        isPassword: true,
                        textEditingController: cubit.userPasswordController,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                          onTap: () {
                            rentxcontext.route(
                                (context) => const PasswordResetScreen());
                          },
                          child: CustomText(
                            color: rentxcontext.theme.customTheme.primary,
                            fontSize: width(14),
                            text: "forgot Password?",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height(24),
                      ),
                      CustomButton(
                        showLoader: state is LogInLoadingState,
                        fontSize: width(16),
                        isUpperCase: false,
                        function: () {
                          cubit.logIn();
                        },
                        text: "logIn",
                      ),
                      SizedBox(
                        height: height(35),
                      ),
                      Row(
                        children: [
                          const Expanded(
                            child: Divider(
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: width(12),
                            ),
                            child: CustomText(
                              color: rentxcontext.theme.customTheme.headline3,
                              fontSize: width(14),
                              text: "or",
                            ),
                          ),
                          const Expanded(
                            child: Divider(
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height(22),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            color: rentxcontext.theme.customTheme.headline2,
                            fontSize: width(14),
                            text: "Dont Have An Account?",
                          ),
                          GestureDetector(
                            onTap: () {
                              rentxcontext
                                  .route((p0) => const ChooseRoleScreen());
                            },
                            child: CustomText(
                              color: rentxcontext.theme.customTheme.primary,
                              fontSize: width(14),
                              text: " Register Now",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          )),
        );
      }),
    );
  }
}

class PropertiesWidget extends StatelessWidget {
  const PropertiesWidget(
      {Key? key,
      required this.title,
      this.textEditingController,
      this.onChange,
      this.validate,
      this.isPassword = false,
      this.isAboutMe = false,
      this.isPhoneNumber = false})
      : super(key: key);

  final String? title;
  final TextEditingController? textEditingController;
  final void Function(String)? onChange;
  final String? Function(String?)? validate;
  final bool isPassword, isAboutMe, isPhoneNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          fontSize: width(16),
          text: title!,
        ),
        SizedBox(
          height: height(15),
        ),
        CustomFormField(
          context: context,
          controller: textEditingController,
          onChange: onChange,
          hintText: "Enter here",
          validate: validate,
          type: isPhoneNumber == true
              ? TextInputType.number
              : TextInputType.emailAddress,
          isPassword: isPassword,
          isAboutMe: isAboutMe,
        ),
        SizedBox(
          height: height(25),
        ),
      ],
    );
  }
}
