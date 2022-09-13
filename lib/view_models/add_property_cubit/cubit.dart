import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:the_hostel/constants.dart';
import 'package:the_hostel/models/address.dart';
import 'package:the_hostel/models/appartment_model.dart';
import 'package:the_hostel/models/review_model.dart';
import 'package:the_hostel/services/apartment_service.dart';
import 'package:the_hostel/services/file_service.dart';
import 'package:the_hostel/services/home_service.dart';
import 'package:the_hostel/view_models/add_property_cubit/states.dart';
import 'package:the_hostel/views/auth_views/user_registration/address_selection.dart';
import 'package:the_hostel/views/owner_views/property_listing/additional_info_view.dart';
import 'package:the_hostel/views/owner_views/property_listing/appartment_info_view.dart';
import 'package:the_hostel/views/owner_views/property_listing/basic_info_view.dart';

class AddPropertyCubit extends Cubit<AddPropertyStates> {
  AddPropertyCubit() : super(AddPropertyStates());

  static AddPropertyCubit get(context) => BlocProvider.of(context);

  int index = 0;
  bool isLast = false;
  double percent = 1 / 4;
  final basicFormkey = GlobalKey<FormState>();
  final apartmentFormkey = GlobalKey<FormState>();
  final additionalFormkey = GlobalKey<FormState>();
  final ApartmentService _apartmentService = ApartmentService();
  final FileService _fileService = FileService();
  final HomeService _homeService = HomeService();

  PageController controller = PageController();

  int? featured;

  List<File> images = [];
  List<AppartmentModel> apartments = [];
  Map<String, List<ReviewModel>> reviewsApartments = {};

  getApartments() {
    emit(GetApartmentLoadingState());
    _apartmentService.getApartment().listen((value) {
      apartments.clear();
      reviewsApartments.clear();
      print(value.docs.length);
      if (value.docs.isEmpty) {
        emit(GetApartmentSuccessState());
      }
      for (var apartment in value.docs) {
        print(apartment.data());
        _homeService
            .getReviews(
                apartmentModel: AppartmentModel.fromJson(apartment.data()))
            .then((value) {
          print(value.length);
          reviewsApartments.addAll(
              {AppartmentModel.fromJson(apartment.data()).apUid!: value});
        });
        apartments.add(AppartmentModel.fromJson(apartment.data()));
        print(apartments[0].studyingPlaceFeatures![0].value);
        emit(GetApartmentSuccessState());
      }
    });
  }

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
    AddressApartmentSelection(),
  ];

  List<String> header = [
    "Basic Info",
    "Apartment Info",
    "Additional Info",
    "Address Seclection",
  ];

  AppartmentModel appartmentModel = AppartmentModel.instance();

  onChooseDuration(HostelDuration value) {
    appartmentModel.duration = value;
    emit(OnChangePropertyState());
  }

  onChooseElevation(Elevation value) {
    appartmentModel.elevation = value;
    emit(OnChangePropertyState());
  }

  onChooseGender(Gender value) {
    appartmentModel.gender = value;
    emit(OnChangePropertyState());
  }

  onChooseAddress(Address value) {
    appartmentModel.address = value;
    emit(OnChangePropertyState());

    addApartment();
  }

  onChoosename(String value) {
    appartmentModel.name = value;
    emit(OnChangePropertyState());
  }

  onChoosedescription(String value) {
    appartmentModel.description = value;
    emit(OnChangePropertyState());
  }

  onChoosePrice(double value) {
    appartmentModel.price = value;
    emit(OnChangePropertyState());
  }

  onChoosefloor(int value) {
    appartmentModel.floor = value;
    emit(OnChangePropertyState());
  }

  onChooserooms(int value) {
    appartmentModel.bedrooms = value;
    emit(OnChangePropertyState());
  }

  onChoosebathrooms(int value) {
    appartmentModel.bathroom = value;
    emit(OnChangePropertyState());
  }

  onChoosecapacity(int value) {
    appartmentModel.capacity = value;
    emit(OnChangePropertyState());
  }

  onChooseArea(int value) {
    appartmentModel.area = value;
    emit(OnChangePropertyState());
  }

  onChooseBedPerRoom(int value) {
    appartmentModel.bedPerRoom = value;
    emit(OnChangePropertyState());
  }

  onBackStep() {
    if (percent != 1 / 4) {
      percent -= 1 / 4;
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
      percent += 1 / 4;
      index += 1;
      if (index == 3) {
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

  onNextValidate() {
    if (index == 0) {
      if (basicFormkey.currentState!.validate() &&
          appartmentModel.duration != null) {
        onNextStep();
      }
    } else if (index == 1) {
      if (apartmentFormkey.currentState!.validate() &&
          appartmentModel.elevation != null &&
          appartmentModel.gender != null) {
        onNextStep();
      }
    } else if (index == 2) {
      if (additionalFormkey.currentState!.validate()) {
        onNextStep();
      }
    }
  }

  Future<void> uploadImages() async {
    for (var image in images) {
      await _fileService.uploadFile(image).then((value) {
        appartmentModel.images.add(value);
        print(value);
        emit(OnChangePropertyState());
      });
    }
  }

  onAddBedFeatures(int value) {
    bedFeatures[value].selected = !bedFeatures[value].selected;
    appartmentModel.bedFeatures = bedFeatures;
    emit(OnChangePropertyState());
  }

  onAddbathroomFeatures(int value) {
    bathroomFeatures[value].selected = !bathroomFeatures[value].selected;
    appartmentModel.bathroomFeatures = bathroomFeatures;
    emit(OnChangePropertyState());
  }

  onAddkitchenFeatures(int value) {
    kitchenFeatures[value].selected = !kitchenFeatures[value].selected;
    appartmentModel.kitchenFeatures = kitchenFeatures;
    emit(OnChangePropertyState());
  }

  onAddheatingAndCoolingFeatures(int value) {
    heatingAndCooling[value].selected = !heatingAndCooling[value].selected;
    appartmentModel.heatingAndCooling = heatingAndCooling;
    emit(OnChangePropertyState());
  }

  onAddConnectionFeatures(int value) {
    connectionFeatutres[value].selected = !connectionFeatutres[value].selected;
    appartmentModel.connectionFeatures = connectionFeatutres;
    emit(OnChangePropertyState());
  }

  onAddStudyingPlaceFeatures(int value) {
    studyingFeatures[value].selected = !studyingFeatures[value].selected;
    appartmentModel.studyingPlaceFeatures = studyingFeatures;
    emit(OnChangePropertyState());
  }

  onAddEntertainmentFeatures(int value) {
    entertainmentFeatures[value].selected =
        !entertainmentFeatures[value].selected;
    appartmentModel.entertainmentFeatures = entertainmentFeatures;
    emit(OnChangePropertyState());
  }

  addApartment() async {
    emit(AddApartmentLoadingState());
    await uploadImages();
    appartmentModel.apUid = UniqueKey().hashCode.toString();
    appartmentModel.agentUid = userModel!.personalId;
    _apartmentService.addApartment(appartmentModel).then((value) {
      emit(AddApartmentSuccessState());
    }).catchError((error) {
      emit(AddApartmentErrorState());
    });
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

  List<ConnectionFeaturesClass> connectionFeatutres = [
    ConnectionFeaturesClass(featuretype: Connection.wifi, value: "WIFI"),
    ConnectionFeaturesClass(
      featuretype: Connection.signal,
      value: "Signal",
    ),
  ];

  List<StudyingPlaceFeaturesClass> studyingFeatures = [
    StudyingPlaceFeaturesClass(featuretype: StudyingPlace.desk, value: "Desk"),
    StudyingPlaceFeaturesClass(
        featuretype: StudyingPlace.drawingTable, value: "Drawing Table"),
  ];

  List<EntertainmentFeaturesClass> entertainmentFeatures = [
    EntertainmentFeaturesClass(
        featuretype: Entertainment.playstation, value: "Playstation"),
    EntertainmentFeaturesClass(featuretype: Entertainment.tv, value: "Tv"),
  ];
}
