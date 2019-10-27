import '../../common/global/global.dart';
import '../../models/index.dart';
import '../../http2/index.dart';

class ProductApis {
  /// 商品列表 get
  /// url productList
  static productList() async {
    ResultModel result = await Io.get("productList");
    return Productlist_json.fromJson(result.data);
  }

  /// 商品详情 get
  /// url productInfo
  /// param 
  ///   id 商品id
  static productInfo(data) async {
    ResultModel result = await Io.get("productInfo", data: data);
    return Productinfo_json.fromJson(result.data);
  }
}