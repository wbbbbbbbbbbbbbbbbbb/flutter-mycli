import 'package:json_annotation/json_annotation.dart';

part 'productlist_json.g.dart';

@JsonSerializable()
class Productlist_json {
    Productlist_json();

    num code;
    List data;
    String msg;
    num status;
    
    factory Productlist_json.fromJson(Map<String,dynamic> json) => _$Productlist_jsonFromJson(json);
    Map<String, dynamic> toJson() => _$Productlist_jsonToJson(this);
}
