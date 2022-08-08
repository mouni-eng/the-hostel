import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:the_hostel/models/appartment_model.dart';
import 'package:the_hostel/view_models/add_property_cubit/states.dart';
import 'package:the_hostel/views/owner_views/property_listing/additional_info_view.dart';
import 'package:the_hostel/views/owner_views/property_listing/appartment_info_view.dart';
import 'package:the_hostel/views/owner_views/property_listing/basic_info_view.dart';

class AddPropertyCubit extends Cubit<AddPropertyStates> {
  AddPropertyCubit() : super(AddPropertyStates());

  static AddPropertyCubit get(context) => BlocProvider.of(context);

  int index = 0;
  bool isLast = false;
  double percent = 1 / 3;
  final GlobalKey basicFormkey = GlobalKey<FormState>();

  PageController controller = PageController();

  int? featured;

  List<File> images = [];

  var picker = ImagePicker();

  chooseImage(File file) async {
    images.add(file);
    emit(OnChangePropertyState());
  }

  updateImageFeatured(int index) {
    featured = index;
    emit(OnChangePropertyState());
  }

  List<Widget> steps = [
    BasicInfo(),
    ApartmentInfoView(),
    AdditionalInfoView(),
  ];

  List<String> header = [
    "Basic Info",
    "Apartment Info",
    "Additional Info",
  ];
  HostelDuration? duration;
  String? name, description;
  double? price;
  int? floor, rooms, bathrooms, capacity;
  Elevation? elevation;
  Rent? rent;

  onChooseDuration(HostelDuration value) {
    duration = value;
    emit(OnChangePropertyState());
  }

  onChooseElevation(Elevation value) {
    elevation = value;
    emit(OnChangePropertyState());
  }

  onChooseRent(Rent value) {
    rent = value;
    emit(OnChangePropertyState());
  }

  onChoosename(String value) {
    name = value;
    emit(OnChangePropertyState());
  }

  onChoosedescription(String value) {
    description = value;
    emit(OnChangePropertyState());
  }

  onChoosePrice(double value) {
    price = value;
    emit(OnChangePropertyState());
  }

  onChoosefloor(int value) {
    floor = value;
    emit(OnChangePropertyState());
  }

  onChooserooms(int value) {
    rooms = value;
    emit(OnChangePropertyState());
  }

  onChoosebathrooms(int value) {
    bathrooms = value;
    emit(OnChangePropertyState());
  }

  onChoosecapacity(int value) {
    capacity = value;
    emit(OnChangePropertyState());
  }

  onBackStep() {
    if (percent != 1 / 3) {
      percent -= 1 / 3;
      index -= 1;
      isLast = false;
      emit(OnChangePropertyState());
    }

    controller.previousPage(
        duration: const Duration(
          milliseconds: 750,
        ),
        curve: Curves.fastLinearToSlowEaseIn);
  }

  onNextStep() {
    if (percent != 1) {
      percent += 1 / 3;
      index += 1;
      if (index == 2) {
        isLast = true;
      }
      emit(OnChangePropertyState());
    }
    controller.nextPage(
        duration: const Duration(
          milliseconds: 750,
        ),
        curve: Curves.fastLinearToSlowEaseIn);
  }

  onAddBedFeatures(int value) {
    bedFeatures[value].selected = !bedFeatures[value].selected;
    emit(OnChangePropertyState());
  }

  onAddbathroomFeatures(int value) {
    bathroomFeatures[value].selected = !bathroomFeatures[value].selected;
    emit(OnChangePropertyState());
  }

  onAddkitchenFeatures(int value) {
    kitchenFeatures[value].selected = !kitchenFeatures[value].selected;
    emit(OnChangePropertyState());
  }

  onAddheatingAndCoolingFeatures(int value) {
    heatingAndCooling[value].selected = !heatingAndCooling[value].selected;
    emit(OnChangePropertyState());
  }

  List<BedFeaturesClass> bedFeatures = [
    BedFeaturesClass(
      featuretype: BedFeatures.pellowsblankets,
      value: 'Pellows & Blankets',
    ),
    BedFeaturesClass(
      featuretype: BedFeatures.cover,
      value: 'Cover',
    ),
    BedFeaturesClass(
      featuretype: BedFeatures.iron,
      value: 'Iron',
    ),
    BedFeaturesClass(
      featuretype: BedFeatures.closet,
      value: 'Closet',
    ),
    BedFeaturesClass(
      featuretype: BedFeatures.hangers,
      value: 'Hangers',
    ),
  ];
  List<KitchenFeaturesClass> kitchenFeatures = [
    KitchenFeaturesClass(
      featuretype: KitchenFeatures.microwave,
      value: "Microwave",
    ),
    KitchenFeaturesClass(
      featuretype: KitchenFeatures.fridge,
      value: "Fridge",
    ),
    KitchenFeaturesClass(
      featuretype: KitchenFeatures.cooker,
      value: "Cooker",
    ),
    KitchenFeaturesClass(
      featuretype: KitchenFeatures.kettle,
      value: "Kettle",
    ),
    KitchenFeaturesClass(
      featuretype: KitchenFeatures.blender,
      value: "Blender",
    ),
    KitchenFeaturesClass(
      featuretype: KitchenFeatures.washer,
      value: "Dish washer",
    ),
    KitchenFeaturesClass(
      featuretype: KitchenFeatures.table,
      value: "Eating table",
    ),
    KitchenFeaturesClass(
      featuretype: KitchenFeatures.dishes,
      value: "Dishes",
    ),
    KitchenFeaturesClass(
      featuretype: KitchenFeatures.naturalgas,
      value: "Natural gas",
    ),
  ];
  List<BathroomFeaturesClass> bathroomFeatures = [
    BathroomFeaturesClass(
        featuretype: BathroomFeatures.hotwater, value: "Hot water"),
    BathroomFeaturesClass(
        featuretype: BathroomFeatures.hairdryer, value: "Hair dryer"),
    BathroomFeaturesClass(
        featuretype: BathroomFeatures.bathtub, value: "Bathtub"),
    BathroomFeaturesClass(
        featuretype: BathroomFeatures.washer, value: "Washer"),
  ];
  List<HeatingAndCoolingClass> heatingAndCooling = [
    HeatingAndCoolingClass(
        featuretype: HeatingAndCooling.airconditioning,
        value: "Air conditioning"),
    HeatingAndCoolingClass(
        featuretype: HeatingAndCooling.heating, value: "Heating"),
    HeatingAndCoolingClass(featuretype: HeatingAndCooling.fan, value: "fan"),
  ];
}
