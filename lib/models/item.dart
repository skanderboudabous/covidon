import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Item{

  String id;
  String type="";
  String choice="";
  String userId="";
  String description="";
  Timestamp timestamp;
  bool completed=false;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  Item({
    @required this.id,
    @required this.type,
    @required this.choice,
    @required this.userId,
    @required this.description,
    @required this.timestamp,
    @required this.completed,
  });

//</e@override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is Item &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              type == other.type &&
              choice == other.choice &&
              userId == other.userId &&
              description == other.description &&
              timestamp == other.timestamp &&
              completed == other.completed
          );


  @override
  int get hashCode =>
      id.hashCode ^
      type.hashCode ^
      choice.hashCode ^
      userId.hashCode ^
      description.hashCode ^
      timestamp.hashCode ^
      completed.hashCode;


  @override
  String toString() {
    return 'Item{' +
        ' id: $id,' +
        ' type: $type,' +
        ' choice: $choice,' +
        ' userId: $userId,' +
        ' description: $description,' +
        ' timestamp: $timestamp,' +
        ' completed: $completed,' +
        '}';
  }


  Item copyWith({
    String id,
    String type,
    String choice,
    String userId,
    String description,
    Timestamp timestamp,
    bool completed,
  }) {
    return new Item(
      id: id ?? this.id,
      type: type ?? this.type,
      choice: choice ?? this.choice,
      userId: userId ?? this.userId,
      description: description ?? this.description,
      timestamp: timestamp ?? this.timestamp,
      completed: completed ?? this.completed,
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'type': this.type,
      'choice': this.choice,
      'userId': this.userId,
      'description': this.description,
      'timestamp': this.timestamp,
      'completed': this.completed,
    };
  }

  static fromMap(Map<String, dynamic> map) {
    return new Item(
      id: map['id'] as String,
      type: map['type'] as String,
      choice: map['choice'] as String,
      userId: map['userId'] as String,
      description: map['description'] as String,
      timestamp: map['timestamp'] as Timestamp,
      completed: map['completed'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  static Item fromJson(String source) => fromMap(json.decode(source));
}