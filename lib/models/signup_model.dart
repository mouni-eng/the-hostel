import 'package:the_hostel/infrastructure/request.dart';

class UserSignUpRequest extends RentXSerialized {
  String? email;
  String? name;
  String? username;
  String? surname;
  DateTime? birthdate;
  UserRole? role;
  String? password;
  String? confirmPassword;
  String? personalId;
  String? phoneNumber;
  String? profilePictureId;

  UserSignUpRequest.instance();

  UserSignUpRequest(
      {this.email,
      this.name,
      this.username,
      this.surname,
      this.birthdate,
      this.role,
      this.password,
      this.confirmPassword,
      this.personalId,
      this.phoneNumber,
      this.profilePictureId});

  @override
  Map<String, dynamic> toJson() => {
        'email': email,
        'firstName': name,
        'lastName': surname,
        'username': username,
        'birthDate': birthdate ?? birthdate!.toIso8601String(),
        'role': role?.name,
        'password': password,
        'confirmPassword': confirmPassword,
        'personalId': personalId,
        'phoneNumber': phoneNumber,
        'profilePictureId': profilePictureId
      };

  String getFullName() => '$name $surname';
}

enum UserRole { student, owner }
