import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_hostel/constants.dart';
import 'package:the_hostel/infrastructure/utils.dart';
import 'package:the_hostel/models/appartment_model.dart';
import 'package:the_hostel/models/review_model.dart';

class HomeService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> getAllApartments() async {
    return await _firestore
        .collection(apartRef)
        .where("gender", isEqualTo: userModel!.gender!.name)
        .get();
  }

  Future<List<ReviewModel>> getReviews(
      {required AppartmentModel apartmentModel}) async {
    List<ReviewModel> reviews = [];
    await _firestore
        .collection(rateRef)
        .where("apUid", isEqualTo: apartmentModel.apUid)
        .get()
        .then((value) {
      for (var review in value.docs) {
        reviews.add(ReviewModel.fromJson(review.data()));
      }
    });
    return reviews;
  }

  Future<List<ReviewModel>> getAverageRating(
      {required AppartmentModel apartmentModel}) async {
    List<ReviewModel> reviews = [];
    await _firestore
        .collection(apartRef)
        .where("apUid", isEqualTo: apartmentModel.apUid)
        .firestore
        .collection(rateRef)
        .get()
        .then((value) {
      for (var review in value.docs) {
        reviews.add(ReviewModel.fromJson(review.data()));
      }
    });
    return reviews;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getRecommendApartment() async {
    return await _firestore
        .collection(apartRef)
        .where("booked", isGreaterThanOrEqualTo: 0)
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getStayWithUsApartment() async {
    return await _firestore
        .collection(apartRef)
        .where("booked", isGreaterThan: 0)
        .get();
  }
}
