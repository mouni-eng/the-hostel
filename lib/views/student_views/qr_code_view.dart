import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:the_hostel/constants.dart';
import 'package:the_hostel/size_config.dart';
import 'package:the_hostel/views/components/base_widget.dart';
import 'package:the_hostel/views/components/components/back_button.dart';
import 'package:the_hostel/views/components/components/custom_text.dart';

class QrCodeGeneratorView extends StatelessWidget {
  const QrCodeGeneratorView({Key? key, required this.qrCode}) : super(key: key);

  final String qrCode;

  @override
  Widget build(BuildContext context) {
    return RentXWidget(builder: (rentxcontext) {
      var color = rentxcontext.theme.customTheme;
      return Scaffold(
          body: Padding(
        padding: padding,
        child: SafeArea(
            child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  CustomBorderWidget(
                    rentxcontext: rentxcontext,
                    iconData: const Icon(Icons.arrow_back_ios),
                    onTap: () {
                      rentxcontext.pop();
                    },
                  ),
                  SizedBox(
                    width: width(15),
                  ),
                  CustomText(
                    fontSize: width(20),
                    text: "Scan your apartment QR code",
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              SizedBox(
                height: height(35),
              ),
              CustomText(
                fontSize: width(18),
                text:
                    "After scanning your QR code from the hostel owner your booking will be marked as completed",
                fontWeight: FontWeight.w400,
                maxlines: 3,
                align: TextAlign.center,
                color: color.headline3,
              ),
              SizedBox(
                height: height(45),
              ),
              QrImage(
                data: qrCode,
                size: width(250),
              ),
            ],
          ),
        )),
      ));
    });
  }
}
