import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_hostel/constants.dart';
import 'package:the_hostel/models/review_model.dart';
import 'package:the_hostel/services/apartment_service.dart';
import 'package:the_hostel/size_config.dart';
import 'package:the_hostel/view_models/home_cubit/cubit.dart';
import 'package:the_hostel/view_models/home_cubit/state.dart';
import 'package:the_hostel/views/auth_views/user_login/login_view.dart';
import 'package:the_hostel/views/components/base_widget.dart';
import 'package:the_hostel/views/components/components/back_button.dart';
import 'package:the_hostel/views/components/components/custom_button.dart';
import 'package:the_hostel/views/components/components/custom_text.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingView extends StatelessWidget {
  RatingView({Key? key}) : super(key: key);

  final GlobalKey<FormState> ratingKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return RentXWidget(
        builder: (rentxcontext) => BlocConsumer<HomeCubit, HomeStates>(
            listener: (context, state) {},
            builder: (context, state) {
              HomeCubit cubit = HomeCubit.get(context);
              return Scaffold(
                resizeToAvoidBottomInset: false,
                body: SafeArea(
                    child: Padding(
                  padding: padding,
                  child: Form(
                    key: ratingKey,
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
                              text: "Leave Rate and Review",
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height(35),
                        ),
                        RatingBar.builder(
                          initialRating: 3,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            cubit.onChangeRating(rating);
                          },
                        ),
                        SizedBox(
                          height: height(25),
                        ),
                        PropertiesWidget(
                          title: "Review",
                          isAboutMe: true,
                          onChange: (value) {
                            cubit.onChangeReview(value);
                          },
                        ),
                        Spacer(),
                        CustomButton(
                          btnWidth: double.infinity,
                          fontSize: width(14),
                          showLoader: state is AddRatingLoadingState,
                          function: () async {
                            if (ratingKey.currentState!.validate()) {
                              await cubit.addRating();
                              Navigator.pop(context);
                            }
                          },
                          text: "Submit",
                        ),
                      ],
                    ),
                  ),
                )),
              );
            }));
  }
}
