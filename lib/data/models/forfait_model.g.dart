// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forfait_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForfaitModel _$ForfaitModelFromJson(Map<String, dynamic> json) => ForfaitModel(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  price: (json['price'] as num).toDouble(),
  validityDays: (json['validityDays'] as num).toInt(),
  icon: json['icon'] as String,
  features: (json['features'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  isPopular: json['isPopular'] as bool? ?? false,
  type: $enumDecode(_$ForfaitTypeEnumMap, json['type']),
);

Map<String, dynamic> _$ForfaitModelToJson(ForfaitModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'validityDays': instance.validityDays,
      'icon': instance.icon,
      'features': instance.features,
      'isPopular': instance.isPopular,
      'type': _$ForfaitTypeEnumMap[instance.type]!,
    };

const _$ForfaitTypeEnumMap = {
  ForfaitType.internet: 'internet',
  ForfaitType.voice: 'voice',
  ForfaitType.mixed: 'mixed',
};
