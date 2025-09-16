import 'package:json_annotation/json_annotation.dart';

part 'consommation_model.g.dart';

@JsonSerializable()
class ConsommationModel {
  final String id;
  final ConsommationType type;
  final double amount;
  final String? destination;
  final DateTime date;
  final String description;

  const ConsommationModel({
    required this.id,
    required this.type,
    required this.amount,
    this.destination,
    required this.date,
    required this.description,
  });

  factory ConsommationModel.fromJson(Map<String, dynamic> json) =>
      _$ConsommationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConsommationModelToJson(this);

  ConsommationModel copyWith({
    String? id,
    ConsommationType? type,
    double? amount,
    String? destination,
    DateTime? date,
    String? description,
  }) {
    return ConsommationModel(
      id: id ?? this.id,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      destination: destination ?? this.destination,
      date: date ?? this.date,
      description: description ?? this.description,
    );
  }

  String get formattedAmount {
    switch (type) {
      case ConsommationType.call:
        return '${amount.toInt()} ${amount == 1 ? 'minute' : 'minutes'}';
      case ConsommationType.sms:
        return '${amount.toInt()} sms';
      case ConsommationType.internet:
        return '${amount.toStringAsFixed(0)} Mb utilisés';
    }
  }
}

enum ConsommationType {
  @JsonValue('call')
  call,
  @JsonValue('sms')
  sms,
  @JsonValue('internet')
  internet,
}
