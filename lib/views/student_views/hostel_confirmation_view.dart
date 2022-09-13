import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_hostel/constants.dart';
import 'package:the_hostel/infrastructure/utils.dart';
import 'package:the_hostel/models/appartment_model.dart';
import 'package:the_hostel/models/booking_model.dart';
import 'package:the_hostel/size_config.dart';
import 'package:the_hostel/view_models/hostel_details_cubit/cubit.dart';
import 'package:the_hostel/view_models/hostel_details_cubit/state.dart';
import 'package:the_hostel/views/components/base_widget.dart';
import 'package:the_hostel/views/components/components/back_button.dart';
import 'package:the_hostel/views/components/components/confirmation_widget.dart';
import 'package:the_hostel/views/components/components/custom_button.dart';
import 'package:the_hostel/views/components/components/custom_text.dart';
import 'package:the_hostel/views/components/components/price_tag.dart';
import 'package:the_hostel/views/components/components/rentalPropertyWidget.dart';
import 'package:the_hostel/views/student_views/layout_view.dart';

class HostelConfirmationView extends StatelessWidget {
  const HostelConfirmationView({Key? key, required this.appartmentModel})
      : super(key: key);

  final AppartmentModel appartmentModel;

  @override
  Widget build(BuildContext context) {
    return RentXWidget(builder: (rentxcontext) {
      var color = rentxcontext.theme.customTheme;
      return BlocConsumer<HostelDetailsCubit, HostelDetailsStates>(
        listener: (context, state) {
          if (state is AddBookingSuccessStateState) {
            rentxcontext.route((context) => CompletedScreen(
                text: "Your Hostel is booked succesfully",
                onBtnClick: () {
                  rentxcontext.route((context) => StudentLayoutView());
                }));
          }
        },
        builder: (context, state) {
          HostelDetailsCubit cubit = HostelDetailsCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: padding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                            fontSize: width(22),
                            text: "Confirm Booking",
                            fontWeight: FontWeight.w600,
                            color: color.headline,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height(25),
                      ),
                      Container(
                        width: double.infinity,
                        padding: padding,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: color.onPrimary,
                            border: Border.all(
                              color: color.inputFieldBorder,
                            )),
                        child: Row(
                          children: [
                            CustomNetworkImage(
                              imgWidth: 100,
                              imgHeight: 120,
                              url: appartmentModel.images.isNotEmpty
                                  ? appartmentModel.images[0]
                                  : "",
                            ),
                            SizedBox(
                              width: width(10),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    fontSize: width(18),
                                    text: appartmentModel.name!,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  SizedBox(height: height(10)),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                          "assets/images/location.svg"),
                                      SizedBox(
                                        width: width(5),
                                      ),
                                      Expanded(
                                        child: CustomText(
                                          fontSize: width(12),
                                          text: appartmentModel.address!
                                              .fullAddress(),
                                          color: rentxcontext
                                              .theme.customTheme.headline3,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height(10),
                                  ),
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.meeting_room_outlined,
                                            color: color.headline3,
                                            size: height(25),
                                          ),
                                          CustomText(
                                            fontSize: width(12),
                                            text: appartmentModel.bedrooms
                                                .toString(),
                                            color: color.headline,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: width(15),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.bed_outlined,
                                            color: color.headline3,
                                            size: height(25),
                                          ),
                                          CustomText(
                                            fontSize: width(12),
                                            text: appartmentModel.capacity
                                                .toString(),
                                            color: color.headline,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: width(15),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.bathroom_outlined,
                                            color: color.headline3,
                                            size: height(25),
                                          ),
                                          CustomText(
                                            fontSize: width(12),
                                            text: appartmentModel.bathroom
                                                .toString(),
                                            color: color.headline,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: height(10)),
                                  PriceTag(
                                    price: appartmentModel.price.toString(),
                                    showDuration: true,
                                    duration: HostelDuration
                                        .values[appartmentModel.duration!.index]
                                        .name,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height(15),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: width(16),
                          vertical: height(16),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: color.onPrimary,
                          boxShadow: [
                            boxShadow,
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              fontSize: width(20),
                              text: "Your Invoice",
                              fontWeight: FontWeight.w600,
                            ),
                            SizedBox(
                              height: height(35),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  fontSize: width(18),
                                  text: "Price",
                                  fontWeight: FontWeight.w600,
                                ),
                                PriceTag(
                                  showDuration: true,
                                  price: appartmentModel.price.toString(),
                                  duration: appartmentModel.duration!.name,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height(25),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  fontSize: width(18),
                                  text: "Rent type",
                                  fontWeight: FontWeight.w600,
                                ),
                                CustomText(
                                  fontSize: width(16),
                                  text: cubit.booking.rentType == null
                                      ? Rent.appartment.name
                                      : cubit.booking.rentType!.name,
                                  fontWeight: FontWeight.w600,
                                  color: color.primary,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height(25),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  fontSize: width(18),
                                  text: "No. of Days",
                                  fontWeight: FontWeight.w600,
                                ),
                                CustomText(
                                  fontSize: width(16),
                                  text: DateUtil.displayDiffrence(
                                      cubit.rangeStart!, cubit.rangeEnd!),
                                  fontWeight: FontWeight.w600,
                                  color: color.primary,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height(25),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  fontSize: width(18),
                                  text: "From - To",
                                  fontWeight: FontWeight.w600,
                                ),
                                CustomText(
                                  fontSize: width(16),
                                  text: DateUtil.displayRange(
                                      cubit.rangeStart!, cubit.rangeEnd!),
                                  fontWeight: FontWeight.w600,
                                  color: color.primary,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height(25),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  fontSize: width(18),
                                  text: "Service Fee",
                                  fontWeight: FontWeight.w600,
                                ),
                                const PriceTag(
                                  price: "0",
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height(25),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  fontSize: width(18),
                                  text: "Total Price",
                                  fontWeight: FontWeight.w600,
                                ),
                                PriceTag(
                                  price: DateUtil.totalPrice(
                                          from: cubit.rangeStart!,
                                          to: cubit.rangeEnd!,
                                          duration: appartmentModel.duration!,
                                          type: cubit.booking.rentType ??
                                              Rent.appartment,
                                          price: appartmentModel.price!)
                                      .toString(),
                                  showDuration: false,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height(40),
                      ),
                      CustomButton(
                        btnWidth: double.infinity,
                        showLoader: state is AddBookingLoadingStateState,
                        fontSize: width(16),
                        function: () {
                          cubit.onChoosePayment(
                            fees: Fees(type: FeesType.serviceFee, value: 0),
                            pricePerDay: appartmentModel.price!,
                            totalPrice: DateUtil.totalPrice(
                                from: cubit.rangeStart!,
                                to: cubit.rangeEnd!,
                                duration: appartmentModel.duration!,
                                type: cubit.booking.rentType ?? Rent.appartment,
                                price: appartmentModel.price!),
                          );
                          cubit.addBooking(appartmentModel: appartmentModel);
                        },
                        text: "Procced to CheckOut",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
