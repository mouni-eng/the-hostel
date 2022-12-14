import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_hostel/infrastructure/request.dart';
import 'package:the_hostel/infrastructure/utils.dart';
import 'package:the_hostel/models/address.dart';
import 'package:the_hostel/models/appartment_model.dart';

class UserSignUpRequest extends RentXSerialized {
  String? email;
  String? name;
  String? username;
  String? surname;
  DateTime? birthdate;
  UserRole? role;
  Gender? gender;
  Address? address;
  String? password;
  String? confirmPassword;
  String? personalId;
  String? phoneNumber;
  String? profilePictureId;
  String? universty, government;

  UserSignUpRequest.instance();

  UserSignUpRequest(
      {this.email,
      this.name,
      this.username,
      this.surname,
      this.birthdate,
      this.role,
      this.address,
      this.password,
      this.confirmPassword,
      this.personalId,
      this.phoneNumber,
      this.government,
      this.gender,
      this.universty,
      this.profilePictureId});

  UserSignUpRequest.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    name = json['firstName'];
    surname = json['lastName'];
    birthdate = json['birthDate'].toDate();
    confirmPassword = json['confirmPassword'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    role = json['role'] == "student" ? UserRole.student : UserRole.owner;
    password = json['password'];
    personalId = json['personalId'];
    gender = EnumUtil.strToEnum(Gender.values, json['gender']);
    profilePictureId = json['profilePictureId'];
    government = json['government'];
    universty = json['universty'];
  }

  @override
  Map<String, dynamic> toJson() => {
        'email': email,
        'firstName': name,
        'lastName': surname,
        'username': username,
        'birthDate': birthdate ?? birthdate?.toIso8601String(),
        'role': role?.name,
        'address': address == null ? null : address!.toJson(),
        'password': password,
        'confirmPassword': confirmPassword,
        'personalId': personalId,
        'phoneNumber': phoneNumber,
        'profilePictureId': profilePictureId,
        'government': government,
        'gender': gender!.name,
        'universty': universty,
      };

  String getFullName() => '$name $surname';
}

enum UserRole { student, owner }
