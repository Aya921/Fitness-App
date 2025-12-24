import 'package:fitness/core/constants/json_serializable_constants.dart';
import 'package:fitness/features/auth/api/models/auth_response/user_response.dart';
import 'package:fitness/features/auth/domain/entity/auth/auth_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_response.g.dart';

@JsonSerializable(explicitToJson: true)
class AuthResponse {
  @JsonKey(name: JsonSerializableConstants.message)
  final String? message;

  @JsonKey(name: JsonSerializableConstants.user)
  final UserResponse? user;

  @JsonKey(name: JsonSerializableConstants.token)
  final String? token;

  @JsonKey(name: JsonSerializableConstants.error)
  final String? error;

  AuthResponse({this.message, this.user, this.token, this.error});

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);

  AuthEntity toEntity() {
    return AuthEntity(
      message: message,
      token: token,
      user: user?.toEntity()
    );
  }
}