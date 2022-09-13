import 'package:the_hostel/constants.dart';
import 'package:the_hostel/infrastructure/request.dart';
import 'package:the_hostel/infrastructure/utils.dart';

class TransportationModel extends RentXSerialized {
  Transportation? transportationType;
  String? from, to, voted, minNumber, uId;

  TransportationModel(
      {required this.from,
      required this.to,
      required this.minNumber,
      required this.transportationType,
      this.uId,
      required this.voted});

  TransportationModel.instance();


  static TransportationModel fromJson(Map<String, dynamic> json) {
    return TransportationModel(
      transportationType: EnumUtil.strToEnum(Transportation.values, json['transportationType']),
      from: json['from'],
      to: json['to'],
      voted: json['voted'],
      minNumber: json['minNumber'] ?? "6",
      uId: json['uId'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'transportationType': transportationType!.name,
        'from': from,
        'to': to,
        'voted': voted,
        'minNumber': minNumber,
        'uId': userModel!.personalId ?? "",
      };
}

enum Transportation { weekly, daily }
