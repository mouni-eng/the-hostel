import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:the_hostel/constants.dart';
import 'package:the_hostel/infrastructure/utils.dart';
import 'package:the_hostel/models/appartment_model.dart';
import 'package:the_hostel/models/location.dart';
import 'package:the_hostel/models/review_model.dart';
import 'package:the_hostel/size_config.dart';
import 'package:the_hostel/view_models/home_cubit/cubit.dart';
import 'package:the_hostel/view_models/home_cubit/state.dart';
import 'package:the_hostel/view_models/hostel_details_cubit/cubit.dart';
import 'package:the_hostel/view_models/hostel_details_cubit/state.dart';
import 'package:the_hostel/views/auth_views/user_login/login_view.dart';
import 'package:the_hostel/views/components/base_widget.dart';
import 'package:the_hostel/views/components/components/custom_button.dart';
import 'package:the_hostel/views/components/components/custom_calander.dart';
import 'package:the_hostel/views/components/components/custom_text.dart';
import 'package:the_hostel/views/components/components/price_tag.dart';
import 'package:the_hostel/views/components/components/rentalPropertyWidget.dart';
import 'package:the_hostel/views/components/components/rentx_circle_image.dart';
import 'package:the_hostel/views/components/widgets/map/rentx_map_card.dart';
import 'package:the_hostel/views/owner_views/property_listing/basic_info_view.dart';
import 'package:the_hostel/views/student_views/hostel_confirmation_view.dart';

class HostelDetailsView extends StatelessWidget {
  const HostelDetailsView(
      {Key? key, required this.appartmentModel, required this.rating})
      : super(key: key);

  final AppartmentModel appartmentModel;
  final String? rating;

  @override
  Widget build(BuildContext context) {
    return RentXWidget(
        builder: (rentxcontext) => BlocConsumer<HostelDetailsCubit,
                HostelDetailsStates>(
            listener: (context, state) {},
            builder: (context, state) {
              HostelDetailsCubit cubit = HostelDetailsCubit.get(context);
              var color = rentxcontext.theme.customTheme;
              return Scaffold(
                body: SafeArea(
                  child: ConditionalBuilder(
                    condition: true,
                    builder: (context) => Stack(
                      children: [
                        SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: width(10),
                              vertical: height(16),
                            ),
                            child: Column(
                              children: [
                                CarouselSlider(
                                  items: List.generate(
                                    appartmentModel.images.length,
                                    (index) => Stack(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: height(337),
                                          margin: EdgeInsets.symmetric(
                                            horizontal: width(5),
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              child: CachedNetworkImage(
                                                imageUrl: appartmentModel
                                                    .images[index],
                                                fit: BoxFit.cover,
                                              )),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: width(16),
                                            vertical: height(16),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              ImageCustomButton(
                                                img: "assets/images/arrow.svg",
                                                rentxcontext: rentxcontext,
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              BlocConsumer<HomeCubit,
                                                      HomeStates>(
                                                  listener: (context, state) {},
                                                  builder: (context, state) {
                                                    HomeCubit homeCubit =
                                                        HomeCubit.get(context);
                                                    return ImageCustomButton(
                                                      img:
                                                          "assets/images/heart.svg",
                                                      rentxcontext:
                                                          rentxcontext,
                                                      selected: homeCubit
                                                                  .favouriteApartments[
                                                              appartmentModel
                                                                  .apUid] ??
                                                          false,
                                                      onTap: () {
                                                        homeCubit
                                                            .toggleFavourite(
                                                          appartmentModel:
                                                              appartmentModel,
                                                        );
                                                      },
                                                    );
                                                  }),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  options: CarouselOptions(
                                    height: height(337),
                                    initialPage: 0,
                                    onPageChanged: (index, reason) {
                                      cubit.onChangeIndex(index: index);
                                    },
                                    viewportFraction: 1,
                                    enableInfiniteScroll: true,
                                    disableCenter: true,
                                    reverse: false,
                                    autoPlay: true,
                                    autoPlayInterval:
                                        const Duration(seconds: 6),
                                    autoPlayAnimationDuration:
                                        const Duration(milliseconds: 800),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    scrollDirection: Axis.horizontal,
                                  ),
                                ),
                                SizedBox(
                                  height: height(9),
                                ),
                                SmoothCarouselIndicator(
                                  currentPage: cubit.carousalIndex,
                                  count: appartmentModel.images.length,
                                  initialPage: 0,
                                ),
                                SizedBox(
                                  height: height(8),
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: width(16),
                                    vertical: height(16),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: rentxcontext
                                        .theme.customTheme.onPrimary,
                                    boxShadow: [
                                      boxShadow,
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: CustomText(
                                              color: rentxcontext
                                                  .theme.customTheme.headline,
                                              fontSize: width(16),
                                              text: appartmentModel.name!,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          PriceTag(
                                            price: appartmentModel.price
                                                .toString(),
                                            showDuration: true,
                                            duration:
                                                appartmentModel.duration!.name,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: height(15),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              CustomText(
                                                color: rentxcontext
                                                    .theme.customTheme.headline,
                                                fontSize: width(16),
                                                text: "Rating: ",
                                                fontWeight: FontWeight.w400,
                                              ),
                                              RatingTag(rating: rating!),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              CustomText(
                                                color: rentxcontext
                                                    .theme.customTheme.headline,
                                                fontSize: width(16),
                                                text: "Booked: ",
                                                fontWeight: FontWeight.w400,
                                              ),
                                              CustomText(
                                                  color: color.headline3,
                                                  fontSize: width(14),
                                                  text:
                                                      "${appartmentModel.booked}/${appartmentModel.capacity}"),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: height(16),
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: width(16),
                                    vertical: height(16),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: rentxcontext
                                        .theme.customTheme.onPrimary,
                                    boxShadow: [
                                      boxShadow,
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        color: rentxcontext
                                            .theme.customTheme.headline,
                                        fontSize: width(14),
                                        text: "Hostel Info",
                                      ),
                                      const Divider(
                                        thickness: 1.4,
                                      ),
                                      GridView.count(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        crossAxisCount: 2,
                                        childAspectRatio: 4.5,
                                        children: [
                                          HostelListingProperties(
                                            img: Icons.home_outlined,
                                            title:
                                                "Elevation: ${appartmentModel.elevation!.name}",
                                            selected: true,
                                          ),
                                          HostelListingProperties(
                                            img: Icons.person_outline,
                                            title:
                                                "Gender: ${appartmentModel.gender!.name}",
                                            selected: true,
                                          ),
                                          HostelListingProperties(
                                            img: Icons.square_outlined,
                                            title:
                                                "Area: ${appartmentModel.area.toString()} m2",
                                            selected: true,
                                          ),
                                          HostelListingProperties(
                                            img: Icons.door_back_door_outlined,
                                            title:
                                                "BedRooms: ${appartmentModel.bedrooms.toString()}",
                                            selected: true,
                                          ),
                                          HostelListingProperties(
                                            img: Icons.apartment_outlined,
                                            title:
                                                "Floor: ${appartmentModel.floor.toString()}",
                                            selected: true,
                                          ),
                                          HostelListingProperties(
                                            img: Icons.bathroom_outlined,
                                            title:
                                                "Bathroom: ${appartmentModel.bathroom.toString()}",
                                            selected: true,
                                          ),
                                          HostelListingProperties(
                                            img: Icons.bed_outlined,
                                            title:
                                                "Bed/room: ${appartmentModel.bedPerRoom.toString()}",
                                            selected: true,
                                          ),
                                        ],
                                      ),
                                      const Divider(
                                        thickness: 1.4,
                                      ),
                                      SizedBox(
                                        height: height(16),
                                      ),
                                      CustomText(
                                        color: rentxcontext
                                            .theme.customTheme.headline,
                                        fontSize: width(14),
                                        text: "Description",
                                      ),
                                      SizedBox(
                                        height: height(6),
                                      ),
                                      ExpandableText(
                                        appartmentModel.description!,
                                        expandText: 'show more',
                                        collapseText: 'show less',
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontSize: width(16),
                                          color: color.headline3,
                                        ),
                                        linkColor: color.primary,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: height(16),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    cubit.launchMaps(
                                        appartmentModel: appartmentModel);
                                  },
                                  child: CarListingMap(
                                      company: appartmentModel,
                                      label: 'Our Location',
                                      mapController: cubit.mapController),
                                ),
                                SizedBox(
                                  height: height(25),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        color: color.headline,
                                        fontSize: width(14),
                                        text: "Reviews",
                                      ),
                                      SizedBox(
                                        height: height(15),
                                      ),
                                      ConditionalBuilder(
                                        condition: HomeCubit.get(context)
                                                        .reviewsApartments[
                                                    appartmentModel.apUid] !=
                                                null &&
                                            HomeCubit.get(context)
                                                .reviewsApartments[
                                                    appartmentModel.apUid]!
                                                .isNotEmpty,
                                        builder: (context) => SizedBox(
                                          height: height(120),
                                          child: ListView.separated(
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) =>
                                                  ReviewCard(
                                                      reviewModel: HomeCubit
                                                                  .get(context)
                                                              .reviewsApartments[
                                                          appartmentModel
                                                              .apUid]![index]),
                                              separatorBuilder:
                                                  (context, index) => SizedBox(
                                                        width: width(10),
                                                      ),
                                              itemCount: HomeCubit.get(context)
                                                  .reviewsApartments[
                                                      appartmentModel.apUid]!
                                                  .length),
                                        ),
                                        fallback: (context) => Center(
                                          child: CustomText(
                                            color: color.headline3,
                                            fontSize: width(16),
                                            text: "Not Rated Yet",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: height(25),
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
                                    children: [
                                      PropertiesWidget(
                                        title: "Bed Features",
                                        length:
                                            appartmentModel.bedFeatures!.length,
                                        customBuilder: (context, index) =>
                                            HostelListingProperties(
                                          title: appartmentModel
                                              .bedFeatures![index].value,
                                          selected: appartmentModel
                                              .bedFeatures![index].selected,
                                          img: BedFeaturesExtension(
                                                  appartmentModel
                                                      .bedFeatures![index]
                                                      .featuretype)
                                              .icon!,
                                        ),
                                      ),
                                      SizedBox(
                                        height: height(25),
                                      ),
                                      PropertiesWidget(
                                        title: "Bathroom Features",
                                        length: appartmentModel
                                            .bathroomFeatures!.length,
                                        customBuilder: (context, index) =>
                                            HostelListingProperties(
                                          title: appartmentModel
                                              .bathroomFeatures![index].value,
                                          selected: appartmentModel
                                              .bathroomFeatures![index]
                                              .selected,
                                          img: BathroomFeaturesExtension(
                                                  appartmentModel
                                                      .bathroomFeatures![index]
                                                      .featuretype)
                                              .icon!,
                                        ),
                                      ),
                                      SizedBox(
                                        height: height(25),
                                      ),
                                      PropertiesWidget(
                                        title: "Kitchen Features",
                                        length: appartmentModel
                                            .kitchenFeatures!.length,
                                        customBuilder: (context, index) =>
                                            HostelListingProperties(
                                          title: appartmentModel
                                              .kitchenFeatures![index].value,
                                          selected: appartmentModel
                                              .kitchenFeatures![index].selected,
                                          img: KitchenFeaturesExtension(
                                                  appartmentModel
                                                      .kitchenFeatures![index]
                                                      .featuretype)
                                              .icon!,
                                        ),
                                      ),
                                      SizedBox(
                                        height: height(25),
                                      ),
                                      PropertiesWidget(
                                        title: "Heating and Cooling Features",
                                        length: appartmentModel
                                            .heatingAndCooling!.length,
                                        customBuilder: (context, index) =>
                                            HostelListingProperties(
                                          title: appartmentModel
                                              .heatingAndCooling![index].value,
                                          selected: appartmentModel
                                              .heatingAndCooling![index]
                                              .selected,
                                          img: HeatingAndCoolingExtension(
                                                  appartmentModel
                                                      .heatingAndCooling![index]
                                                      .featuretype)
                                              .icon!,
                                        ),
                                      ),
                                      SizedBox(
                                        height: height(25),
                                      ),
                                      PropertiesWidget(
                                        title: "Connection Features",
                                        length: appartmentModel
                                            .connectionFeatures!.length,
                                        customBuilder: (context, index) =>
                                            HostelListingProperties(
                                          title: appartmentModel
                                              .connectionFeatures![index].value,
                                          selected: appartmentModel
                                              .connectionFeatures![index]
                                              .selected,
                                          img: ConnectionExtension(
                                                  appartmentModel
                                                      .connectionFeatures![
                                                          index]
                                                      .featuretype)
                                              .icon!,
                                        ),
                                      ),
                                      SizedBox(
                                        height: height(25),
                                      ),
                                      PropertiesWidget(
                                        title: "Studying Features",
                                        length: appartmentModel
                                            .studyingPlaceFeatures!.length,
                                        customBuilder: (context, index) =>
                                            HostelListingProperties(
                                          title: appartmentModel
                                              .studyingPlaceFeatures![index]
                                              .value,
                                          selected: appartmentModel
                                              .studyingPlaceFeatures![index]
                                              .selected,
                                          img: StudyingPlaceExtension(
                                                  appartmentModel
                                                      .studyingPlaceFeatures![
                                                          index]
                                                      .featuretype)
                                              .icon!,
                                        ),
                                      ),
                                      SizedBox(
                                        height: height(25),
                                      ),
                                      PropertiesWidget(
                                        title: "Entertainment Features",
                                        length: appartmentModel
                                            .entertainmentFeatures!.length,
                                        customBuilder: (context, index) =>
                                            HostelListingProperties(
                                          title: appartmentModel
                                              .entertainmentFeatures![index]
                                              .value,
                                          selected: appartmentModel
                                              .entertainmentFeatures![index]
                                              .selected,
                                          img: EntertainmentExtension(
                                                  appartmentModel
                                                      .entertainmentFeatures![
                                                          index]
                                                      .featuretype)
                                              .icon!,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: height(25),
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
                                  child: PropertiesWidget(
                                    title: "Rent type",
                                    length: Rent.values.length,
                                    customBuilder: (context, index) =>
                                        AddPropertyComponent(
                                      title: Rent.values[index].name,
                                      selected: cubit.booking.rentType != null
                                          ? cubit.booking.rentType ==
                                              Rent.values[index]
                                          : false,
                                      onSelected: () {
                                        cubit.onChooseRent(Rent.values[index]);
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: height(25),
                                ),
                                SizedBox(
                                  height: height(400),
                                  child: Container(
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
                                    child: CustomTableCalendar(
                                      onChangeFormat: (value) {
                                        cubit.toggleFormat(value);
                                      },
                                      focusedDay: cubit.focusedDay,
                                      startDay: cubit.rangeStart,
                                      endDay: cubit.rangeEnd,
                                      onChangeRange: (start, end, focusDay) {
                                        cubit.chooseDateEnd(
                                            start, end, focusDay);
                                      },
                                      onChangeDay: (value, value2) {
                                        cubit.chooseDate(value, value2);
                                      },
                                      rangeSelectionMode:
                                          cubit.rangeSelectionMode,
                                      calendarFormat: cubit.calendarFormat,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: height(80),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Material(
                            elevation: 40,
                            child: Container(
                              height: height(80),
                              padding: EdgeInsets.symmetric(
                                horizontal: width(24),
                                vertical: height(8),
                              ),
                              color: rentxcontext.theme.customTheme.onPrimary,
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/images/bank-transfer.svg",
                                    color:
                                        rentxcontext.theme.customTheme.headline,
                                  ),
                                  SizedBox(
                                    width: width(13),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                            color: rentxcontext
                                                .theme.customTheme.headline3,
                                            fontSize: width(16),
                                            text: cubit.rangeStart == null ||
                                                    cubit.rangeEnd == null
                                                ? "From - To"
                                                : DateUtil.displayDiffrence(
                                                    cubit.rangeStart!,
                                                    cubit.rangeEnd!)),
                                        SizedBox(
                                          height: height(
                                            6,
                                          ),
                                        ),
                                        if (cubit.rangeEnd != null)
                                          PriceTag(
                                            price: DateUtil.totalPrice(
                                                    from: cubit.rangeStart!,
                                                    to: cubit.rangeEnd!,
                                                    duration: appartmentModel
                                                        .duration!,
                                                    type: cubit
                                                            .booking.rentType ??
                                                        Rent.appartment,
                                                    price:
                                                        appartmentModel.price!)
                                                .toString(),
                                            showDuration: false,
                                          ),
                                        if (cubit.rangeEnd == null)
                                          PriceTag(
                                            price: appartmentModel.price
                                                .toString(),
                                            showDuration: true,
                                            duration:
                                                appartmentModel.duration!.name,
                                          ),
                                      ],
                                    ),
                                  ),
                                  CustomButton(
                                    btnWidth: width(130),
                                    fontSize: width(14),
                                    isUpperCase: false,
                                    enabled: cubit.rangeStart != null &&
                                        cubit.rangeEnd != null &&
                                        appartmentModel.booked! <
                                            appartmentModel.capacity!,
                                    function: () {
                                      rentxcontext.route((context) =>
                                          HostelConfirmationView(
                                              appartmentModel:
                                                  appartmentModel));
                                    },
                                    text: "Book Now",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    fallback: (BuildContext context) => loading,
                  ),
                ),
              );
            }));
  }
}

class HostelListingProperties extends StatelessWidget {
  const HostelListingProperties({
    Key? key,
    required this.img,
    required this.title,
    this.selected = false,
  }) : super(key: key);

  final String title;
  final IconData img;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return RentXWidget(builder: (rentxcontext) {
      return Row(
        children: [
          Icon(
            img,
            color: selected
                ? rentxcontext.theme.customTheme.primary
                : rentxcontext.theme.customTheme.headline3,
          ),
          SizedBox(
            width: width(12),
          ),
          CustomText(
              color: selected
                  ? rentxcontext.theme.customTheme.headline
                  : rentxcontext.theme.customTheme.headline3,
              fontSize: width(14),
              text: title),
        ],
      );
    });
  }
}

class ImageCustomButton extends StatelessWidget {
  const ImageCustomButton({
    Key? key,
    required this.img,
    required this.rentxcontext,
    required this.onTap,
    this.selected = false,
  }) : super(key: key);

  final String img;
  final bool selected;
  final RentXContext rentxcontext;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width(36),
        height: height(36),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: rentxcontext.theme.customTheme.onPrimary,
          boxShadow: [
            boxShadow,
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width(8),
            vertical: height(8),
          ),
          child: SvgPicture.asset(
            img,
            color: selected
                ? rentxcontext.theme.customTheme.onRejected
                : rentxcontext.theme.customTheme.headline3,
          ),
        ),
      ),
    );
  }
}

class SmoothCarouselIndicator extends StatelessWidget {
  final int count;
  final int initialPage;
  final int? currentPage;
  final Axis? axis;
  final dynamic indicatorEffect;

  const SmoothCarouselIndicator(
      {Key? key,
      required this.count,
      required this.currentPage,
      required this.initialPage,
      this.axis = Axis.horizontal,
      this.indicatorEffect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RentXWidget(
      builder: (rentXContext) => AnimatedSmoothIndicator(
        count: count,
        axisDirection: axis!,
        effect: ExpandingDotsEffect(
            activeDotColor: rentXContext.theme.customTheme.primary,
            dotColor: rentXContext.theme.customTheme.inputFieldFillBold,
            dotHeight: width(4),
            expansionFactor: 8,
            radius: 30,
            dotWidth: width(5)),
        activeIndex: currentPage ?? initialPage,
      ),
    );
  }
}

class CarListingMap extends StatelessWidget {
  final AppartmentModel company;
  final RentXMapController mapController;
  final String? label;
  final EdgeInsetsGeometry? padding;

  const CarListingMap(
      {Key? key,
      required this.company,
      required this.mapController,
      this.label,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RentXWidget(
        builder: (rentxcontext) => Container(
              width: double.infinity,
              padding: padding ??
                  EdgeInsets.symmetric(
                    horizontal: width(16),
                    vertical: height(16),
                  ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: rentxcontext.theme.customTheme.onPrimary,
                boxShadow: [
                  boxShadow,
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (label != null)
                    CustomText(
                      color: rentxcontext.theme.customTheme.headline,
                      fontSize: width(14),
                      text: label!,
                    ),
                  if (label != null)
                    SizedBox(
                      height: height(6),
                    ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: RentXMapCard(
                        disableNavigation: true,
                        width: double.infinity,
                        height: height(123),
                        controller: mapController,
                        location: RentXLocation(
                          street: company.address!.fullAddress(),
                          city: company.address!.city!.name!,
                          state: company.address!.city!.country!,
                          zip: company.address!.city!.countryCode!,
                          latitude: company.address!.latitude!,
                          longitude: company.address!.longitude!,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height(16),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/images/location.svg",
                        color: rentxcontext.theme.customTheme.primary,
                      ),
                      SizedBox(
                        width: width(7),
                      ),
                      Expanded(
                        child: CustomText(
                            color: rentxcontext.theme.customTheme.primary,
                            fontSize: width(12),
                            maxlines: 1,
                            text: company.address!.fullAddress()),
                      ),
                    ],
                  ),
                ],
              ),
            ));
  }
}

class ReviewCard extends StatelessWidget {
  const ReviewCard({Key? key, required this.reviewModel}) : super(key: key);

  final ReviewModel reviewModel;

  @override
  Widget build(BuildContext context) {
    return RentXWidget(builder: (rentxcontext) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RentXCircleImage(
            imageSrc: reviewModel.user!.profilePictureId,
            avatarLetters: NameUtil.getInitials(
                reviewModel.user!.name, reviewModel.user!.surname),
          ),
          SizedBox(
            height: height(15),
          ),
          Row(
            children: [
              CustomText(
                color: rentxcontext.theme.customTheme.headline,
                fontSize: width(14),
                text: "Rating:",
                fontWeight: FontWeight.w400,
              ),
              RatingTag(rating: reviewModel.rating.toString()),
            ],
          ),
        ],
      );
    });
  }
}
