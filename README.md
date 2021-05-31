# Ym Flutter Widget
A Light Weight Flutter Widget
(Including Http,JsonToBean,AppBar,Dialog,Toast,Cascader,Loading,Button,SearchBar,Html,Image,Video and so on).

## Get started

### Add dependency

```yaml
dependencies:
  ym_flutter_widget: ^0.0.2
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
          print("失败：" + error.toString());
          YmUiUtil.hideLoading(context);
          YmUiUtil.showToast(context,error['errorMessage']);
        }
    );
}
```

## Super simple to use widget

🎉 A widget list.

### Widget List

- export 'http/ym_http.dart';//网络请求框架
- export 'widgets/AppBar/ym_app_bar.dart';//自定义导航栏
- export 'widgets/Button/ym_text_button.dart';//文字按钮（形状样式）
- export 'widgets/Button/ym_tab_button.dart';//Tab按钮
- export 'widgets/Button/ym_image_button.dart';//图片按钮
- export 'widgets/Button/ym_check_button.dart';//选择状态按钮
- export 'widgets/Dialog/ym_loading_dialog.dart';//加载弹出框
- export 'widgets/Cascader/ym_cascader.dart';//级联选择器
- export 'widgets/Empty/ym_empty.dart';//空页面样式
- export 'widgets/Html/ym_html.dart';//Html代码解析
- export 'widgets/Error/ym_error.dart';//错误页面样式
- export 'widgets/Loading/ym_loading.dart';//Loading页面样式
- export 'widgets/Image/ym_image_viewer.dart';//图片弹出预览
- export 'widgets/Video/ym_video_viewer.dart';//视频弹出预览
- export 'widgets/SearchBar/ym_search_bar.dart';//搜索框
- export 'widgets/TextField/ym_text_field.dart';//文本框
- export 'widgets/TextField/ym_text_marquee.dart';//循环滚动文本
- export 'widgets/Toast/ym_toast.dart';//小提示Toast
- export 'utils/ym_string_util.dart';//字符串工具类
- export 'utils/ym_ui_util.dart';//UI工具类

