import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final int id;
  final String email;
  final String username;
  final String password;
  final String phone;
  final Address address;
  final Name name;

  UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.phone,
    required this.address,
    required this.name,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class Address {
  final Geolocation geolocation;
  final String city;
  final String street;
  final int number;
  final String zipcode;

  Address({
    required this.geolocation,
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

@JsonSerializable()
class Geolocation {
  final String lat;
  final String long;

  Geolocation({required this.lat, required this.long});

  factory Geolocation.fromJson(Map<String, dynamic> json) =>
      _$GeolocationFromJson(json);
  Map<String, dynamic> toJson() => _$GeolocationToJson(this);
}

@JsonSerializable()
class Name {
  final String firstname;
  final String lastname;

  Name({required this.firstname, required this.lastname});

  factory Name.fromJson(Map<String, dynamic> json) => _$NameFromJson(json);
  Map<String, dynamic> toJson() => _$NameToJson(this);
}
