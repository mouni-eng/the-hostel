import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:the_hostel/constants.dart';
import 'package:the_hostel/size_config.dart';
import 'package:the_hostel/views/components/base_widget.dart';
import 'package:the_hostel/views/components/components/back_button.dart';
import 'package:the_hostel/views/components/components/custom_text.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RentXWidget(
        builder: (rentxcontext) => Scaffold(
              body: SafeArea(
                  child: Padding(
                padding: padding,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CustomBorderWidget(
                            rentxcontext: rentxcontext,
                            iconData: const Icon(Icons.arrow_back_ios_new),
                            onTap: () {
                              rentxcontext.pop();
                            },
                          ),
                          SizedBox(
                            width: width(15),
                          ),
                          CustomText(
                            fontSize: width(20),
                            text: "Notification Center",
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height(300),
                      ),
                      CustomText(
                        fontSize: width(22),
                        text: "No Available Notifications",
                        color: rentxcontext.theme.customTheme.headline3,
                      ),
                    ],
                  ),
                ),
              )),
            ));
  }
}
