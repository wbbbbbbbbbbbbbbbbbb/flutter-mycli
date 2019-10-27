// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productinfo_json.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Productinfo_json _$Productinfo_jsonFromJson(Map<String, dynamic> json) {
  return Productinfo_json()
    ..code = json['code'] as num
    ..data = json['data'] as Map<String, dynamic>
    ..msg = json['msg'] as String
    ..status = json['status'] as num;
}

Map<String, dynamic> _$Productinfo_jsonToJson(Productinfo_json instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'msg': instance.msg,
      'status': instance.status
    };
