import 'package:json_annotation/json_annotation.dart';

part 'productinfo_json.g.dart';

@JsonSerializable()
class Productinfo_json {
    Productinfo_json();

    num code;
    Map<String,dynamic> data;
    String msg;
    num status;
    
    factory Productinfo_json.fromJson(Map<String,dynamic> json) => _$Productinfo_jsonFromJson(json);
    Map<String, dynamic> toJson() => _$Productinfo_jsonToJson(this);
}
