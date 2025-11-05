import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_models.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class User extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String username;
  @HiveField(2)
  final String language;
  @HiveField(3)
  final String role;

  User({required this.id, required this.username, required this.language, required this.role});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@HiveType(typeId: 1)
@JsonSerializable()
class Device extends HiveObject {
  @HiveField(0)
  final String deviceId;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String status;

  Device({required this.deviceId, required this.name, required this.status});

  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceToJson(this);
}

@HiveType(typeId: 2)
@JsonSerializable()
class Session extends HiveObject {
  @HiveField(0)
  final String sessionId;
  @HiveField(1)
  final String deviceId;
  @HiveField(2)
  final DateTime startTime;
  @HiveField(3)
  final DateTime? endTime;
  @HiveField(4)
  final String cerealType;
  @HiveField(5)
  final double quantity;
  @HiveField(6)
  final String fineness;
  @HiveField(7)
  final String status;

  Session({
    required this.sessionId,
    required this.deviceId,
    required this.startTime,
    this.endTime,
    required this.cerealType,
    required this.quantity,
    required this.fineness,
    required this.status,
  });

  factory Session.fromJson(Map<String, dynamic> json) => _$SessionFromJson(json);
  Map<String, dynamic> toJson() => _$SessionToJson(this);
}
