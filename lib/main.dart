import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:the_hostel/constants.dart';
import 'package:the_hostel/models/signup_model.dart';
import 'package:the_hostel/services/local/cache_helper.dart';
import 'package:the_hostel/theme/app_theme.dart';
import 'package:the_hostel/view_models/add_property_cubit/cubit.dart';
import 'package:the_hostel/view_models/auth_cubit/cubit.dart';
import 'package:the_hostel/view_models/home_cubit/cubit.dart';
import 'package:the_hostel/view_models/hostel_details_cubit/cubit.dart';
import 'package:the_hostel/view_models/location_cubit/cubit.dart';
import 'package:the_hostel/view_models/onBoarding_cubit/cubit.dart';
import 'package:the_hostel/view_models/onBoarding_cubit/states.dart';
import 'package:the_hostel/view_models/owner_cubit/cubit.dart';
import 'package:the_hostel/view_models/profile_cubit/cubit.dart';
import 'package:the_hostel/view_models/student_cubit/cubit.dart';
import 'package:the_hostel/view_models/wishList_cubit/cubit.dart';
import 'package:the_hostel/views/owner_views/owner_layout_view.dart';
import 'package:the_hostel/views/starting_screens/onBoarding_screen.dart';
import 'package:the_hostel/views/student_views/layout_view.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();

  runApp(TheHostel());
}

class TheHostel extends StatelessWidget {
  const TheHostel({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => OnBoardingCubit()..getUser()),
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(
            create: (_) => LocationCubit()
              ..fetchData()
              ..getAllApartments()),
        BlocProvider(create: (_) => OwnerCubit()..getUser()),
        BlocProvider(create: (_) => AddPropertyCubit()..getApartments()),
        BlocProvider(create: (_) => ProfileCubit()..init()),
        BlocProvider(create: (_) => StudentCubit()),
        BlocProvider(create: (_) => HostelDetailsCubit()),
        BlocProvider(create: (_) => HomeCubit()..getUser()),
        BlocProvider(create: (_) => WishListCubit()..getAllFavourites()),
      ],
      child: BlocConsumer<OnBoardingCubit, OnBoardingStates>(
          listener: (context, state) {},
          builder: (context, state) {
            OnBoardingCubit cubit = OnBoardingCubit.get(context);
            return Portal(
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: AppTheme.theme,
                title: 'The hostel',
                home: ConditionalBuilder(
                  condition: state is! GetUserLoadingState,
                  builder: (context) => cubit.getInitialPage(),
                  fallback: (context) => loading,
                ),
              ),
            );
          }),
    );
  }
}
