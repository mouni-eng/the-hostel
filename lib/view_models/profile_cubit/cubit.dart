import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_hostel/view_models/profile_cubit/states.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileStates());

  static ProfileCubit get(context) => BlocProvider.of(context);
}
