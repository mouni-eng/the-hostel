import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_hostel/constants.dart';
import 'package:the_hostel/infrastructure/utils.dart';
import 'package:the_hostel/models/booking_model.dart';
import 'package:the_hostel/size_config.dart';
import 'package:the_hostel/view_models/owner_cubit/cubit.dart';
import 'package:the_hostel/view_models/owner_cubit/states.dart';
import 'package:the_hostel/views/auth_views/user_login/login_view.dart';
import 'package:the_hostel/views/components/base_widget.dart';
import 'package:the_hostel/views/components/components/custom_button.dart';
import 'package:the_hostel/views/components/components/custom_text.dart';
import 'package:the_hostel/views/components/components/dot_badge.dart';
import 'package:the_hostel/views/components/components/price_tag.dart';
import 'package:the_hostel/views/components/components/rentx_circle_image.dart';
import 'package:the_hostel/views/owner_views/booking_details_view.dart';

class BookingView extends StatelessWidget {
  const BookingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RentXWidget(
        builder: (rentxcontext) => BlocConsumer<OwnerCubit, OwnerStates>(
            listener: (context, state) {},
            builder: (context, state) {
              OwnerCubit cubit = OwnerCubit.get(context);
              return Scaffold(
                body: SafeArea(
                  child: ConditionalBuilder(
                    condition: true,
                    fallback: (context) => const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                    builder: (context) => SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            color: rentxcontext.theme.customTheme.headline,
                            fontSize: width(24),
                            text: "Booking List",
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(
                            height: height(24),
                          ),
                          ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 3,
                            separatorBuilder: (context, index) => SizedBox(
                              height: height(25),
                            ),
                            itemBuilder: (context, index) =>
                                CustomBookingScreenCard(),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }));
  }
}

class CustomBookingScreenCard extends StatelessWidget {
  const CustomBookingScreenCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RentXWidget(
      builder: (rentxcontext) => BlocConsumer<OwnerCubit, OwnerStates>(
          listener: (context, state) {},
          builder: (context, state) {
            print(DateTime.tryParse("2022-07-09 22:02:30.905875"));
            return GestureDetector(
              onTap: () {
                rentxcontext.route((context) => BookingDetailsScreen());
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: width(16),
                  vertical: height(16),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: rentxcontext.theme.customTheme.onPrimary,
                  boxShadow: [boxShadow],
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RentXCircleImage(
                          imageSrc:
                              "https://th.bing.com/th/id/R.95e45a66c918a53280e796b44add2d66?rik=oVKQ59XBdewj8Q&pid=ImgRaw&r=0",
                          avatarLetters:
                              NameUtil.getInitials("Mohamed", "Mounir"),
                        ),
                        SizedBox(
                          width: width(14),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                color: rentxcontext.theme.customTheme.headline,
                                fontSize: width(16),
                                text: "Mohamed Mounir",
                                fontWeight: FontWeight.w600,
                              ),
                              SizedBox(
                                height: height(5),
                              ),
                              CustomText(
                                  color:
                                      rentxcontext.theme.customTheme.headline3,
                                  fontSize: width(14),
                                  text: "Passion Homes appartment"),
                              SizedBox(
                                height: height(10),
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/images/calendar.svg",
                                  ),
                                  SizedBox(
                                    width: width(8),
                                  ),
                                  CustomText(
                                    color: rentxcontext
                                        .theme.customTheme.headline2,
                                    fontSize: width(14),
                                    text: DateUtil.displayRange(
                                      DateTime.tryParse(
                                          "2022-07-09 22:02:30.905875")!,
                                      DateTime.now(),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 1.3,
                    ),
                    SizedBox(
                      height: height(10),
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: PriceTag(
                            price: "920",
                            duration: "month",
                            showDuration: true,
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/images/location.svg"),
                              SizedBox(
                                width: width(5),
                              ),
                              Expanded(
                                child: CustomText(
                                  fontSize: width(12),
                                  text:
                                      "Ashrafya compund, Fifth districtttttttttttttttttttttt",
                                  color:
                                      rentxcontext.theme.customTheme.headline3,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class RejectionDialog extends StatelessWidget {
  const RejectionDialog({Key? key, required this.bookings}) : super(key: key);

  final CompanyBooking bookings;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return RentXWidget(
      builder: (rentXContext) => BlocConsumer<OwnerCubit, OwnerStates>(
          listener: (context, state) {},
          builder: (context, state) {
            OwnerCubit cubit = OwnerCubit.get(context);
            return Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: width(10),
                      vertical: height(24),
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: width(23),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width(16)),
                      color: rentXContext.theme.customTheme.onPrimary,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: CustomText(
                              color: rentXContext.theme.customTheme.headline,
                              fontSize: width(16),
                              text: "rejectConfirmation",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: height(24),
                          ),
                          CustomText(
                            color: rentXContext.theme.customTheme.headline,
                            fontSize: width(14),
                            text: "reason",
                          ),
                          /*CustomDropdownSearch<String>(
                              showSearchBox: false,
                              entries: cubit.rejectionList,
                              onChange: (reason) =>
                                  cubit.chooseRejection(reason),
                              enabled: true,
                              selectedValue: cubit.rejectionModel,
                              validator: Validators.required,
                              label: 'selectReason'),*/
                          SizedBox(
                            height: height(24),
                          ),
                          PropertiesWidget(
                            title: "description",
                            isAboutMe: true,
                            onChange: (value) {
                              // cubit.onChangeDescription(value);
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: CustomText(
                                  color:
                                      rentXContext.theme.customTheme.headline2,
                                  fontSize: width(16),
                                  text: "cancel",
                                ),
                              ),
                              Container(
                                height: height(40),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: rentXContext.theme.customTheme.primary,
                                ),
                                child: CustomButton(
                                  btnHeight: height(40),
                                  btnWidth: width(99),
                                  fontSize: width(16),
                                  function: () {
                                    if (_formKey.currentState!.validate()) {
                                      // cubit.rejectConfirmation(bookings.id!);
                                      rentXContext.pop();
                                    }
                                  },
                                  text: "confirm",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}

class ApproveDialog extends StatelessWidget {
  const ApproveDialog({Key? key, required this.bookings}) : super(key: key);

  final CompanyBooking bookings;

  @override
  Widget build(BuildContext context) {
    return RentXWidget(
      builder: (rentXContext) => BlocConsumer<OwnerCubit, OwnerStates>(
          listener: (context, state) {},
          builder: (context, state) {
            OwnerCubit cubit = OwnerCubit.get(context);
            return Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: width(16),
                      vertical: height(10),
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: width(16),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: rentXContext.theme.customTheme.onPrimary,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/img/done.svg",
                        ),
                        SizedBox(
                          height: height(16),
                        ),
                        CustomText(
                            color: rentXContext.theme.customTheme.headline,
                            align: TextAlign.center,
                            maxlines: 2,
                            fontSize: width(14),
                            text: "approveBooking.question"),
                        SizedBox(
                          height: height(16),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: CustomText(
                                color: rentXContext.theme.customTheme.headline2,
                                fontSize: width(16),
                                text: "cancel",
                              ),
                            ),
                            SizedBox(
                              width: width(16),
                            ),
                            Container(
                              height: height(40),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: rentXContext.theme.customTheme.primary,
                              ),
                              child: CustomButton(
                                btnHeight: height(40),
                                btnWidth: width(70),
                                fontSize: width(16),
                                function: () {
                                  // cubit.approveConfirmation(bookings.id!);
                                  rentXContext.pop();
                                },
                                text: "Yes",
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
