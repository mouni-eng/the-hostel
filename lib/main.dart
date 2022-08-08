import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:the_hostel/services/local/cache_helper.dart';
import 'package:the_hostel/view_models/add_property_cubit/cubit.dart';
import 'package:the_hostel/view_models/auth_cubit/cubit.dart';
import 'package:the_hostel/view_models/location_cubit/cubit.dart';
import 'package:the_hostel/view_models/onBoarding_cubit/cubit.dart';
import 'package:the_hostel/view_models/owner_cubit/cubit.dart';
import 'package:the_hostel/views/owner_views/owner_layout_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();

  runApp(const TheHostel());
}

class TheHostel extends StatelessWidget {
  const TheHostel({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => OnBoardingCubit()),
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => LocationCubit()..fetchData()),
        BlocProvider(create: (_) => OwnerCubit()..getUser()),
        BlocProvider(create: (_) => AddPropertyCubit()),
      ],
      child: const Portal(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'The hostel',
          home: OwnerLayoutView(),
        ),
      ),
    );
  }
}
