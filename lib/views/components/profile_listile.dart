import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_hostel/constants.dart';
import 'package:the_hostel/size_config.dart';
import 'package:the_hostel/view_models/profile_cubit/cubit.dart';
import 'package:the_hostel/view_models/profile_cubit/states.dart';
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
    this.isNotify = false,
    this.subTitle = "",
  }) : super(key: key);

  final Function()? onPressed;
  final String title, img, subTitle;
  final bool isCustom, isNotify;

  @override
  Widget build(BuildContext context) {
    return RentXWidget(
      builder: (rentxcontext) => BlocConsumer<ProfileCubit, ProfileStates>(
          listener: (context, state) {},
          builder: (context, state) {
            ProfileCubit cubit = ProfileCubit.get(context);
            return ListTile(
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
                child: SvgPicture.asset(
                  img,
                  color: rentxcontext.theme.customTheme.primary,
                ),
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
                            fontSize: width(16),
                            text: subTitle),
                      ],
                    )
                  : isNotify
                      ? Switch.adaptive(
                          value: cubit.isNotify,
                          onChanged: (value) {
                            cubit.onChangeNotify();
                          })
                      : CustomBorderWidget(
                          rentxcontext: rentxcontext,
                          iconData:
                              const Icon(Icons.arrow_forward_ios_rounded)),
            );
          }),
    );
  }
}
