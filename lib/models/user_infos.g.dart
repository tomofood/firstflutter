// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_infos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfosModel _$UserInfosModelFromJson(Map<String, dynamic> json) =>
    UserInfosModel(
      id: json['id'] as String,
      avatar: json['avatar'] as String,
      nickname: json['nickname'] as String,
      token: json['token'] as String?,
      mobile: json['mobile'] as String?,
      account: json['account'] as String,
    );

Map<String, dynamic> _$UserInfosModelToJson(UserInfosModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'avatar': instance.avatar,
      'account': instance.account,
      'mobile': instance.mobile,
      'token': instance.token,
      'nickname': instance.nickname,
    };
