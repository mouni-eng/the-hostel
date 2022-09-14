import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_hostel/constants.dart';
import 'package:the_hostel/models/appartment_model.dart';
import 'package:the_hostel/models/review_model.dart';

class ApartmentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addApartment(AppartmentModel model) async {
    await _firestore.collection(apartRef).doc(model.apUid).set(model.toJson());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getApartment() {
    return _firestore
        .collection(apartRef)
        .where("agentUid", isEqualTo: userModel!.personalId)
        .snapshots();
  }

  Future<void> addRating(ReviewModel rating) async {
    await _firestore
        .collection(rateRef)
        .doc(rating.user!.personalId)
        .set(rating.toJson());
  }
}
