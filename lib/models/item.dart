import 'dart:convert';

import 'package:flutter/material.dart';

class Item{
  //TODO :add id variable to item for firestore collection document
  String product="";
  int quantity=0;
  String unity="";
  String dispoTime="";
  String type="";
  String userId="";
  String description="";


  Item({
    @required this.product,
    @required this.quantity,
    @required this.unity,
    @required this.dispoTime,
    @required this.type,
    @required this.userId,
    this.description,
  });

//</e@override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is Item &&
              runtimeType == other.runtimeType &&
              product == other.product &&
              quantity == other.quantity &&
              unity == other.unity &&
              dispoTime == other.dispoTime &&
              type == other.type &&
              userId == other.userId &&
              description == other.description
          );


  @override
  int get hashCode =>
      product.hashCode ^
      quantity.hashCode ^
      unity.hashCode ^
      dispoTime.hashCode ^
      type.hashCode ^
      userId.hashCode ^
      description.hashCode;


  @override
  String toString() {
    return 'Item{' +
        ' product: $product,' +
        ' quantite: $quantity,' +
        ' unity: $unity,' +
        ' dispoTime: $dispoTime,' +
        ' type: $type,' +
        ' userId: $userId,' +
        ' description: $description,' +
        '}';
  }


  Item copyWith({
    String product,
    int quantite,
    String unity,
    String dispoTime,
    String type,
    String userId,
    String description,
  }) {
    return new Item(
      product: product ?? this.product,
      quantity: quantite ?? this.quantity,
      unity: unity ?? this.unity,
      dispoTime: dispoTime ?? this.dispoTime,
      type: type ?? this.type,
      userId: userId ?? this.userId,
      description: description ?? this.description,
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'product': this.product,
      'quantite': this.quantity,
      'unity': this.unity,
      'dispoTime': this.dispoTime,
      'type': this.type,
      'userId': this.userId,
      'description': this.description,
    };
  }

 static fromMap(Map<String, dynamic> map) {
    return new Item(
      product: map['product'] as String,
      quantity: map['quantite'] as int,
      unity: map['unity'] as String,
      dispoTime: map['dispoTime'] as String,
      type: map['type'] as String,
      userId: map['userId'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  static Item fromJson(String source) => fromMap(json.decode(source));

}