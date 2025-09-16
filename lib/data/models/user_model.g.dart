// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  name: json['name'] as String,
  phoneNumber: json['phoneNumber'] as String,
  balance: (json['balance'] as num).toDouble(),
  balanceValidity: json['balanceValidity'] as String,
  internetVolume: (json['internetVolume'] as num).toDouble(),
  minutes: (json['minutes'] as num).toInt(),
  sms: (json['sms'] as num).toInt(),
  volumeValidity: json['volumeValidity'] as String,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'name': instance.name,
  'phoneNumber': instance.phoneNumber,
  'balance': instance.balance,
  'balanceValidity': instance.balanceValidity,
  'internetVolume': instance.internetVolume,
  'minutes': instance.minutes,
  'sms': instance.sms,
  'volumeValidity': instance.volumeValidity,
};
