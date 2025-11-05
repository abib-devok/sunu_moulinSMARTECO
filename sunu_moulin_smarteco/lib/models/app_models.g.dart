// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  id: json['id'] as String,
  username: json['username'] as String,
  language: json['language'] as String,
  role: json['role'] as String,
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'language': instance.language,
  'role': instance.role,
};

Device _$DeviceFromJson(Map<String, dynamic> json) => Device(
  deviceId: json['deviceId'] as String,
  name: json['name'] as String,
  status: json['status'] as String,
);

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
  'deviceId': instance.deviceId,
  'name': instance.name,
  'status': instance.status,
};

Session _$SessionFromJson(Map<String, dynamic> json) => Session(
  sessionId: json['sessionId'] as String,
  deviceId: json['deviceId'] as String,
  startTime: DateTime.parse(json['startTime'] as String),
  endTime: json['endTime'] == null
      ? null
      : DateTime.parse(json['endTime'] as String),
  cerealType: json['cerealType'] as String,
  quantity: (json['quantity'] as num).toDouble(),
  fineness: json['fineness'] as String,
  status: json['status'] as String,
);

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
  'sessionId': instance.sessionId,
  'deviceId': instance.deviceId,
  'startTime': instance.startTime.toIso8601String(),
  'endTime': instance.endTime?.toIso8601String(),
  'cerealType': instance.cerealType,
  'quantity': instance.quantity,
  'fineness': instance.fineness,
  'status': instance.status,
};
