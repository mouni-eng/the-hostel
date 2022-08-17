import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_hostel/constants.dart';
import 'package:the_hostel/models/appartment_model.dart';

class ApartmentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addApartment(AppartmentModel model) async {
    await _firestore
        .collection("apartments")
        .doc(model.apUid)
        .set(model.toJson());
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getApartment() async {
    return await _firestore
        .collection("apartments")
        .where("agentUid", isEqualTo: userModel!.personalId)
        .get();
  }
}
