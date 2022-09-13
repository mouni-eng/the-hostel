class CityModel {
  String city;

  CityModel({required this.city});

  static CityModel fromJson(Map<String, dynamic> json) {
    return CityModel(
      city: json['city'],
    );
  }

}
