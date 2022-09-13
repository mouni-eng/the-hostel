import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_hostel/infrastructure/localizations/language.dart';
import 'package:the_hostel/theme/app_notifier.dart';
import 'package:the_hostel/theme/app_theme.dart';
import 'package:the_hostel/theme/theme_extension.dart';
import 'package:the_hostel/theme/theme_type.dart';
import 'package:the_hostel/view_models/profile_cubit/states.dart';
import 'package:provider/provider.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileStates());

  static ProfileCubit get(context) => BlocProvider.of(context);

  bool isDark = false;
  Language activeLanguage = Language.currentLanguage;

  init() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    ThemeType themeType =
        sharedPreferences.getString("theme_mode").toString().toThemeType;
    _changeTheme(themeType);
    await Language.init();
    changeLanguage(Language.currentLanguage);
  }

  updateTheme(ThemeType themeType) {
    _changeTheme(themeType);
    updateInStorage(themeType);
  }

  Future<void> updateInStorage(ThemeType themeType) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("theme_mode", themeType.toText);
  }

  void _changeTheme(ThemeType themeType) {
    AppTheme.themeType = themeType;
    AppTheme.customTheme = AppTheme.getCustomTheme(themeType);
    AppTheme.theme = AppTheme.getTheme(themeType);
    emit(SwitchThemeState());
  }

  Future<void> changeLanguage(Language language, [bool notify = true]) async {
    await Language.changeLanguage(language);
  }

  switchTheme(BuildContext context) {
    isDark = !isDark;
    if (isDark) {
      updateTheme(ThemeType.dark);
    } else {
      updateTheme(ThemeType.light);
    }
    emit(SwitchThemeState());
  }

  switchLanguage(final String lang) {
    final Language language = Language.getLanguageFromCode(lang);
    Language.changeLanguage(language).then((value) {
      activeLanguage = language;
      emit(SwitchLangState());
    });
  }

  logout() {
    /*_authService.logout().then((value) {
      emit(LoggedOutState(userDetails!.role!));
      userDetails = null;
    });*/
  }
}
