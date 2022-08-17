import 'package:flutter/material.dart';
import 'package:the_hostel/size_config.dart';
import 'package:the_hostel/views/components/base_widget.dart';

class CustomBorderWidget extends StatelessWidget {
  const CustomBorderWidget({
    Key? key,
    required this.rentxcontext,
    this.onTap,
    required this.iconData,
    this.btnWidth = 46,
    this.btnHeight = 46,
  }) : super(key: key);

  final RentXContext rentxcontext;
  final Function()? onTap;
  final Widget iconData;
  final double btnWidth, btnHeight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width(btnWidth),
        height: height(btnHeight),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: rentxcontext.theme.customTheme.inputFieldBorder,
          ),
        ),
        child: iconData,
      ),
    );
  }
}
