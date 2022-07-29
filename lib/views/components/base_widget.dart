import 'package:flutter/material.dart';
import 'package:the_hostel/infrastructure/localizations/translator.dart';
import 'package:the_hostel/theme/app_theme.dart';
import 'package:the_hostel/theme/theme_type.dart';


class RentXContext {
  final BuildContext context;
  final RentXTheme theme;

  String translate(String key) {
    return Translator.translate(key);
  }

  RentXContext(
      {required this.context, required this.theme});

  Future<dynamic> route(
      Widget Function(BuildContext context) routeSupplier) async {
    return Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => routeSupplier.call(context)));
  }


  void pop() {
    Navigator.of(context).pop();
  }
}

class RentXTheme {
  final CustomTheme customTheme;
  final ThemeData theme;
  final ThemeType themeType;

  RentXTheme(
      {required this.customTheme,
      required this.theme,
      required this.themeType});
}

class RentXWidget extends StatelessWidget {
  final Widget Function(RentXContext rentXContext) builder;

  const RentXWidget({Key? key, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      late ThemeData theme = AppTheme.theme;
      late CustomTheme customTheme = AppTheme.customTheme;
      var themeInfo = RentXTheme(
          customTheme: customTheme,
          theme: theme,
          themeType: AppTheme.themeType);
      var rentXContext =
          RentXContext(context: context, theme: themeInfo);
      return builder(rentXContext);
    });
  }
}
