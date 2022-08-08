import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:the_hostel/size_config.dart';
import 'package:the_hostel/views/components/base_widget.dart';
import 'package:the_hostel/views/components/components/custom_button.dart';
import 'package:the_hostel/views/components/components/custom_text.dart';

class VerifyOtpWidget extends StatelessWidget {
  const VerifyOtpWidget(
      {Key? key,
      this.loading,
      required this.formKey,
      required this.onSubmit,
      this.validator,
      this.email,
      this.onChanged,
      this.focusNode, this.phoneNumber})
      : super(key: key);

  final GlobalKey<FormState> formKey;
  final bool? loading;
  final Function() onSubmit;
  final FormFieldValidator<String>? validator;
  final String? email, phoneNumber;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return RentXWidget(builder: (rentXContext) {
      var pinTheme = PinTheme(
        width: width(49),
        height: height(48),
        textStyle: TextStyle(
          fontSize: width(16),
          color: rentXContext.theme.customTheme.headline,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: rentXContext.theme.customTheme.innerBorder,
          ),
          color: rentXContext.theme.customTheme.inputFieldFill,
        ),
      );
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image(
                  image: const AssetImage("assets/images/message.png"),
                  width: width(130),
                  height: height(130),
                ),
              ),
              SizedBox(
                height: height(30),
              ),
              CustomText(
                align: TextAlign.center,
                color: rentXContext.theme.customTheme.headline3,
                textOverflow: TextOverflow.clip,
                fontSize: width(16),
                text: rentXContext
                    .translate('Please enter the 6 digit code sent to ${email ?? phoneNumber}'),
              ),
              SizedBox(
                height: height(55),
              ),
              CustomText(
                  color: rentXContext.theme.customTheme.headline,
                  fontSize: width(14),
                  text: "Otp Verification"),
              SizedBox(
                height: height(8),
              ),
              Pinput(
                length: 6,
                pinAnimationType: PinAnimationType.scale,
                focusNode: focusNode,
                validator: validator,
                onChanged: onChanged,
                defaultPinTheme: pinTheme,
                focusedPinTheme: PinTheme(
                  width: width(49),
                  height: height(48),
                  textStyle: TextStyle(
                    fontSize: width(16),
                    color: rentXContext.theme.customTheme.headline,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: rentXContext.theme.customTheme.primary,
                    ),
                    color: rentXContext.theme.customTheme.inputFieldFill,
                  ),
                ),
                submittedPinTheme: pinTheme,
                followingPinTheme: pinTheme,
              ),
              SizedBox(
                height: height(14),
              ),
              Center(
                child: GestureDetector(
                    onTap: () {},
                    child: CustomText(
                      color: rentXContext.theme.customTheme.primary,
                      fontSize: width(14),
                      text: "Resend Code",
                    )),
              ),
              SizedBox(
                height: height(135),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  CustomButton(
                    showLoader: loading,
                    text: rentXContext.translate("Confirm"),
                    radius: 6,
                    fontSize: width(16),
                    btnWidth: width(132),
                    btnHeight: height(50),
                    function: onSubmit,
                    isUpperCase: false,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
