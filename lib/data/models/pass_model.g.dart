// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pass_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PassModel _$PassModelFromJson(Map<String, dynamic> json) => PassModel(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  activationDate: DateTime.parse(json['activationDate'] as String),
  expirationDate: DateTime.parse(json['expirationDate'] as String),
  icon: json['icon'] as String,
  status: $enumDecode(_$PassStatusEnumMap, json['status']),
  price: (json['price'] as num).toDouble(),
  validityDays: (json['validityDays'] as num).toInt(),
);

Map<String, dynamic> _$PassModelToJson(PassModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'activationDate': instance.activationDate.toIso8601String(),
  'expirationDate': instance.expirationDate.toIso8601String(),
  'icon': instance.icon,
  'status': _$PassStatusEnumMap[instance.status]!,
  'price': instance.price,
  'validityDays': instance.validityDays,
};

const _$PassStatusEnumMap = {
  PassStatus.active: 'active',
  PassStatus.expired: 'expired',
  PassStatus.cancelled: 'cancelled',
};
