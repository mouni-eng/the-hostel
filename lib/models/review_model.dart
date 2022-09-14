import 'package:the_hostel/infrastructure/request.dart';
import 'package:the_hostel/models/signup_model.dart';

class ReviewModel extends RentXSerialized {
  UserSignUpRequest? user;
  String? review, apUid;
  double? rating;
  ReviewModel(
      {required this.rating,
      required this.review,
      required this.apUid,
      required this.user});

  ReviewModel.instance();

  ReviewModel.fromJson(Map<String, dynamic> json) {
    review = json['review'];
    user = UserSignUpRequest.fromJson(json['user']);
    apUid = json['apUid'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['review'] = review ?? "";
    data['user'] = user!.toJson();
    data['apUid'] = apUid ?? "";
    data['rating'] = rating ?? "";
    return data;
  }
}
