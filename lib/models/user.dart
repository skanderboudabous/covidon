import 'dart:convert';

import 'package:flutter/material.dart';

class User {
  String email;
  String userId;
  String firstName;
  String lastName;
  String phone;
  double lat;
  double long;
  bool hasLocation(){return (lat!=null && long!=null);}
  String fullName(){return firstName+" "+lastName;}
//<editor-fold desc="Data Methods" defaultstate="collapsed">

  User({
    @required this.email,
    @required this.userId,
    @required this.firstName,
    @required this.lastName,
    this.phone,
    this.lat,
    this.long,
  });

//</e@override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          runtimeType == other.runtimeType &&
          email == other.email &&
          userId == other.userId &&
          firstName == other.firstName &&
          lastName == other.lastName &&
          phone == other.phone &&
          lat == other.lat &&
          long == other.long);

  @override
  int get hashCode =>
      email.hashCode ^
      userId.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      phone.hashCode ^
      lat.hashCode ^
      long.hashCode;

  @override
  String toString() {
    return 'User{' +
        ' email: $email,' +
        ' userId: $userId,' +
        ' firstName: $firstName,' +
        ' lastName: $lastName,' +
        ' phone: $phone,' +
        ' lat: $lat,' +
        ' long: $long,' +
        '}';
  }

  User copyWith({
    String email,
    String userId,
    String firstName,
    String lastName,
    String phone,
    double lat,
    double long,
  }) {
    return new User(
      email: email ?? this.email,
      userId: userId ?? this.userId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      lat: lat ?? this.lat,
      long: long ?? this.long,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': this.email,
      'userId': this.userId,
      'firstName': this.firstName,
      'lastName': this.lastName,
      'phone': this.phone,
      'lat': this.lat,
      'long': this.long,
    };
  }

  static fromMap(Map<String, dynamic> map) {
    return new User(
      email: map['email'] as String,
      userId: map['userId'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      phone: map['phone'] as String,
      lat: map['lat'] as double,
      long: map['long'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  static User fromJson(String source) => fromMap(json.decode(source));
}
