// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Debt extends Equatable {
  final String id;
  final String debtUser;
  final String description;
  final double totalQuantity;
  final DateTime dateOfCreation;
  final bool myOwnDebt;
  bool? debtRepaid;
  bool? isFavorite;
  bool? isDeleted;

  Debt({
    required this.id,
    required this.debtUser,
    required this.description,
    required this.totalQuantity,
    required this.dateOfCreation,
    required this.myOwnDebt,
    this.debtRepaid,
    this.isFavorite,
    this.isDeleted,
  }) {
    debtRepaid = debtRepaid ?? false;
    isFavorite = isFavorite ?? false;
    isDeleted = isDeleted ?? false;
  }

  @override
  List<Object?> get props => [
    id,
    debtUser,
    description,
    totalQuantity,
    dateOfCreation,
    debtRepaid,
    isDeleted,
    isFavorite,
  ];

  Debt copyWith({
    String? id,
    String? debtUser,
    String? description,
    double? totalQuantity,
    DateTime? dateOfCreation,
    bool? myOwnDebt,
    bool? debtRepaid,
    bool? isFavotite,
    bool? isDeleted,
  }) {
    return Debt(
      id: id ?? this.id,
      debtUser: debtUser ?? this.debtUser,
      description: description ?? this.description,
      totalQuantity: totalQuantity ?? this.totalQuantity,
      dateOfCreation: dateOfCreation ?? this.dateOfCreation,
      myOwnDebt: myOwnDebt ?? this.myOwnDebt,
      debtRepaid: debtRepaid ?? this.debtRepaid,
      isFavorite: isFavotite ?? this.isFavorite,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'debtUser': debtUser,
      'description': description,
      'totalQuantity': totalQuantity,
      'dateOfCreation': dateOfCreation.millisecondsSinceEpoch,
      'myOwnDebt': myOwnDebt,
      'debtRepaid': debtRepaid,
      'isFavotite': isFavorite,
      'isDeleted': isDeleted,
    };
  }

  factory Debt.fromMap(Map<String, dynamic> map) {
    return Debt(
      id: map['id'] as String,
      debtUser: map['debtUser'] as String,
      description: map['description'] as String,
      totalQuantity: map['totalQuantity'] as double,
      dateOfCreation: DateTime.fromMillisecondsSinceEpoch(
        map['dateOfCreation'] as int,
      ),
      myOwnDebt: map['myOwnDebt'] as bool,
      debtRepaid: map['debtRepaid'] != null ? map['debtRepaid'] as bool : null,
      isFavorite: map['isFavotite'] != null ? map['isFavotite'] as bool : null,
      isDeleted: map['isDeleted'] != null ? map['isDeleted'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Debt.fromJson(String source) =>
      Debt.fromMap(json.decode(source) as Map<String, dynamic>);
}
