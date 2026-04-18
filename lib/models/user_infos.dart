import 'package:json_annotation/json_annotation.dart';
part 'user_infos.g.dart';

@JsonSerializable()
class UserInfosModel {
  String id;
  String avatar;
  String account;
  String? mobile;
  String? token;
  String nickname;
  UserInfosModel({
    required this.id,
    required this.avatar,
    required this.nickname,
    this.token,
    this.mobile,
    required this.account,
  });
  factory UserInfosModel.fromJson(Map<String, dynamic> json) =>
      _$UserInfosModelFromJson(json);
}
