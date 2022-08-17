import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_hostel/constants.dart';
import 'package:the_hostel/models/appartment_model.dart';
import 'package:the_hostel/size_config.dart';
import 'package:the_hostel/view_models/add_property_cubit/cubit.dart';
import 'package:the_hostel/view_models/add_property_cubit/states.dart';
import 'package:the_hostel/view_models/location_cubit/cubit.dart';
import 'package:the_hostel/views/auth_views/user_login/login_view.dart';
import 'package:the_hostel/views/auth_views/user_registration/address_selection.dart';
import 'package:the_hostel/views/components/base_widget.dart';
import 'package:the_hostel/views/components/components/confirmation_widget.dart';
import 'package:the_hostel/views/components/components/custom_button.dart';
import 'package:the_hostel/views/components/components/custom_text.dart';
import 'package:the_hostel/views/components/components/dotted_border/dotted_border.dart';
import 'package:the_hostel/views/components/components/rentx_imagepicker.dart';
import 'package:the_hostel/views/owner_views/property_listing/basic_info_view.dart';
import 'package:expandable_text/expandable_text.dart';

class AdditionalInfoView extends StatelessWidget {
  const AdditionalInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RentXWidget(
      builder: (rentX) => BlocConsumer<AddPropertyCubit, AddPropertyStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var color = rentX.theme.customTheme;
          AddPropertyCubit cubit = AddPropertyCubit.get(context);
          return Padding(
            padding: padding,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    color: rentX.theme.customTheme.secondary,
                    fontSize: width(16),
                    text: "Add photos",
                  ),
                  SizedBox(
                    height: height(16),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: width(16),
                      mainAxisSpacing: height(16),
                      crossAxisCount: 3,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      bool hasImageSelected = cubit.images.length >= index + 1;
                      return RentXImagePicker(
                          showOnLongPress: hasImageSelected,
                          widgetBuilder: () => hasImageSelected
                              ? GestureDetector(
                                  onTap: () {
                                    cubit.updateImageFeatured(index);
                                  },
                                  child: _UploadedImageWidget(
                                      featured: cubit.featured == index,
                                      file: cubit.images[index]),
                                )
                              : const ChooseImageWidget(),
                          onFilePick: cubit.chooseImage);
                    },
                  ),
                  SizedBox(
                    height: height(25),
                  ),
                  PropertiesWidget(
                    title: "Bed Features",
                    length: cubit.bedFeatures.length,
                    customBuilder: (context, index) => AddPropertyComponent(
                      title: cubit.bedFeatures[index].value,
                      selected: cubit.bedFeatures[index].selected,
                      iconData: BedFeaturesExtension(
                              cubit.bedFeatures[index].featuretype)
                          .icon!,
                      onSelected: () {
                        cubit.onAddBedFeatures(index);
                      },
                    ),
                  ),
                  SizedBox(
                    height: height(25),
                  ),
                  PropertiesWidget(
                    title: "Bathroom Features",
                    length: cubit.bathroomFeatures.length,
                    customBuilder: (context, index) => AddPropertyComponent(
                      title: cubit.bathroomFeatures[index].value,
                      selected: cubit.bathroomFeatures[index].selected,
                      iconData: BathroomFeaturesExtension(
                              cubit.bathroomFeatures[index].featuretype)
                          .icon!,
                      onSelected: () {
                        cubit.onAddbathroomFeatures(index);
                      },
                    ),
                  ),
                  SizedBox(
                    height: height(25),
                  ),
                  PropertiesWidget(
                    title: "Kitchen Features",
                    length: cubit.kitchenFeatures.length,
                    customBuilder: (context, index) => AddPropertyComponent(
                      title: cubit.kitchenFeatures[index].value,
                      selected: cubit.kitchenFeatures[index].selected,
                      iconData: KitchenFeaturesExtension(
                              cubit.kitchenFeatures[index].featuretype)
                          .icon!,
                      onSelected: () {
                        cubit.onAddkitchenFeatures(index);
                      },
                    ),
                  ),
                  SizedBox(
                    height: height(25),
                  ),
                  PropertiesWidget(
                    title: "Heating and Cooling Features",
                    length: cubit.heatingAndCooling.length,
                    customBuilder: (context, index) => AddPropertyComponent(
                      title: cubit.heatingAndCooling[index].value,
                      selected: cubit.heatingAndCooling[index].selected,
                      iconData: HeatingAndCoolingExtension(
                              cubit.heatingAndCooling[index].featuretype)
                          .icon!,
                      onSelected: () {
                        cubit.onAddheatingAndCoolingFeatures(index);
                      },
                    ),
                  ),
                  SizedBox(
                    height: height(25),
                  ),
                  PropertiesWidget(
                    title: "Connection Features",
                    length: cubit.connectionFeatutres.length,
                    customBuilder: (context, index) => AddPropertyComponent(
                      title: cubit.connectionFeatutres[index].value,
                      selected: cubit.connectionFeatutres[index].selected,
                      iconData: ConnectionExtension(
                              cubit.connectionFeatutres[index].featuretype)
                          .icon!,
                      onSelected: () {
                        cubit.onAddConnectionFeatures(index);
                      },
                    ),
                  ),
                  SizedBox(
                    height: height(25),
                  ),
                  PropertiesWidget(
                    title: "Studying Features",
                    length: cubit.studyingFeatures.length,
                    customBuilder: (context, index) => AddPropertyComponent(
                      title: cubit.studyingFeatures[index].value,
                      selected: cubit.studyingFeatures[index].selected,
                      iconData: StudyingPlaceExtension(
                              cubit.studyingFeatures[index].featuretype)
                          .icon!,
                      onSelected: () {
                        cubit.onAddStudyingPlaceFeatures(index);
                      },
                    ),
                  ),
                  SizedBox(
                    height: height(25),
                  ),
                  PropertiesWidget(
                    title: "Entertainment Features",
                    length: cubit.entertainmentFeatures.length,
                    customBuilder: (context, index) => AddPropertyComponent(
                      title: cubit.entertainmentFeatures[index].value,
                      selected: cubit.entertainmentFeatures[index].selected,
                      iconData: EntertainmentExtension(
                              cubit.entertainmentFeatures[index].featuretype)
                          .icon!,
                      onSelected: () {
                        cubit.onAddEntertainmentFeatures(index);
                      },
                    ),
                  ),
                  SizedBox(
                    height: height(25),
                  ),
                  CustomText(
                    color: rentX.theme.customTheme.secondary,
                    fontSize: width(16),
                    text: "Privacy Policy",
                  ),
                  SizedBox(
                    height: height(16),
                  ),
                  ExpandableText(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,",
                    expandText: 'show more',
                    collapseText: 'show less',
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: width(16),
                      color: color.headline3,
                    ),
                    linkColor: color.primary,
                  ),
                  SizedBox(
                    height: height(35),
                  ),
                  CustomButton(
                    fontSize: width(18),
                    function: () {
                      cubit.onNextStep();
                      /*rentX.route(
                        (context) => CompletedScreen(
                            title: "Real estate was added succussfully",
                            text:
                                "Now you can check your real estates from your home page and track if there is a booking",
                            onBtnClick: () {}),
                      );*/
                    },
                    text: "Continue",
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _UploadedImageWidget extends StatelessWidget {
  final File file;
  final bool featured;

  const _UploadedImageWidget(
      {Key? key, required this.file, required this.featured})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RentXWidget(
      builder: (rentXContext) => Container(
        width: width(98),
        margin: EdgeInsets.symmetric(horizontal: width(3), vertical: height(3)),
        height: height(93),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image(
                width: double.infinity,
                height: double.infinity,
                image: FileImage(file),
                fit: BoxFit.cover,
              ),
            ),
            if (featured)
              Container(
                width: width(26),
                height: height(26),
                margin: EdgeInsets.symmetric(
                  horizontal: width(4),
                  vertical: height(4),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: rentXContext.theme.customTheme.onPrimary,
                ),
                child:
                    Center(child: SvgPicture.asset("assets/images/heart.svg")),
              ),
          ],
        ),
      ),
    );
  }
}

class ChooseImageWidget extends StatelessWidget {
  const ChooseImageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RentXWidget(
      builder: (context) => Padding(
        padding:
            EdgeInsets.symmetric(horizontal: width(3), vertical: height(3)),
        child: DottedBorder(
          radius: const Radius.circular(8),
          color: context.theme.customTheme.primary,
          child: Container(
            width: width(98),
            margin:
                EdgeInsets.symmetric(horizontal: width(3), vertical: height(3)),
            height: height(93),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: SvgPicture.asset("assets/images/camera.svg"),
            ),
          ),
        ),
      ),
    );
  }
}

class ChoiceFeatureWidget extends StatelessWidget {
  const ChoiceFeatureWidget(
      {Key? key,
      this.selected,
      required this.title,
      required this.iconData,
      required this.onSelected})
      : super(key: key);

  final bool? selected;
  final String title;
  final IconData iconData;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    return RentXWidget(builder: (rentxcontext) {
      var color = rentxcontext.theme.customTheme;
      return ChoiceChip(
        onSelected: onSelected,
        label: Row(
          children: [
            CustomText(
              fontSize: width(14),
              text: title,
              color: selected! ? color.headline3 : color.onPrimary,
            ),
            SizedBox(
              width: width(10),
            ),
            Icon(
              iconData,
              size: height(20),
              color: selected! ? color.headline3 : color.onPrimary,
            ),
          ],
        ),
        selected: selected!,
      );
    });
  }
}
