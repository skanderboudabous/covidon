import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class User{
  String email;
  String userId;
  String firstName;
  String lastName;
  String phone;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  User({
    @required this.email,
    @required this.userId,
    @required this.firstName,
    @required this.lastName,
    this.phone,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          runtimeType == other.runtimeType &&
          email == other.email &&
          userId == other.userId &&
          firstName == other.firstName &&
          lastName == other.lastName &&
          phone == other.phone);

  @override
  int get hashCode =>
      email.hashCode ^
      userId.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      phone.hashCode;

  @override
  String toString() {
    return 'User{' +
        ' email: $email,' +
        ' userId: $userId,' +
        ' firstName: $firstName,' +
        ' lastName: $lastName,' +
        ' phone: $phone,' +
        '}';
  }

  User copyWith({
    String email,
    String userId,
    String firstName,
    String lastName,
    String phone,
  }) {
    return new User(
      email: email ?? this.email,
      userId: userId ?? this.userId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': this.email,
      'userId': this.userId,
      'firstName': this.firstName,
      'lastName': this.lastName,
      'phone': this.phone,
    };
  }

 static fromMap(Map<String, dynamic> map) {
    return new User(
      email: map['email'] as String,
      userId: map['userId'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      phone: map['phone'] as String,
    );
  }  String toJson() => json.encode(toMap());

  static User fromJson(String source) => fromMap(json.decode(source));


//</editor-fold>
}