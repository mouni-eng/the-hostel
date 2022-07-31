import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_hostel/models/onBoarding_model.dart';
import 'package:the_hostel/view_models/onBoarding_cubit/states.dart';

class OnBoardingCubit extends Cubit<OnBoardingStates> {
  OnBoardingCubit() : super(OnBoardingStates());

  static OnBoardingCubit get(context) => BlocProvider.of(context);

  PageController controller = PageController();

  bool isLast = false;

  int index = 0;

  List<OnBoardingModel> onBoardingList = [
    OnBoardingModel(
      title: "Real estate offer",
      image: "assets/images/students.svg",
      subTitle: "Thousands of real estate offers in your area",
    ),
    OnBoardingModel(
      title: "Looking for a place to stay!",
      image: "assets/images/searching.svg",
      subTitle:
          "Through the hostel you can rent a whole apartment or stay with others and rent a room or even a bed",
    ),
    OnBoardingModel(
      title: "Need a transportation!",
      image: "assets/images/transportation.svg",
      subTitle:
          "We provide several transportation options, to take you from your main home to the hostel home every week and also take you to your university daily",
    ),
  ];

  onBackStep() {
    index -= 1;
    isLast = false;
    emit(OnBackRegistrationStep());

    controller.previousPage(
        duration: const Duration(
          milliseconds: 750,
        ),
        curve: Curves.fastLinearToSlowEaseIn);
  }

  onNextStep() {
    index += 1;
    if (index == 2) {
      isLast = true;
    }
    emit(OnNextRegistrationStep());
    controller.nextPage(
        duration: const Duration(
          milliseconds: 750,
        ),
        curve: Curves.fastLinearToSlowEaseIn);
  }
}
