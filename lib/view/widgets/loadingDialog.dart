// +----------------------------------------------------------------------
// | 菊花wait
// +----------------------------------------------------------------------

// 用法
// showDialog<Null>(
//   context: context, //BuildContext对象
//   barrierDismissible: false,
//   builder: (BuildContext context) {
//     return LoadingDialog(
//       text: '正在转菊花...',
//     );
//   },
// );

import 'package:flutter/material.dart';
import '../../common/global/global.sugar.dart';

class LoadingDialog extends Dialog {
  LoadingDialog({Key key, @required this.text}) : super(key: key);

  final String text;

  close(context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        close(context);
        return Future.value(false);
      },
      child: Material(
        //创建透明层
        type: MaterialType.transparency, //透明类型
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            GestureDetector(onTap: () => close(context)),
            Center(
              //保证控件居中效果
              child: SizedBox(
                width: px(220),
                height: px(220),
                child: Container(
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20.0,
                        ),
                        child: Text(
                          text,
                          style: TextStyle(fontSize: 12.0),
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
