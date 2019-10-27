// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productlist_json.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Productlist_json _$Productlist_jsonFromJson(Map<String, dynamic> json) {
  return Productlist_json()
    ..code = json['code'] as num
    ..data = json['data'] as List
    ..msg = json['msg'] as String
    ..status = json['status'] as num;
}

Map<String, dynamic> _$Productlist_jsonToJson(Productlist_json instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'msg': instance.msg,
      'status': instance.status
    };
