import 'package:json_annotation/json_annotation.dart';

part 'pass_model.g.dart';

@JsonSerializable()
class PassModel {
  final String id;
  final String name;
  final String description;
  final DateTime activationDate;
  final DateTime expirationDate;
  final String icon;
  final PassStatus status;
  final double price;
  final int validityDays;

  const PassModel({
    required this.id,
    required this.name,
    required this.description,
    required this.activationDate,
    required this.expirationDate,
    required this.icon,
    required this.status,
    required this.price,
    required this.validityDays,
  });

  factory PassModel.fromJson(Map<String, dynamic> json) =>
      _$PassModelFromJson(json);

  Map<String, dynamic> toJson() => _$PassModelToJson(this);

  PassModel copyWith({
    String? id,
    String? name,
    String? description,
    DateTime? activationDate,
    DateTime? expirationDate,
    String? icon,
    PassStatus? status,
    double? price,
    int? validityDays,
  }) {
    return PassModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      activationDate: activationDate ?? this.activationDate,
      expirationDate: expirationDate ?? this.expirationDate,
      icon: icon ?? this.icon,
      status: status ?? this.status,
      price: price ?? this.price,
      validityDays: validityDays ?? this.validityDays,
    );
  }

  int get remainingDays {
    final now = DateTime.now();
    final difference = expirationDate.difference(now).inDays;
    return difference > 0 ? difference : 0;
  }

  double get progressPercentage {
    final totalDays = expirationDate.difference(activationDate).inDays;
    final remainingDays = this.remainingDays;
    return totalDays > 0 ? (totalDays - remainingDays) / totalDays : 0.0;
  }
}

enum PassStatus {
  @JsonValue('active')
  active,
  @JsonValue('expired')
  expired,
  @JsonValue('cancelled')
  cancelled,
}
