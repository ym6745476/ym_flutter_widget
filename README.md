# ym-flutter-widget
A Light Weight Flutter Widget
Including Http,JsonToBean,AppBar,Dialog,Toast,Loading,Button,SearchBar,Html,Image,Video and so on)

## Get started

### Add dependency

```yaml
dependencies:
  ym_flutter_widget: ^0.0.1
```

### Super simple to use http

```dart
///登录接口示例
Future<void> _login() async {
    String url = LOGIN_URL;

    //显示进度框
    YmUiUtil.showLoading(context);

    //post默认为用Json方式提交,postForm用表单方式提交
    YmHttp.getInstance().postForm(url, {"user_name":_account,"password":_password},(data) {

          //关闭进度框
          YmUiUtil.hideLoading(context);

          //Json转换实体类
          UserEntity _userEntity = UserEntity();
          _userEntity.fromJson(data);

          if(_userEntity.code == 1){
            YmUiUtil.showToast(context,"登录成功！");
          }else{
            YmUiUtil.showToast(context,"登录失败！");
          }
        },(error) {
          print("失败：" + error);
          YmUiUtil.hideLoading(context);
          YmUiUtil.showToast(context,error);
        }
    );
}
```

## Super simple to use widget

🎉 A widget list.

### Widget List

- export 'http/ym_http.dart';
- export 'widgets/AppBar/ym_app_bar.dart';
- export 'widgets/Button/ym_text_button.dart';
- export 'widgets/Button/ym_tab_button.dart';
- export 'widgets/Button/ym_image_button.dart';
- export 'widgets/Button/ym_check_button.dart';
- export 'widgets/Dialog/ym_dialog_router.dart';
- export 'widgets/Dialog/ym_loading_dialog.dart';
- export 'widgets/Empty/ym_empty_widget.dart';
- export 'widgets/Html/ym_html_widget.dart';
- export 'widgets/Image/ym_image_viewer.dart';
- export 'widgets/Video/ym_video_viewer.dart';
- export 'widgets/Loading/ym_loading.dart';
- export 'widgets/SearchBar/ym_search_bar.dart';
- export 'widgets/TextField/ym_text_field.dart';
- export 'widgets/Toast/ym_toast.dart';
- export 'utils/ym_string_util.dart';
- export 'utils/ym_ui_util.dart';
