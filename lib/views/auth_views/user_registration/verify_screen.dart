import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_hostel/services/alert_service.dart';
import 'package:the_hostel/view_models/auth_cubit/cubit.dart';
import 'package:the_hostel/view_models/auth_cubit/states.dart';
import 'package:the_hostel/view_models/location_cubit/cubit.dart';
import 'package:the_hostel/views/auth_views/user_registration/address_selection.dart';
import 'package:the_hostel/views/components/base_widget.dart';
import 'package:the_hostel/views/components/components/verify_otp_component.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RentXWidget(
      builder: (rentxcontext) => BlocConsumer<AuthCubit, AuthStates>(
        builder: (context, state) {
          AuthCubit cubit = AuthCubit.get(context);
          return VerifyOtpWidget(
              loading: state is OtpConfirmedLoadingState,
              validator: (value) {
                if (value == null && value!.length < 6) {
                  return 'required';
                }
              },
              onChanged: cubit.onChangePin,
              phoneNumber: cubit.phoneNumber!,
              focusNode: cubit.focusNode,
              formKey: cubit.formKey3,
              onSubmit: () {
                cubit.onNextValidation(context);
              });
        },
        listener: (context, state) {
          if (state is OtpConfirmedErrorState) {
            AlertService.showSnackbarAlert(
                state.error!, rentxcontext, SnackbarType.error);
          } else if (state is CodeSentState) {
            AlertService.showSnackbarAlert(
              "Code Sent!",
              rentxcontext,
              SnackbarType.warning,
            );
          } else if (state is OtpConfirmedSuccessState) {
            rentxcontext.route((context) => AddressSelection(),);
          }
        },
      ),
    );
  }
}
