import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_hostel/infrastructure/utils.dart';
import 'package:the_hostel/models/address.dart';
import 'package:the_hostel/services/local/cache_helper.dart';

class LocationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateLocation({required Address address}) async {
    String uid = CacheHelper.getData(key: "uid");
    printLn(uid);
    printLn(address.street2.toString());
    await _firestore
        .collection("users")
        .doc(uid)
        .update({"address": address.toJson()});
  }
}
