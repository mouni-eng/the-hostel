import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_hostel/constants.dart';
import 'package:the_hostel/models/appartment_model.dart';

class FavouriteService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getFavouriteApartments() {
    return  _firestore
        .collection(userRef)
        .doc(userModel!.personalId)
        .collection(favRef)
        .snapshots();
  }

  Future<void> addToFavourite({required AppartmentModel apartment}) async {
    await _firestore
        .collection(userRef)
        .doc(userModel!.personalId)
        .collection(favRef)
        .doc(apartment.apUid)
        .set(apartment.toJson());
  }

  Future<void> deleteFromFavourite({required AppartmentModel apartment}) async {
    await _firestore
        .collection(userRef)
        .doc(userModel!.personalId)
        .collection(favRef)
        .doc(apartment.apUid)
        .delete();
  }
}
