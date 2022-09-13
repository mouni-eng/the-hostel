import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_hostel/constants.dart';
import 'package:the_hostel/models/transportation_model.dart';
import 'package:the_hostel/services/auth_service.dart';

class TransportationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();

  Future<QuerySnapshot<Map<String, dynamic>>> getTransportation(
      Transportation type) async {
    await _authService.getUser();
    return await _firestore
        .collection(transRef)
        .where("uId", isEqualTo: userModel!.personalId)
        .where("transportationType", isEqualTo: type.name)
        .get();
  }

  Future<int> getVotedNumber({required String name}) async {
    var resp = await _firestore
        .collection(transRef)
        .where("to", isEqualTo: name)
        .get();
    return resp.docs.length;
  }

  Future<void> addTransportation(
      {required TransportationModel transportationModel}) async {
    await _firestore
        .collection(transRef)
        .doc(transportationModel.uId)
        .set(transportationModel.toJson());
  }

  Future<void> updateGovernoment(String government) async{
    await _firestore
        .collection(userRef)
        .doc(userModel!.personalId)
        .update({"government": government});
  }

    Future<void> updateUniversty(String universty) async{
    await _firestore
        .collection(userRef)
        .doc(userModel!.personalId)
        .update({"universty": universty});
  }


}
