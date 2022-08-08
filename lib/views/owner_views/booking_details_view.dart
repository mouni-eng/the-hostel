import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_hostel/constants.dart';
import 'package:the_hostel/infrastructure/utils.dart';
import 'package:the_hostel/models/booking_model.dart';
import 'package:the_hostel/size_config.dart';
import 'package:the_hostel/view_models/owner_cubit/cubit.dart';
import 'package:the_hostel/views/components/base_widget.dart';
import 'package:the_hostel/views/components/components/back_button.dart';
import 'package:the_hostel/views/components/components/custom_button.dart';
import 'package:the_hostel/views/components/components/custom_text.dart';
import 'package:the_hostel/views/components/components/price_tag.dart';
import 'package:the_hostel/views/components/components/rentx_circle_image.dart';
import 'package:the_hostel/views/owner_views/booking_view.dart';

class BookingDetailsScreen extends StatelessWidget {
  const BookingDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RentXWidget(
      builder: (rentxcontext) => Scaffold(
          body: SafeArea(
              child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width(16),
            vertical: height(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  BackButtonWidget(
                    onTap: () {
                      rentxcontext.pop();
                    },
                    rentxcontext: rentxcontext,
                  ),
                  SizedBox(
                    width: width(16),
                  ),
                  CustomText(
                    color: rentxcontext.theme.customTheme.headline,
                    fontSize: width(22),
                    text: "Booking Details",
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              SizedBox(
                height: height(30),
              ),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                RentXCircleImage(
                  imageSrc: /*model.user!.imageUrl ?? model.user!.imageUrl*/ "https://th.bing.com/th/id/R.95e45a66c918a53280e796b44add2d66?rik=oVKQ59XBdewj8Q&pid=ImgRaw&r=0",
                  avatarLetters: NameUtil.getInitials("Mohamed", "Mounir"),
                ),
                SizedBox(
                  width: width(14),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      color: rentxcontext.theme.customTheme.headline,
                      fontSize: width(16),
                      text: "Mohamed Mounir",
                      fontWeight: FontWeight.w600,
                    ),
                    CustomText(
                      color: rentxcontext.theme.customTheme.headline3,
                      fontSize: width(14),
                      text: "estherhoward@gmail.com",
                    ),
                    SizedBox(
                      height: height(10),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset("assets/images/Calling.svg"),
                        SizedBox(
                          width: width(8),
                        ),
                        CustomText(
                          color: rentxcontext.theme.customTheme.primary,
                          fontSize: width(12),
                          text: "(704) 555-0127",
                        ),
                      ],
                    ),
                  ],
                ),
              ]),
              SizedBox(
                height: height(10),
              ),
              const Divider(
                thickness: 1.3,
              ),
              SizedBox(
                height: height(10),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    color: rentxcontext.theme.customTheme.headline,
                    fontSize: width(18),
                    text: "Price Details",
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: height(14),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        color: rentxcontext.theme.customTheme.headline3,
                        fontSize: width(16),
                        text: "Price",
                      ),
                      Row(
                        children: [
                          PriceTag(
                            showDuration: true,
                            duration: "mon",
                            price: "100",
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height(8),
                  ),
                  Column(
                    children: List.generate(
                      1,
                      (index) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            color: rentxcontext.theme.customTheme.headline3,
                            fontSize: width(16),
                            text: FeesType.serviceFee.name,
                          ),
                          const PriceTag(
                            price: "100",
                            showDuration: false,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height(8),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        color: rentxcontext.theme.customTheme.headline,
                        fontSize: width(16),
                        text: "Total Price (USD)",
                        fontWeight: FontWeight.w600,
                      ),
                      const PriceTag(
                        price: "920",
                        showDuration: false,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: height(10),
              ),
              const Divider(
                thickness: 1.3,
              ),
              SizedBox(
                height: height(10),
              ),
              SizedBox(
                height: height(80),
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      radius: 8,
                      background: rentxcontext.theme.customTheme.onRejected,
                      text: "reject",
                      function: () {
                        /*showDialog(
                          context: context,
                          builder: (context) => RejectionDialog(
                            bookings: model,
                          ),
                        );*/
                      },
                      fontSize: width(12),
                      isUpperCase: false,
                    ),
                  ),
                  SizedBox(
                    width: width(24),
                  ),
                  Expanded(
                    child: CustomButton(
                      radius: 8,
                      background: rentxcontext.theme.customTheme.primary,
                      text: "approve",
                      function: () {
                        /*showDialog(
                          context: context,
                          builder: (context) => ApproveDialog(
                            bookings: model,
                          ),
                        );*/
                      },
                      fontSize: width(12),
                      isUpperCase: false,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ))),
    );
  }
}
