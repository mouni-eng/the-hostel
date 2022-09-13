class ReviewModel {
  String? review, apUid;
  int? rating;
  ReviewModel({required this.rating, required this.review, required this.apUid});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    review = json['review'];
    apUid = json['apUid'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['review'] = review ?? "";
    data['apUid'] = apUid ?? "";
    data['rating'] = rating ?? "";
    return data;
  }
}
