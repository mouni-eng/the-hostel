import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:the_hostel/size_config.dart';
import 'package:the_hostel/views/components/base_widget.dart';

import 'custom_text.dart';

class DotBadge extends StatelessWidget {
  const DotBadge({
    Key? key,
    required this.title,
    required this.color,
  }) : super(key: key);

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return RentXWidget(
      builder: (rentxcontext) => Row(
        children: [
          SvgPicture.asset(
            "assets/images/ellipse.svg",
            color: color,
          ),
          SizedBox(
            width: width(5),
          ),
          CustomText(
            color: color,
            fontSize: width(14),
            text: title,
          ),
        ],
      ),
    );
  }
}
