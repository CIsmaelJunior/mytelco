// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consommation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConsommationModel _$ConsommationModelFromJson(Map<String, dynamic> json) =>
    ConsommationModel(
      id: json['id'] as String,
      type: $enumDecode(_$ConsommationTypeEnumMap, json['type']),
      amount: (json['amount'] as num).toDouble(),
      destination: json['destination'] as String?,
      date: DateTime.parse(json['date'] as String),
      description: json['description'] as String,
    );

Map<String, dynamic> _$ConsommationModelToJson(ConsommationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$ConsommationTypeEnumMap[instance.type]!,
      'amount': instance.amount,
      'destination': instance.destination,
      'date': instance.date.toIso8601String(),
      'description': instance.description,
    };

const _$ConsommationTypeEnumMap = {
  ConsommationType.call: 'call',
  ConsommationType.sms: 'sms',
  ConsommationType.internet: 'internet',
};
