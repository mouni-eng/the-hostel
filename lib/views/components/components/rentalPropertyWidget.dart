import 'package:flutter/material.dart';
import 'package:the_hostel/constants.dart';
import 'package:the_hostel/size_config.dart';
import 'package:the_hostel/views/components/base_widget.dart';
import 'package:the_hostel/views/components/components/custom_text.dart';
import 'package:the_hostel/views/components/components/price_tag.dart';
import 'package:the_hostel/views/components/components/rentx_cached_image.dart';

class RentalPropertyWidget extends StatelessWidget {
  const RentalPropertyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RentXWidget(builder: (rentxcontext) {
      var color = rentxcontext.theme.customTheme;
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [boxShadow],
          color: color.onPrimary,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height(250),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: const RentXCachedImage(
                    url:
                        "https://propy.com/browse/wp-content/uploads/2019/05/1.-Smart-Homes-1.jpg"),
              ),
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
                          text: "Passion Homes appartment",
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(height: height(15)),
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
                                  text: " 3",
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
                                  text: " 3",
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
                                  text: " 3",
                                  color: color.headline,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                            const Spacer(),
                            const PriceTag(
                              price: "950",
                              showDuration: true,
                              duration: "mon",
                            ),
                          ],
                        )
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
