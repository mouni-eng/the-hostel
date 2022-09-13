import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:the_hostel/extensions/string_extension.dart';
import 'package:the_hostel/infrastructure/request.dart';
import 'package:the_hostel/infrastructure/utils.dart';
import 'package:the_hostel/models/address.dart';
import 'package:the_hostel/models/appartment_model.dart';
import 'package:the_hostel/models/signup_model.dart';
import 'package:the_hostel/views/components/base_widget.dart';

class ManagerBookingsModel {
  ManagerCompany? company;
  List<ApartmentBooking>? bookings;

  ManagerBookingsModel({this.company, this.bookings});

  ManagerBookingsModel.fromJson(Map<String, dynamic> json) {
    company = json['company'] != null
        ? ManagerCompany.fromJson(json['company'])
        : null;
    if (json['bookings'] != null) {
      bookings = <ApartmentBooking>[];
      json['bookings'].forEach((v) {
        bookings!.add(ApartmentBooking.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (company != null) {
      data['company'] = company!.toJson();
    }
    if (bookings != null) {
      data['bookings'] = bookings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ManagerCompany {
  String? name;
  Address? address;

  ManagerCompany({this.name, this.address});

  ManagerCompany.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    return data;
  }
}

class ApartmentBooking extends RentXSerialized {
  UserSignUpRequest? user;
  Rent? rentType;
  PaymentModel? paymentModel;
  AppartmentModel? appartmentModel;
  BookingStatus? status;
  DateTime? fromDate;
  DateTime? toDate;
  String? apUid, agentUid;

  ApartmentBooking.instance();

  ApartmentBooking({
    this.user,
    this.status,
    this.fromDate,
    this.toDate,
    this.paymentModel,
    this.apUid,
    this.agentUid,
    this.appartmentModel,
  });

  ApartmentBooking.fromJson(Map<String, dynamic> json) {
    user =
        json['user'] != null ? UserSignUpRequest.fromJson(json['user']) : null;
    status = EnumUtil.strToEnumNullable(BookingStatus.values, json['status']);
    fromDate = DateTime.tryParse(json['fromDate']);
    toDate = DateTime.tryParse(json['toDate']);
    paymentModel = PaymentModel.fromJson(json['paymentModel']);
    apUid = json['apUid'];
    agentUid = json['agentUid'];
    rentType = EnumUtil.strToEnumNullable(Rent.values, json['rentType']);
    appartmentModel = AppartmentModel.fromJson(json['appartmentModel']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['status'] = status!.name;
    data['fromDate'] = fromDate?.toIso8601String();
    data['toDate'] = toDate?.toIso8601String();
    data['paymentModel'] = paymentModel!.toJson();
    data['apUid'] = apUid;
    data['agentUid'] = agentUid;
    data['rentType'] = rentType!.name;
    data['appartmentModel'] = appartmentModel!.toJson();
    return data;
  }
}

class PaymentModel {
  List<Fees>? fees;
  double? totalPrice, pricePerDay;

  PaymentModel({
    required this.fees,
    required this.pricePerDay,
    required this.totalPrice,
  });

  PaymentModel.fromJson(Map<String, dynamic> json) {
     if (json['fees'] != null) {
      fees = <Fees>[];
      json['fees'].forEach((v) {
        fees!.add(Fees.fromJson(v));
      });
    }
    totalPrice = json['totalPrice'];
    pricePerDay = json['pricePerDay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (fees != null) {
      data['fees'] = fees!.map((v) => v.toJson()).toList();
    }
    data['totalPrice'] = totalPrice;
    data['pricePerDay'] = pricePerDay;
    return data;
  }
}

class Fees {
  FeesType? type;
  double? value;

  Fees({
    this.type,
    this.value,
  });

  Fees.fromJson(Map<String, dynamic> json) {
    type = EnumUtil.strToEnumNullable(FeesType.values, json['type']);
    value = json['lastName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type!.name;
    data['value'] = value;
    return data;
  }
}

enum FeesType { serviceFee }

class BookingUser {
  String? firstName;
  String? lastName;
  String? imageUrl;
  String? phoneNumber;
  String? email;

  BookingUser({this.firstName, this.lastName, this.imageUrl});

  BookingUser.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['imageUrl'] = imageUrl;
    return data;
  }

  String get fullName => '$firstName $lastName';
}

class BookingCar {
  String? make;
  String? model;
  String? licensePlate;

  String get fullName => '$make $model';

  BookingCar({this.make, this.model, this.licensePlate});

  BookingCar.fromJson(Map<String, dynamic> json) {
    make = json['make'];
    model = json['model'];
    licensePlate = json['licensePlate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['make'] = make;
    data['model'] = model;
    data['licensePlate'] = licensePlate;
    return data;
  }
}

class UserBooking extends RentXSerialized {
  String? id;
  BookingStatus? status;
  DateTime? fromDate;
  DateTime? toDate;
  double? pricePerDay;
  double? totalPrice;
  BookingCar? car;
  String? companyName;
  String? featuredImageUrl;

  UserBooking(
      {this.id,
      this.status,
      this.fromDate,
      this.toDate,
      this.totalPrice,
      this.car,
      this.companyName});

  UserBooking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = EnumUtil.strToEnumNullable(BookingStatus.values, json['status']);
    fromDate = parseDate(json['fromDate']);
    toDate = parseDate(json['toDate']);
    totalPrice = json['totalPrice'];
    pricePerDay = json['pricePerDay'] ?? totalPrice;
    featuredImageUrl = json['featuredImageUrl'];
    car = json['car'] != null ? BookingCar.fromJson(json['car']) : null;
    companyName = json['companyName'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status?.name.capitalize();
    data['fromDate'] = fromDate?.toIso8601String();
    data['toDate'] = toDate?.toIso8601String();
    data['totalPrice'] = totalPrice;
    data['totalPrice'] = pricePerDay;
    data['featuredImageUrl'] = featuredImageUrl;
    if (car != null) {
      data['car'] = car!.toJson();
    }
    data['companyName'] = companyName;
    return data;
  }
}

enum BookingStatus { pending, rejected, approved, cancelled, expired }

extension BookingStatusExtension on BookingStatus {
  Color getTextColor(RentXContext context) {
    switch (this) {
      case BookingStatus.approved:
        return context.theme.customTheme.onApprove;
      case BookingStatus.pending:
        return context.theme.customTheme.onPending;
      case BookingStatus.rejected:
        return context.theme.customTheme.onRejected;
      default:
        throw 'No color mapped for: ' + name;
    }
  }

  Color getBadgeColor(RentXContext context) {
    switch (this) {
      case BookingStatus.approved:
        return context.theme.customTheme.approve;
      case BookingStatus.pending:
        return context.theme.customTheme.pending;
      case BookingStatus.rejected:
        return context.theme.customTheme.rejected;
      default:
        throw 'No color mapped for: ' + name;
    }
  }
}

class CreateBookingResult {
  String? rentalId;
  String? fromDate;
  String? toDate;
  double? price;
  String? comments;
  String? paymentMethod;

  CreateBookingResult(
      {this.rentalId,
      this.fromDate,
      this.toDate,
      this.price,
      this.comments,
      this.paymentMethod});

  CreateBookingResult.fromJson(Map<String, dynamic> json) {
    rentalId = json['rentalId'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    price = json['price'];
    comments = json['comments'];
    paymentMethod = json['paymentMethod'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rentalId'] = rentalId;
    data['fromDate'] = fromDate;
    data['toDate'] = toDate;
    data['price'] = price;
    data['comments'] = comments;
    data['paymentMethod'] = paymentMethod;
    return data;
  }
}
