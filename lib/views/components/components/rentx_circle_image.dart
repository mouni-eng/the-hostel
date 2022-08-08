import 'package:flutter/material.dart';
import 'package:the_hostel/size_config.dart';
import 'package:the_hostel/views/components/base_widget.dart';
import 'package:the_hostel/views/components/components/custom_text.dart';
import 'package:the_hostel/views/components/components/rentx_cached_image.dart';

class RentXCircleImage extends StatelessWidget {
  final String? imageSrc;
  final String avatarLetters;

  const RentXCircleImage(
      {Key? key, required this.imageSrc, required this.avatarLetters})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RentXWidget(
      builder: (context) {
        return imageSrc != null && imageSrc!.isNotEmpty
            ? SizedBox(
                height: width(64),
                width: width(64),
                child: RentXCachedImage(
                  url: imageSrc!,
                  boxFit: BoxFit.fill,
                  boxShape: BoxShape.circle,
                ),
              )
            : SizedBox(
                height: width(64),
                width: width(64),
                child: CircleAvatar(
                  backgroundColor: context.theme.customTheme.primary,
                  child: CustomText(
                      text: avatarLetters,
                      fontSize: width(20),
                      fontWeight: FontWeight.bold,
                      color: context.theme.theme.colorScheme.onPrimary),
                ),
              );
      },
    );
  }
}
