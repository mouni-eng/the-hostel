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
      image: "assets/images/listing.svg",
      subTitle: "Thousands of real estate offers in your area",
    ),
    OnBoardingModel(
      title: "Research your house",
      image: "assets/images/searching.svg",
      subTitle:
          "Very easy way of selection and searching on the map for any requirement",
    ),
    OnBoardingModel(
      title: "Ready renting your house",
      image: "assets/images/deal.svg",
      subTitle:
          "You select only the proper apartment for your requirements before you purchase",
    ),
  ];

  onPageChanged() {
    isLast = false;
  }

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
