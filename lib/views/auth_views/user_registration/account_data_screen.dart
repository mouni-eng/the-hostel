import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_hostel/size_config.dart';
import 'package:the_hostel/view_models/auth_cubit/cubit.dart';
import 'package:the_hostel/view_models/auth_cubit/states.dart';
import 'package:the_hostel/views/auth_views/user_login/login_view.dart';
import 'package:the_hostel/views/components/base_widget.dart';
import 'package:the_hostel/views/components/components/custom_button.dart';
import 'package:the_hostel/views/components/components/custom_text.dart';

class AccountDataScreen extends StatelessWidget {
  const AccountDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RentXWidget(
      builder: (rentxcontext) =>
        BlocConsumer<AuthCubit, AuthStates>(
          builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: cubit.formKey2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PropertiesWidget(
                  title: "Username",
                  validate: (val) => cubit.usernameValidation,
                  onChange: (value) {
                    cubit.onChangeUserName(value);
                  },
                ),
                PropertiesWidget(
                  title: "Email Address",
                  validate: (val) => cubit.emailValidation,
                  onChange: (value) {
                    cubit.onChangeEmailAddress(value);
                  },
                ),
                PropertiesWidget(
                  title: "Password",
                  isPassword: true,
                  onChange: (value) {
                    cubit.onChangePassword(value);
                  },
                ),
                PropertiesWidget(
                  isPassword: true,
                  title: "Confirm Password",
                  onChange: (value) {
                    cubit.onChangeConfirmPassword(value);
                  },
                ),
                if (cubit.password != cubit.confirmPassword)
                  CustomText(
                    color: rentxcontext.theme.customTheme.onRejected,
                    fontSize: width(12),
                    text: rentxcontext.translate("Password Dont Match"),
                ),
                  SizedBox(
                  height: height(115),
                  ),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          cubit.onBackStep();
                        },
                        child: Text(
                          rentxcontext.translate("Back"),
                          style: TextStyle(
                            fontSize: width(16),
                            color: rentxcontext.theme.customTheme.headline,
                          ),
                        )),
                    CustomButton(
                      showLoader: state is RegisterLoadingState,
                      text: rentxcontext.translate("Next"),
                      radius: 6,
                      fontSize: width(16),
                      btnWidth: width(132),
                      btnHeight: height(50),
                      function: () {
                        cubit.onNextValidation(context);
                      },
                      isUpperCase: false,
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      }, listener: (context, state) {
        AuthCubit.get(context).formKey2.currentState!.validate();
        if (state is RegisterErrorState) {
          // ErrorService.showSnackbarError(11
          //   state.error ?? 'unknownError',
          //   rentxcontext,
          //   SnackbarType.error,
          // );
        }
      }),
    );
  }
}
