import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_hostel/constants.dart';
import 'package:the_hostel/infrastructure/localizations/language.dart';
import 'package:the_hostel/infrastructure/utils.dart';
import 'package:the_hostel/size_config.dart';
import 'package:the_hostel/view_models/profile_cubit/cubit.dart';
import 'package:the_hostel/view_models/profile_cubit/states.dart';
import 'package:the_hostel/views/components/base_widget.dart';
import 'package:the_hostel/views/components/components/back_button.dart';
import 'package:the_hostel/views/components/components/custom_text.dart';
import 'package:the_hostel/views/components/components/rentalPropertyWidget.dart';
import 'package:the_hostel/views/components/profile_listile.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RentXWidget(
      builder: (rentxcontext) => BlocConsumer<ProfileCubit, ProfileStates>(
        listener: (context, state) {
          /*if (state is LoggedOutState) {
            if (state.loggedUserRole == UserRole.manager) {
              HomeCubit.get(context).getHomeData();
            }
            HomeCubit.get(context).chooseBottomNavIndex(0);
            rentxcontext.route((p0) => const LayoutScreen());
          }*/
        },
        builder: (context, state) {
          ProfileCubit cubit = ProfileCubit.get(context);
          return SafeArea(
              child: Scaffold(
            body: ConditionalBuilder(
              condition: userModel != null,
              builder: (context) => SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CustomBorderWidget(
                          rentxcontext: rentxcontext,
                          iconData: const Icon(Icons.arrow_back_ios_rounded),
                          onTap: () {
                            /*if (cubit.userDetails!.role == UserRole.client) {
                              HomeCubit.get(context).chooseBottomNavIndex(0);
                            } else {
                              ManagerCubit.get(context).changeBottomNav(0);
                            }*/
                          },
                        ),
                        SizedBox(
                          width: width(16),
                        ),
                        CustomText(
                          color: rentxcontext.theme.customTheme.headline,
                          fontSize: width(22),
                          text: "profile",
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height(32),
                    ),
                    Container(
                      padding: padding,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [boxShadow],
                        color: rentxcontext.theme.customTheme.onPrimary,
                      ),
                      child: Row(
                        children: [
                          CustomNetworkImage(
                            url: userModel!.profilePictureId ?? "",
                            avatarLetters: NameUtil.getInitials(
                                userModel!.name, userModel!.surname),
                          ),
                          SizedBox(
                            width: width(15),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  color:
                                      rentxcontext.theme.customTheme.headline,
                                  fontSize: width(18),
                                  text: userModel!.getFullName(),
                                  fontWeight: FontWeight.w600,
                                ),
                                CustomText(
                                  color:
                                      rentxcontext.theme.customTheme.headline3,
                                  fontSize: width(14),
                                  text: userModel!.email!,
                                  fontWeight: FontWeight.w400,
                                ),
                                SizedBox(
                                  height: height(10),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: width(5),
                                        vertical: height(5),
                                      ),
                                      decoration: BoxDecoration(
                                        color: rentxcontext
                                            .theme.customTheme.primary,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: CustomText(
                                        color: rentxcontext
                                            .theme.customTheme.onPrimary,
                                        fontSize: width(12),
                                        text: "Edit Profile",
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const Spacer(),
                                    CustomBorderWidget(
                                      rentxcontext: rentxcontext,
                                      iconData: const Icon(
                                          Icons.arrow_forward_ios_rounded),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height(35),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: width(5),
                        vertical: height(8),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: rentxcontext.theme.customTheme.outerBorder,
                          )),
                      child: Column(
                        children: [
                          CustomProfileListTile(
                            title: "Wallet",
                            img: "assets/images/bank-transfer.svg",
                            onPressed: () {},
                          ),
                          const Divider(),
                          CustomProfileListTile(
                            title: "Notification",
                            img: "assets/images/remind.svg",
                            onPressed: () {},
                          ),
                          const Divider(),
                          CustomProfileListTile(
                            title: "Dark Mode",
                            isDark: true,
                            img: "assets/images/moon.svg",
                            onPressed: () => {},
                          ),
                          const Divider(),
                          CustomProfileListTile(
                            title: "Language",
                            img: "assets/images/translate 1.svg",
                            onPressed: () {
                              /*showDialog(
                              barrierColor: Colors.black.withOpacity(0.8),
                              context: context,
                              builder: (context) => ChooseDialog(
                                    title: "chooseLanguage",
                                    onChanged: (value) {
                                      cubit.switchLanguage(value);
                                      Navigator.of(context).pop();
                                    },
                                    options: Language.languages
                                        .map((e) => ChooseDialogOption(
                                            key: e.locale.languageCode,
                                            value: e.languageName))
                                        .toList(),
                                    selectedKey: Language
                                        .currentLanguage.locale.languageCode,
                                  ));*/
                            },
                          ),
                          const Divider(),
                          CustomProfileListTile(
                            title: "Help And Support",
                            img: "assets/images/help.svg",
                            onPressed: () {},
                          ),
                          const Divider(),
                          CustomProfileListTile(
                            title: "LogOut",
                            img: "assets/images/logout.svg",
                            onPressed: () {
                              //cubit.logout();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              fallback: (BuildContext context) => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
          ));
        },
      ),
    );
  }
}
