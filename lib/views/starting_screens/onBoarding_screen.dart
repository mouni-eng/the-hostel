import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:the_hostel/size_config.dart';
import 'package:the_hostel/view_models/onBoarding_cubit/cubit.dart';
import 'package:the_hostel/view_models/onBoarding_cubit/states.dart';
import 'package:the_hostel/views/auth_views/user_login/login_view.dart';
import 'package:the_hostel/views/components/base_widget.dart';
import 'package:the_hostel/views/components/components/custom_button.dart';
import 'package:the_hostel/views/components/components/custom_text.dart';
import 'package:the_hostel/views/components/components/onBoarding_widget.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: RentXWidget(
        builder: (rentxcontext) => SafeArea(
            child: BlocConsumer<OnBoardingCubit, OnBoardingStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  OnBoardingCubit cubit = OnBoardingCubit.get(context);
                  var color = rentxcontext.theme.customTheme;
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: width(16),
                      vertical: height(16),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SmoothPageIndicator(
                              controller: cubit.controller,
                              count: 3,
                              effect: ExpandingDotsEffect(
                                dotColor: color.kSecondaryColor,
                                activeDotColor: color.primary,
                                dotHeight: height(7),
                                expansionFactor: 4,
                                dotWidth: width(7),
                                spacing: 5.0,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                rentxcontext
                                    .route((context) => const LogInView());
                              },
                              child: CustomText(
                                fontSize: width(16),
                                text: "Skip",
                                color: color.headline,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: PageView.builder(
                            controller: cubit.controller,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cubit.onBoardingList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return OnBoardingBuilder(
                                  model: cubit.onBoardingList[index]);
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (cubit.index != 0)
                              TextButton(
                                  onPressed: () {
                                    cubit.onBackStep();
                                  },
                                  child: Text(
                                    "Back",
                                    style: TextStyle(
                                      fontSize: width(16),
                                      color: color.headline,
                                    ),
                                  )),
                            if (cubit.index == 0) Container(),
                            CustomButton(
                              btnHeight: height(50),
                              btnWidth: width(100),
                              fontSize: width(18),
                              radius: 8,
                              function: () {
                                if (cubit.index != 2) {
                                  cubit.onNextStep();
                                } else {
                                  rentxcontext
                                      .route((context) => const LogInView());
                                }
                              },
                              text: cubit.index != 2 ? "Next" : "Start",
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                })),
      ),
    );
  }
}
