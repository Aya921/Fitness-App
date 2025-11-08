import 'package:json_annotation/json_annotation.dart';

part 'edit_profile_request.g.dart';

@JsonSerializable()
class EditProfileRequest {
  @JsonKey(name: "firstName")
  final String? firstName;

  @JsonKey(name:"lastName")
  final String? lastName;

  @JsonKey(name: "email")
  final String? email;

  @JsonKey(name: "weight")
  final num? weight;

  @JsonKey(name: "height")
  final num? height;

  @JsonKey(name: "activityLevel")
  final String? activityLevel;

  @JsonKey(name:"goal")
  final String? goal;


  EditProfileRequest({
    this.firstName,
    this.lastName,
    this.email,
   this.weight,
    this.height,
    this.activityLevel,
    this.goal,

  });

  factory EditProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$EditProfileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$EditProfileRequestToJson(this);
}