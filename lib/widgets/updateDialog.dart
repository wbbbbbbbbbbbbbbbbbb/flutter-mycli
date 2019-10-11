// +----------------------------------------------------------------------
// | 更新弹窗
// +----------------------------------------------------------------------

// 用法
// showDialog<Null>(
//   context: context, //BuildContext对象
//   barrierDismissible: false,
//   builder: (BuildContext context) {
//     return UpdateDialog(
//       link: 'https://www.baidu.com',
//       tips: '更新一堆乱七八糟的东西',
//       isNotForce: true, // 不是强更
//     );
//   },
// );

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../common/global/global.dart';

class UpdateDialog extends Dialog {
  UpdateDialog({
    Key key,
    this.link,
    this.tips,
    this.isNotForce,
  }) : super(key: key);

  final String link;
  final String tips;
  final bool isNotForce;

  // 点返回键或阴影部分会做些什么...
  _onNavigationClickEvent(context) {
    if (isNotForce) {
      Navigator.of(context).pop();
    }
  }

  // 跳转连接
  launchUrl() async {
    if (await canLaunch(link)) {
      await launch(link);
    }
  }

  // 提示框中间的提示文字样式
  TextStyle _style1() {
    return TextStyle(
      color: col("303133"),
      fontSize: sp(34),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(isNotForce),
      child: Material(
        //创建透明层
        type: MaterialType.transparency, //透明类型
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            GestureDetector(onTap: () => _onNavigationClickEvent(context)),
            Center(
              //保证控件居中效果
              child: SizedBox(
                width: px(690),
                height: px(690),
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage("assets/images/ver.png"),
                    fit: BoxFit.contain,
                  )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: sp(78)),
                        child: Text(
                          '发现新版本',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: sp(56),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: px(155),
                        ),
                        child: Text(
                          '版本更新啦',
                          style: _style1(),
                        ),
                      ),
                      Container(
                        height: px(180),
                        margin: EdgeInsets.only(
                          top: px(20),
                          left: px(50),
                          right: px(50),
                        ),
                        child: Text(
                          txt(tips),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                          style: _style1(),
                        ),
                      ),
                      SizedBox(
                        width: px(479),
                        height: px(84),
                        child: RaisedButton(
                          onPressed: launchUrl,
                          color: col("47d6b6"),
                          disabledColor: Color.fromRGBO(237, 239, 242, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              sp(42),
                            ),
                          ),
                          child: Text(
                            '立即更新',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: sp(32),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
