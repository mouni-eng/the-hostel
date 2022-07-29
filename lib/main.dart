import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:the_hostel/view_models/auth_cubit/cubit.dart';
import 'package:the_hostel/view_models/onBoarding_cubit/cubit.dart';
import 'package:the_hostel/views/starting_screens/onBoarding_screen.dart';

void main() {
  runApp(const TheHostel());
}

class TheHostel extends StatelessWidget {
  const TheHostel({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => OnBoardingCubit()),
        BlocProvider(create: (_) => AuthCubit()),
      ],
      child: const Portal(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'The hostel',
          home: OnBoardingScreen(),
        ),
      ),
    );
  }
}
