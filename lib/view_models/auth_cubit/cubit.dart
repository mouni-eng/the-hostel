import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_hostel/infrastructure/utils.dart';
import 'package:the_hostel/models/signup_model.dart';
import 'package:the_hostel/services/auth_service.dart';
import 'package:the_hostel/services/file_service.dart';
import 'package:the_hostel/view_models/auth_cubit/states.dart';
import 'package:the_hostel/views/auth_views/user_registration/account_data_screen.dart';
import 'package:the_hostel/views/auth_views/user_registration/personal_data_screen.dart';
import 'package:the_hostel/views/auth_views/user_registration/verify_screen.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthStates());

  static AuthCubit get(context) => BlocProvider.of(context);

  GlobalKey formkey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();

  final AuthService _authService = AuthService();
  final FileService _fileService = FileService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  File? profileImage;
  UserSignUpRequest signUpRequest = UserSignUpRequest.instance();

  int featured = 0;
  int index = 0;
  bool isLast = false;
  double percent = 1 / 3;

  PageController controller = PageController();
  FocusNode focusNode = FocusNode();
  String? name,
      surName,
      phoneNumber,
      userName,
      email,
      password,
      confirmPassword,
      pin;
  UserRole category = UserRole.student;
  DateTime? birthDate;

  String? emailValidation;
  String? usernameValidation;
  String? verficationId;

  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();

  List<String> headers = [
    "Personal Data",
    "Account Data",
    "Verify your email",
  ];

  List<Widget> steps = [
    PersonalDataScreen(),
    AccountDataScreen(),
    VerifyEmailScreen(),
  ];

  onBackStep() {
    if (percent != 1 / 3) {
      percent -= 1 / 3;
      index -= 1;
      isLast = false;
      emit(OnBackRegistrationStep());
    }

    controller.previousPage(
        duration: const Duration(
          milliseconds: 750,
        ),
        curve: Curves.fastLinearToSlowEaseIn);
  }

  onNextStep() {
    if (percent != 1) {
      percent += 1 / 3;
      index += 1;
      if (index == 2) {
        isLast = true;
      }
      emit(OnNextRegistrationStep());
    }
    controller.nextPage(
        duration: const Duration(
          milliseconds: 750,
        ),
        curve: Curves.fastLinearToSlowEaseIn);
  }

  chooseImage(File file) async {
    profileImage = file;
    emit(ChooseProfileImageState());
  }

  onChangeName(String value) {
    name = value;
    signUpRequest.name = value;
    emit(OnChangeState());
  }

  onChangeCategory(UserRole value) {
    category = value;
    emit(OnChangeState());
  }

  onChangeSurName(String value) {
    surName = value;
    signUpRequest.surname = value;
    emit(OnChangeState());
  }

  onChangePhoneNumber(String value) {
    phoneNumber = value;
    signUpRequest.phoneNumber = value;
    emit(OnChangeState());
  }

  onChangeBirthDate(DateTime value) {
    birthDate = value;
    signUpRequest.birthdate = value;
    emit(OnChangeState());
  }

  onChangeUserName(String value) {
    usernameValidation = null;
    userName = value;
    signUpRequest.username = value;
    emit(OnChangeState());
  }

  onChangeEmailAddress(String value) {
    emailValidation = null;
    email = value;
    signUpRequest.email = value;
    emit(OnChangeState());
  }

  onChangePassword(String value) {
    password = value;
    signUpRequest.password = value;
    emit(OnChangeState());
  }

  onChangeConfirmPassword(String value) {
    confirmPassword = value;
    signUpRequest.confirmPassword = value;
    emit(OnChangeState());
  }

  onChangePin(String value) {
    pin = value;
    emit(OnChangeState());
  }

  verficationIdChanged(String value) {
    verficationId = value;
    emit(OnChangeState());
  }

  logIn() {
    emit(LogInLoadingState());
    _auth
        .signInWithEmailAndPassword(email: email!, password: password!)
        .then((value) {
      emit(LogInSuccessState());
    }).catchError((error) {
      emit(LogInErrorState(error: error.toString()));
    });
  }

  saveUser() {
    emit(RegisterLoadingState());
    _auth
        .createUserWithEmailAndPassword(
            email: signUpRequest.email!, password: signUpRequest.password!)
        .then((value) async {
      await uploadProfilePicture();
      signUpRequest.personalId = value.user!.uid;
      _firestore
          .collection("users")
          .doc(value.user!.uid)
          .set(signUpRequest.toJson());
    }).then((value) {
      onNextStep();
      verifyPhoneNumber();
      emit(RegisterSuccessState());
    }).catchError((error) {
      emit(RegisterErrorState(error: error.toString()));
    });
  }

  uploadProfilePicture() async {
    if (profileImage != null && signUpRequest.profilePictureId == null) {
      await _fileService.uploadFile(profileImage!).then((value) {
        signUpRequest.profilePictureId = value;
      }).catchError((error) {
        printLn(error);
      });
    }
  }

  verifyPhoneNumber() {
    _auth.verifyPhoneNumber(
      phoneNumber: "+20$phoneNumber",
      verificationCompleted: (PhoneAuthCredential auth) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String vId, int? token) {
        verficationIdChanged(vId);
        emit(CodeSentState());
      },
      codeAutoRetrievalTimeout: (String codeRetrival) {},
    );
  }

  Future<void> confirmOtp() async {
    emit(OtpConfirmedLoadingState());
    _auth
        .signInWithCredential(PhoneAuthProvider.credential(
            verificationId: verficationId!, smsCode: pin!))
        .then((value) {
      emit(OtpConfirmedSuccessState());
    }).catchError((error) {
      emit(OtpConfirmedErrorState(error: error.toString()));
    });
  }

  onNextValidation(context) {
    if (index == 0) {
      if (formKey1.currentState!.validate() && birthDate != null) {
        onNextStep();
      }
    } else if (index == 1) {
      if (formKey2.currentState!.validate()) {
        saveUser();
      }
    } else {
      if (formKey3.currentState!.validate()) {
        confirmOtp();
      }
    }
  }
}
