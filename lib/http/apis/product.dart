import '../../common/global/global.dart';

class ProductApis {
  /// 商品列表 get
  /// url productList
  static productList() async {
    return await Global.http.dioGet("productList");
  }

  /// 商品详情 get
  /// url productInfo
  /// param 
  ///   id 商品id
  static productInfo(data) async {
    return await Global.http.dioGet("productInfo", data: data);
  }
}