import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_hostel/constants.dart';
import 'package:the_hostel/infrastructure/utils.dart';
import 'package:the_hostel/models/signup_model.dart';
import 'package:the_hostel/services/local/cache_helper.dart';
import 'package:the_hostel/views/starting_screens/onBoarding_screen.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> register({required UserSignUpRequest model}) async {
    await _auth
        .createUserWithEmailAndPassword(
            email: model.email!, password: model.password!)
        .then((value) {
      model.personalId = value.user!.uid;
      saveUser(model: model);
    });
  }

  Future<void> saveUser({required UserSignUpRequest model}) async {
    await _firestore
        .collection("users")
        .doc(model.personalId)
        .set(model.toJson())
        .then((value) {
      userModel = model;
      CacheHelper.saveData(key: "uid", value: model.personalId);
    });
  }

  Future<void> login({required email, required password}) async {
    await _auth
        .signInWithEmailAndPassword(email: email!, password: password!)
        .then((value) async {
      await getUser(uid: value.user!.uid);
      CacheHelper.saveData(key: "uid", value: value.user!.uid);
    });
  }

  Future<UserSignUpRequest> getUser({String? uid}) async {
    var uId = await CacheHelper.getData(key: "uid");
    var response = await _firestore.collection("users").doc(uid ?? uId).get();
    var model = UserSignUpRequest.fromJson(response.data()!);
    userModel = model;
    printLn(model.toJson().toString());
    return model;
  }

  Future<void> verfiyPhoneNumber(
      {required phoneNumber,
      required void Function(String, int?) onSent}) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: "+20$phoneNumber",
      verificationCompleted: (PhoneAuthCredential auth) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: onSent,
      codeAutoRetrievalTimeout: (String codeRetrival) {},
    );
  }

  Future<void> confirmOtp({required vId, required code}) async {
    await _auth.signInWithCredential(
        PhoneAuthProvider.credential(verificationId: vId!, smsCode: code!));
  }

  
}
