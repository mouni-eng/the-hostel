import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_hostel/constants.dart';
import 'package:the_hostel/infrastructure/localizations/language.dart';
import 'package:the_hostel/infrastructure/utils.dart';
import 'package:the_hostel/main.dart';
import 'package:the_hostel/models/signup_model.dart';
import 'package:the_hostel/services/local/cache_helper.dart';
import 'package:the_hostel/size_config.dart';
import 'package:the_hostel/view_models/owner_cubit/cubit.dart';
import 'package:the_hostel/view_models/profile_cubit/cubit.dart';
import 'package:the_hostel/view_models/profile_cubit/states.dart';
import 'package:the_hostel/view_models/student_cubit/cubit.dart';
import 'package:the_hostel/views/auth_views/user_login/login_view.dart';
import 'package:the_hostel/views/components/base_widget.dart';
import 'package:the_hostel/views/components/components/back_button.dart';
import 'package:the_hostel/views/components/components/choose_dialog.dart';
import 'package:the_hostel/views/components/components/custom_text.dart';
import 'package:the_hostel/views/components/components/rentalPropertyWidget.dart';
import 'package:the_hostel/views/components/profile_listile.dart';
import 'package:the_hostel/views/starting_screens/onBoarding_screen.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: userModel!.role == UserRole.student ? padding : EdgeInsets.zero,
      child: RentXWidget(
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
                              if (userModel!.role == UserRole.student) {
                                StudentCubit.get(context)
                                    .chooseBottomNavIndex(0);
                              } else {
                                OwnerCubit.get(context).changeBottomNav(0);
                              }
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
                                    color: rentxcontext
                                        .theme.customTheme.headline3,
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
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                              title: "Gender",
                              img: "assets/images/people-nav.svg",
                              isCustom: true,
                              subTitle: userModel!.gender!.name,
                            ),
                            const Divider(),
                            CustomProfileListTile(
                              title: "Notification",
                              img: "assets/images/remind.svg",
                              isNotify: true,
                            ),
                            const Divider(),
                            CustomProfileListTile(
                              title: "Language",
                              img: "assets/images/translate 1.svg",
                              onPressed: () {
                                showDialog(
                                    barrierColor: Colors.black.withOpacity(0.8),
                                    context: context,
                                    builder: (context) => ChooseDialog(
                                          title: "Choose Language",
                                          onChanged: (value) {
                                            cubit.switchLanguage(value);
                                            Navigator.of(context).pop();
                                          },
                                          options: Language.languages
                                              .map((e) => ChooseDialogOption(
                                                  key: e.locale.languageCode,
                                                  value: e.languageName))
                                              .toList(),
                                          selectedKey: Language.currentLanguage
                                              .locale.languageCode,
                                        ));
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
                                showDialog(
                                  context: context,
                                  builder: (context) => LogOutWidget(),
                                );
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
      ),
    );
  }
}

class LogOutWidget extends StatelessWidget {
  const LogOutWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RentXWidget(builder: (rentxcontext) {
      var color = rentxcontext.theme.customTheme;
      return Dialog(
        child: Container(
            width: double.infinity,
            height: height(150),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: color.onPrimary,
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  left: width(25),
                  top: height(25),
                  right: width(25),
                  bottom: height(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Log Out",
                    color: color.headline,
                    fontSize: width(14),
                  ),
                  CustomText(
                      text: "Are you sure you want to log out?",
                      fontSize: width(12),
                      color: color.headline3),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                          onTap: () async {
                            await FirebaseAuth.instance.signOut();
                            userModel == null;
                            CacheHelper.removeData(
                              key: 'uid',
                            ).then((value) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OnBoardingScreen()),
                                  (route) => false);
                            });
                          },
                          child: CustomText(
                              text: "Yes",
                              fontSize: width(14),
                              color: color.primary)),
                      SizedBox(
                        width: width(25),
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: CustomText(
                            text: "No",
                            color: color.primary,
                            fontSize: width(14),
                          )),
                    ],
                  ),
                ],
              ),
            )),
      );
    });
  }
}
