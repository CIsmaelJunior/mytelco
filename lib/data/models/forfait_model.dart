import 'package:json_annotation/json_annotation.dart';

part 'forfait_model.g.dart';

@JsonSerializable()
class ForfaitModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final int validityDays;
  final String icon;
  final List<String> features;
  final bool isPopular;
  final ForfaitType type;

  const ForfaitModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.validityDays,
    required this.icon,
    required this.features,
    this.isPopular = false,
    required this.type,
  });

  factory ForfaitModel.fromJson(Map<String, dynamic> json) =>
      _$ForfaitModelFromJson(json);

  Map<String, dynamic> toJson() => _$ForfaitModelToJson(this);

  ForfaitModel copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    int? validityDays,
    String? icon,
    List<String>? features,
    bool? isPopular,
    ForfaitType? type,
  }) {
    return ForfaitModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      validityDays: validityDays ?? this.validityDays,
      icon: icon ?? this.icon,
      features: features ?? this.features,
      isPopular: isPopular ?? this.isPopular,
      type: type ?? this.type,
    );
  }
}

enum ForfaitType {
  @JsonValue('internet')
  internet,
  @JsonValue('voice')
  voice,
  @JsonValue('mixed')
  mixed,
}
