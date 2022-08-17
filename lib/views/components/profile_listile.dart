import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_hostel/constants.dart';
import 'package:the_hostel/size_config.dart';
import 'package:the_hostel/views/components/base_widget.dart';
import 'package:the_hostel/views/components/components/back_button.dart';
import 'package:the_hostel/views/components/components/custom_text.dart';

class CustomProfileListTile extends StatelessWidget {
  const CustomProfileListTile({
    Key? key,
    this.onPressed,
    required this.title,
    required this.img,
    this.isCustom = false,
    this.isDark = false,
    this.subTitle = "",
  }) : super(key: key);

  final Function()? onPressed;
  final String title, img, subTitle;
  final bool isCustom, isDark;

  @override
  Widget build(BuildContext context) {
    return RentXWidget(
      builder: (rentxcontext) => ListTile(
        onTap: onPressed,
        leading: Container(
          width: width(46),
          height: height(46),
          padding: EdgeInsets.symmetric(
            horizontal: width(10),
            vertical: height(10),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: rentxcontext.theme.customTheme.profileFill,
          ),
          child: SvgPicture.asset(img),
        ),
        title: CustomText(
          color: rentxcontext.theme.customTheme.headline,
          fontSize: width(16),
          text: title,
        ),
        trailing: isCustom
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                      color: rentxcontext.theme.customTheme.headline,
                      fontSize: width(14),
                      text: subTitle),
                  CustomBorderWidget(
                      rentxcontext: rentxcontext,
                      iconData: const Icon(Icons.arrow_forward_ios_rounded)),
                ],
              )
            : isDark
                ? Switch.adaptive(
                    value: false,
                    onChanged: (value) {
                      // ProfileCubit.get(context).switchTheme(context);
                    })
                : CustomBorderWidget(
                    rentxcontext: rentxcontext,
                    iconData: const Icon(Icons.arrow_forward_ios_rounded)),
      ),
    );
  }
}
