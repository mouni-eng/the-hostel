import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:the_hostel/infrastructure/request.dart';
import 'package:the_hostel/infrastructure/utils.dart';

class AppartmentModel extends RentXSerialized {
  String? name, description;
  int? floor, rooms, bathroom, capacity;
  double? price;
  HostelDuration? duration;
  Elevation? elevation;
  Rent? rent;
  List<String>? images;
  List<BedFeaturesClass>? bedFeatures;
  List<HeatingAndCoolingClass>? heatingAndCooling;
  List<BathroomFeaturesClass>? bathroomFeatures;
  List<KitchenFeaturesClass>? kitchenFeatures;

  AppartmentModel({
    required this.name,
    required this.description,
    required this.floor,
    required this.rooms,
    required this.bathroom,
    required this.capacity,
    required this.price,
    required this.duration,
    required this.elevation,
    required this.rent,
    required this.images,
    required this.bedFeatures,
    required this.bathroomFeatures,
    required this.heatingAndCooling,
    required this.kitchenFeatures,
  });

  AppartmentModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    floor = json['floor'];
    rooms = json['rooms'];
    bathroom = json['bathroom'];
    capacity = json['capacity'];
    price = json['price'];
    duration = EnumUtil.strToEnum(HostelDuration.values, json['duration']);
    elevation = EnumUtil.strToEnum(Elevation.values, json['elevation']);
    rent = EnumUtil.strToEnum(Rent.values, json['rent']);
    images = convertList(json['images'] as List, (p0) => p0);
    bedFeatures = super.convertList(
        json['bedFeatures'] as List, (p0) => BedFeaturesClass.fromJson(p0));
    heatingAndCooling = super.convertList(json['heatingAndCooling'] as List,
        (p0) => HeatingAndCoolingClass.fromJson(p0));
    kitchenFeatures = super.convertList(json['kitchenFeatures'] as List,
        (p0) => KitchenFeaturesClass.fromJson(p0));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'floor': floor,
      'rooms': rooms,
      'bathroom': bathroom,
      'capacity': capacity,
      'price': price,
      'duration': duration!.name,
      'elevation': elevation!.name,
      'rent': rent!.name,
      'images': images == null ? [] : images!.map((e) => e).toList(),
      'bedFeatures': bedFeatures == null
          ? []
          : bedFeatures!.map((e) => e.toJson()).toList(),
      'bathroomFeatures': bathroomFeatures == null
          ? []
          : bathroomFeatures!.map((e) => e.toJson()).toList(),
      'heatingAndCooling': heatingAndCooling == null
          ? []
          : heatingAndCooling!.map((e) => e.toJson()).toList(),
      'kitchenFeatures': kitchenFeatures == null
          ? []
          : kitchenFeatures!.map((e) => e.toJson()).toList(),
    };
  }
}

class BedFeaturesClass extends RentXSerialized {
  BedFeatures featuretype;
  String value;
  bool selected;


  BedFeaturesClass({required this.featuretype, required this.value, this.selected = false});

  static BedFeaturesClass fromJson(Map<String, dynamic> json) {
    return BedFeaturesClass(
        featuretype: EnumUtil.strToEnum(BedFeatures.values, json['key']),
        value: json['value'],
        selected: json['selected'],);
  }

  Map<String, dynamic> toJson() {
    return {'key': featuretype.name, 'value': value, 'selected': selected,};
  }
}

class HeatingAndCoolingClass {
  HeatingAndCooling featuretype;
  String value;
  bool selected;

  HeatingAndCoolingClass({required this.featuretype, required this.value, this.selected = false});

  static HeatingAndCoolingClass fromJson(Map<String, dynamic> json) {
    return HeatingAndCoolingClass(
        featuretype: EnumUtil.strToEnum(HeatingAndCooling.values, json['key']),
        value: json['value'],
                selected: json['selected'],
);
  }

  Map<String, dynamic> toJson() {
    return {'key': featuretype.name, 'value': value, 'selected': selected,};
  }
}

class BathroomFeaturesClass {
  BathroomFeatures featuretype;
  String value;
  bool selected;

  BathroomFeaturesClass({required this.featuretype, required this.value, this.selected = false});

  static BathroomFeaturesClass fromJson(Map<String, dynamic> json) {
    return BathroomFeaturesClass(
        featuretype: EnumUtil.strToEnum(BathroomFeatures.values, json['key']),
        value: json['value'],
        selected: json['selected'],
      );
  }

  Map<String, dynamic> toJson() {
    return {'key': featuretype.name, 'value': value, 'selected': selected,};
  }
}

class KitchenFeaturesClass {
  KitchenFeatures featuretype;
  String value;
  bool selected;

  KitchenFeaturesClass(
      {required this.featuretype, required this.value, this.selected = false});

  static KitchenFeaturesClass fromJson(Map<String, dynamic> json) {
    return KitchenFeaturesClass(
        featuretype: EnumUtil.strToEnum(KitchenFeatures.values, json['key']),
        value: json['value'],
        selected: json['selected'],);
  }

  Map<String, dynamic> toJson() {
    return {'key': featuretype.name, 'value': value, 'selected': selected};
  }
}

enum HostelDuration { day, month, week }

enum Elevation { front, back }

enum Rent { appartment, room, bed }

enum BedFeatures {
  pellowsblankets,
  cover,
  iron,
  closet,
  hangers,
}

enum KitchenFeatures {
  microwave,
  fridge,
  cooker,
  kettle,
  blender,
  washer,
  table,
  dishes,
  naturalgas
}

enum HeatingAndCooling {
  airconditioning,
  heating,
  fan,
}

enum BathroomFeatures {
  hotwater,
  hairdryer,
  bathtub,
  washer,
}

extension BedFeaturesExtension on BedFeatures {
  String get name => describeEnum(this);

  IconData? get icon {
    switch (this) {
      case BedFeatures.closet:
        return Icons.view_column_rounded;
      case BedFeatures.cover:
        return Icons.panorama_vertical_rounded;
      case BedFeatures.hangers:
        return Icons.dry_cleaning_outlined;
      case BedFeatures.iron:
        return Icons.iron_outlined;
      case BedFeatures.pellowsblankets:
        return Icons.panorama_wide_angle;
      default:
        return null;
    }
  }
}

extension KitchenFeaturesExtension on KitchenFeatures {
  String get name => describeEnum(this);

  IconData? get icon {
    switch (this) {
      case KitchenFeatures.blender:
        return Icons.blender_outlined;
      case KitchenFeatures.cooker:
        return Icons.casino_outlined;
      case KitchenFeatures.dishes:
        return Icons.local_dining_outlined;
      case KitchenFeatures.fridge:
        return Icons.sensor_door_outlined;
      case KitchenFeatures.kettle:
        return Icons.coffee_maker_outlined;
      case KitchenFeatures.microwave:
        return Icons.microwave_outlined;
      case KitchenFeatures.naturalgas:
        return Icons.swap_calls;
      case KitchenFeatures.table:
        return Icons.deck;
      case KitchenFeatures.washer:
        return Icons.calendar_today_sharp;
      default:
        return null;
    }
  }
}

extension BathroomFeaturesExtension on BathroomFeatures {
  String get name => describeEnum(this);

  IconData? get icon {
    switch (this) {
      case BathroomFeatures.bathtub:
        return Icons.bathtub_outlined;
      case BathroomFeatures.hairdryer:
        return Icons.air;
      case BathroomFeatures.hotwater:
        return Icons.hot_tub;
      case BathroomFeatures.washer:
        return Icons.wash;
      default:
        return null;
    }
  }
}

extension HeatingAndCoolingExtension on HeatingAndCooling {
  String get name => describeEnum(this);

  IconData? get icon {
    switch (this) {
      case HeatingAndCooling.airconditioning:
        return Icons.ac_unit;
      case HeatingAndCooling.fan:
        return Icons.filter_vintage_outlined;
      case HeatingAndCooling.heating:
        return Icons.whatshot_outlined;
      default:
        return null;
    }
  }
}
