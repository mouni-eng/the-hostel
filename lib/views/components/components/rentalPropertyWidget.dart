import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_hostel/constants.dart';
import 'package:the_hostel/models/appartment_model.dart';
import 'package:the_hostel/size_config.dart';
import 'package:the_hostel/views/components/base_widget.dart';
import 'package:the_hostel/views/components/components/custom_text.dart';
import 'package:the_hostel/views/components/components/price_tag.dart';
import 'package:the_hostel/views/components/components/rentx_cached_image.dart';

class VerticalPropertyWidget extends StatelessWidget {
  const VerticalPropertyWidget({
    Key? key,
    required this.contWidth,
    required this.appartmentModel,
  }) : super(key: key);

  final double contWidth;
  final AppartmentModel appartmentModel;

  @override
  Widget build(BuildContext context) {
    return RentXWidget(builder: (rentxcontext) {
      var color = rentxcontext.theme.customTheme;
      return Container(
        width: width(contWidth),
        margin: EdgeInsets.only(right: width(15), bottom: height(15)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [boxShadow],
          color: color.onPrimary,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: height(190),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: RentXCachedImage(
                        url: appartmentModel.images.isNotEmpty
                            ? appartmentModel.images[0]
                            : "https://propy.com/browse/wp-content/uploads/2019/05/1.-Smart-Homes-1.jpg"),
                  ),
                ),
                const Positioned(
                    right: 0, child: BookMarkWidget(selected: false)),
              ],
            ),
            Padding(
              padding: padding,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          fontSize: width(18),
                          text: appartmentModel.name!,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(
                          height: height(5),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.room,
                              color: color.primary,
                              size: 15,
                            ),
                            SizedBox(
                              width: width(5),
                            ),
                            CustomText(
                              fontSize: width(12),
                              text: appartmentModel.address!.fullAddress(),
                              color: color.headline3,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height(10),
                        ),
                        Row(children: [
                          PriceTag(
                            price: appartmentModel.price.toString(),
                            showDuration: true,
                            duration: HostelDuration
                                .values[appartmentModel.duration!.index].name,
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Icon(
                                Icons.star_rate_rounded,
                                color: color.onPending,
                                size: height(25),
                              ),
                              CustomText(
                                fontSize: width(12),
                                text: " ${appartmentModel.rating}",
                                color: color.headline,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

class HorizontalPropertyWidget extends StatelessWidget {
  const HorizontalPropertyWidget({Key? key, required this.appartmentModel})
      : super(key: key);

  final AppartmentModel appartmentModel;

  @override
  Widget build(BuildContext context) {
    return RentXWidget(builder: (rentxcontext) {
      var color = rentxcontext.theme.customTheme;
      return Container(
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
            Stack(
              children: [
                CustomNetworkImage(
                  imgWidth: 100,
                  imgHeight: 120,
                  url: appartmentModel.images.isNotEmpty ? appartmentModel.images[0] : "",
                ),
                const Positioned(
                    right: 0, child: BookMarkWidget(selected: false)),
              ],
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
                      SvgPicture.asset("assets/images/location.svg"),
                      SizedBox(
                        width: width(5),
                      ),
                      Expanded(
                        child: CustomText(
                          fontSize: width(12),
                          text: appartmentModel.address!.fullAddress(),
                          color: rentxcontext.theme.customTheme.headline3,
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
                            text: appartmentModel.rooms.toString(),
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
                            text: appartmentModel.capacity.toString(),
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
                            text: appartmentModel.bathroom.toString(),
                            color: color.headline,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: height(10)),
                  Row(
                    children: [
                      PriceTag(
                        price: appartmentModel.price.toString(),
                        showDuration: true,
                        duration: HostelDuration
                            .values[appartmentModel.duration!.index].name,
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Icon(
                            Icons.star_rate_rounded,
                            color: color.onPending,
                            size: height(25),
                          ),
                          CustomText(
                            fontSize: width(12),
                            text: " ${appartmentModel.rating}",
                            color: color.headline,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}

class BookMarkWidget extends StatelessWidget {
  const BookMarkWidget({
    Key? key,
    required this.selected,
  }) : super(key: key);

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return RentXWidget(builder: (rentxcontext) {
      var color = rentxcontext.theme.customTheme;

      return Container(
        padding: EdgeInsets.all(
          width(4),
        ),
        margin: EdgeInsets.all(
          width(10),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: color.inputFieldFillBold.withOpacity(0.4),
        ),
        child: Icon(
          Icons.bookmark_rounded,
          color: selected ? color.primary.withOpacity(0.5) : color.onPrimary,
          size: 15,
        ),
      );
    });
  }
}

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    Key? key,
    required this.url,
    this.avatarLetters,
    this.imgWidth = 80,
    this.imgHeight = 100,
    this.radius = 20,
  }) : super(key: key);

  final String url;
  final String? avatarLetters;
  final double imgWidth, imgHeight, radius;

  @override
  Widget build(BuildContext context) {
    return url != null && url.isNotEmpty
        ? Container(
            height: height(imgHeight),
            width: width(imgWidth),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: RentXCachedImage(
                url: url,
              ),
            ),
          )
        : RentXWidget(builder: (rentxcontext) {
            return Container(
              height: height(imgHeight),
              width: width(imgWidth),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                color: rentxcontext.theme.customTheme.primary,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radius),
                child: Center(
                  child: CustomText(
                      text: avatarLetters!,
                      fontSize: width(20),
                      fontWeight: FontWeight.bold,
                      color: rentxcontext.theme.theme.colorScheme.onPrimary),
                ),
              ),
            );
          });
  }
}
