import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_hostel/constants.dart';
import 'package:the_hostel/infrastructure/utils.dart';
import 'package:the_hostel/models/booking_model.dart';

class BookingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addBooking(ApartmentBooking booking) async {
    await _firestore
        .collection(bookingRef)
        .doc(userModel!.personalId)
        .set(booking.toJson())
        .then((value) {
      _firestore.collection(apartRef).doc(booking.apUid).update({
        "booked":
            StringUtil.increaseBookings(booking),
      });
    });
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getBooking() {
    return _firestore
        .collection(bookingRef)
        .doc(userModel!.personalId)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllBookings() {
    return _firestore
        .collection(bookingRef)
        .where("agentUid", isEqualTo: userModel!.personalId)
        .snapshots();
  }

  Future<void> updateBookingStatus(String? userId) async {
    await _firestore
        .collection(bookingRef)
        .doc(userId)
        .update({"status": BookingStatus.approved.name});
  }
}
