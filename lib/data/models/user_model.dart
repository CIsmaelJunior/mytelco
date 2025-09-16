import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String name;
  final String phoneNumber;
  final double balance;
  final String balanceValidity;
  final double internetVolume;
  final int minutes;
  final int sms;
  final String volumeValidity;

  const UserModel({
    required this.name,
    required this.phoneNumber,
    required this.balance,
    required this.balanceValidity,
    required this.internetVolume,
    required this.minutes,
    required this.sms,
    required this.volumeValidity,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserModel copyWith({
    String? name,
    String? phoneNumber,
    double? balance,
    String? balanceValidity,
    double? internetVolume,
    int? minutes,
    int? sms,
    String? volumeValidity,
  }) {
    return UserModel(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      balance: balance ?? this.balance,
      balanceValidity: balanceValidity ?? this.balanceValidity,
      internetVolume: internetVolume ?? this.internetVolume,
      minutes: minutes ?? this.minutes,
      sms: sms ?? this.sms,
      volumeValidity: volumeValidity ?? this.volumeValidity,
    );
  }
}
