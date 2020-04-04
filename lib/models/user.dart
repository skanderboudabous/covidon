import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class User{
  String email;
  String userId;
  String name;
  String phone;


//<editor-fold desc="Data Methods" defaultstate="collapsed">

  User({
    @required this.email,
    @required this.userId,
    @required this.name,
    this.phone,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          runtimeType == other.runtimeType &&
          email == other.email &&
          userId == other.userId &&
          name == other.name &&
          phone == other.phone);

  @override
  int get hashCode =>
      email.hashCode ^ userId.hashCode ^ name.hashCode ^ phone.hashCode;

  @override
  String toString() {
    return 'User{' +
        ' email: $email,' +
        ' userId: $userId,' +
        ' name: $name,' +
        ' phone: $phone,' +
        '}';
  }

  User copyWith({
    String email,
    String userId,
    String name,
    String phone,
  }) {
    return new User(
      email: email ?? this.email,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': this.email,
      'userId': this.userId,
      'name': this.name,
      'phone': this.phone,
    };
  }

  static fromMap(Map<String, dynamic> map) {
    return new User(
      email: map['email'] as String,
      userId: map['userId'] as String,
      name: map['name'] as String,
      phone: map['phone'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  static User fromJson(String source) => fromMap(json.decode(source));


//</editor-fold>
}