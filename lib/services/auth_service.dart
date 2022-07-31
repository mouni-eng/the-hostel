import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_hostel/models/signup_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  register({required UserSignUpRequest model}) {
    _auth
        .createUserWithEmailAndPassword(
            email: model.email!, password: model.password!)
        .then((value) {
      model.personalId = value.user!.uid;
      _firestore.collection("users").doc(value.user!.uid).set(model.toJson());
    });
  }
}
