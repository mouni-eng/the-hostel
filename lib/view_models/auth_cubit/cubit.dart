import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_hostel/view_models/auth_cubit/states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthStates());

  static AuthCubit get(context) => BlocProvider.of(context);

}