import 'package:flutter/material.dart';
import 'package:ym_flutter_widget/widgets/Dialog/ym_dialog_box.dart';
import 'package:ym_flutter_widget/widgets/Dialog/ym_dialog_router.dart';
import 'package:ym_flutter_widget/widgets/Dialog/ym_loading_dialog.dart';
import 'package:ym_flutter_widget/widgets/Toast/ym_toast.dart';

/// UI工具类
class YmUiUtil {
  static bool _isLoading = false;

  ///toast提示
  static showToast(BuildContext context, String message) {
    YmToast.show(message, context, duration: YmToast.lengthShort, gravity: YmToast.center);
  }

  ///显示loading
  static showLoading(BuildContext context) {
    Future.delayed(Duration.zero, () {
      if (!_isLoading) {
        print("showLoading showLoading showLoading");
        Navigator.push(context, YmDialogRouter(YmLoadingDialog(false)));
        _isLoading = true;
      }
    });
  }

  ///隐藏loading
  static hideLoading(BuildContext context) {
    if (_isLoading) {
      Navigator.pop(context);
      _isLoading = false;
      print("hideLoading hideLoading hideLoading");
    }
  }

  ///显示弹出框
  static showAlertDialog(BuildContext context, String? title, String message, String okText, String cancelText,
      {onOkPressed, onCancelPressed, okCloseDialog = true}) {
    showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: EdgeInsets.only(top:16,left: 16, right: 16,bottom: 2),
          title: title!=null ?Container(
            height: 40,
            child: Text(title,
              textAlign: TextAlign.center,
              style: TextStyle(
              color: Color(0xff333333),
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),),
          ):null,
          contentPadding:const EdgeInsets.fromLTRB(16, 0, 16, 0),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message, style: TextStyle(
                  color: Color(0xff555555),
                  fontSize: 14,
                )),
              ],
            ),
          ),
          buttonPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          actionsPadding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
          actions: <Widget>[
            TextButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(50, 26)),
                padding: MaterialStateProperty.all(EdgeInsets.zero),
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
              ),
              child: Text(cancelText, style: TextStyle(
                color: Color(0xff555555),
                fontSize: 14,
              )),
              onPressed: () {
                if (null != onCancelPressed) {
                  onCancelPressed();
                }
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(50, 26)),
                padding: MaterialStateProperty.all(EdgeInsets.zero),
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
              ),
              child: Text(okText, style: TextStyle(
                color: Color(0xff3446F2),
                fontSize: 14,
              )),
              onPressed: () {
                if (null != onOkPressed) {
                  onOkPressed();
                }
                if (null != okCloseDialog && okCloseDialog) {
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    ).then((val) {
      print(val);
    });
  }

  ///显示确认弹出框
  static showConfirmDialog(BuildContext context, String message, String okText, {onOkPressed}) {
    showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(okText),
              onPressed: () {
                Navigator.of(context).pop();
                if (null != onOkPressed) {
                  onOkPressed();
                }

              },
            ),
          ],
        );
      },
    ).then((val) {
      print(val);
    });
  }

  ///显示底部弹出框
  static showBottomDialog(BuildContext context, Widget child) {
    FocusScope.of(context).unfocus();
    showDialog<Null>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return YmDialogBox(
          child: child,
          onClick: () {},
        );
      },
    ).then((val) {
      print(val);
    });
  }
}
