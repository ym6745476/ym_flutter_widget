# Ym Flutter Widget
A Light Weight Flutter Widget
(Including Http,JsonToBean,AppBar,Dialog,Toast,Cascader,Loading,Button,SearchBar,Html,Image,Video and so on).


<p align="center" >
    <img src="https://img.shields.io/badge/flutter-2.2.0-green" />
    <img src="https://img.shields.io/badge/ym flutter widget-0.0.4-orange" />
    <img src="https://img.shields.io/badge/dio-4.9.0-blue" />
</p>
  
## Get started
Project Home Page:http://ymbok.com/index.php/index/info/id/105

### Add dependency

```yaml
dependencies:
  ym_flutter_widget: ^0.0.5
```

![输入图片说明](https://images.gitee.com/uploads/images/2021/0531/134456_7001ef4a_1461204.png "1.png")
![输入图片说明](https://images.gitee.com/uploads/images/2021/0531/134504_fadbefbe_1461204.png "2.png")
![输入图片说明](https://images.gitee.com/uploads/images/2021/0531/134512_73d65a48_1461204.png "3.png")
![输入图片说明](https://images.gitee.com/uploads/images/2021/0531/134518_6dba8ac6_1461204.png "4.png")
![输入图片说明](https://images.gitee.com/uploads/images/2021/0531/134524_c0ca803a_1461204.png "5.png")
![输入图片说明](https://images.gitee.com/uploads/images/2021/0531/134529_54bc1cfe_1461204.png "6.png")
![输入图片说明](https://images.gitee.com/uploads/images/2021/0531/134535_34c176dd_1461204.png "7.png")
![输入图片说明](https://images.gitee.com/uploads/images/2021/0531/134541_0d61364c_1461204.png "8.png")
![输入图片说明](https://images.gitee.com/uploads/images/2021/0531/134547_b8d649a3_1461204.png "9.png")
![输入图片说明](https://images.gitee.com/uploads/images/2021/0531/134553_205a73ca_1461204.png "10.png")
![输入图片说明](https://images.gitee.com/uploads/images/2021/0531/134559_cd16b650_1461204.png "11.png")
![输入图片说明](https://images.gitee.com/uploads/images/2021/0531/134604_24dcbced_1461204.png "12.png")
![输入图片说明](https://images.gitee.com/uploads/images/2021/0531/134610_92c26753_1461204.png "13.png")
![输入图片说明](https://images.gitee.com/uploads/images/2021/0531/134617_ac03a280_1461204.png "14.png")
![输入图片说明](https://images.gitee.com/uploads/images/2021/0531/134622_49a1cfe2_1461204.png "15.png")
![输入图片说明](https://images.gitee.com/uploads/images/2021/0531/134628_1e792f0e_1461204.png "16.png")
![输入图片说明](https://images.gitee.com/uploads/images/2021/0611/175410_fe536034_1461204.png "17.png")
![输入图片说明](https://images.gitee.com/uploads/images/2021/0611/175419_222979d4_1461204.png "18.png")

### Super simple to use http

```dart
///登录接口示例
Future<void> _login() async {
    String url = await Config.getURL(Config.LOGIN_USER_URL);

    //显示进度框
    YmUiUtil.showLoading(context);

    //postForm表单提交 post默认为Json方式提交
    YmHttp.getInstance().postForm(
        url
        ,{"user_name":_account,"password":_password}
        ,success: (data) {

            //Json转换实体类
            UserEntity _userEntity = UserEntity();
            _userEntity.fromJson(data);

            if(_userEntity.code == 1){
              YmUiUtil.showToast(context,"登录成功！");
              setState(() {
                _result = "userId:" + _userEntity.data.userId.toString() + ",token:" + _userEntity.data.token;
              });
              Config.token = _userEntity.data.token;
              Config.userId = _userEntity.data.userId.toString();
            }else{
              setState(() {
                _result = "error:" + _userEntity.msg;
              });
            }
        }
        ,error: (error) {
          print("失败：" + error.toString());
          YmUiUtil.showToast(context,error['errorMessage']);
        }
        ,complete: (){
          //关闭进度框
          YmUiUtil.hideLoading(context);
        }
    );
}
```

## Super simple to use widget

```dart

//显示进度框
YmUiUtil.showLoading(context);

//关闭进度框
YmUiUtil.hideLoading(context);

//显示Toast
YmUiUtil.showToast(context,"a message!");

//显示弹出框
YmUiUtil.showAlertDialog(context, "确认提示", "您确定要打开弹窗吗?", "确定", "取消",onOkPressed: (){
    print("Ok Pressed");
});

//文字按钮
YmTextButton("Stadium", Color(0xFFFFFFFF), (){
    print("Button Pressed");
},outlinedBorder: StadiumBorder(),),

//文本框
YmTextField([],"默认值",_onTextChange,
      fontSize: 15,
      height: 35,
      hintText:"基本输入框" ,
      outlineInputBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(color: Color(0x00606FFF))
      ),
      focusedBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(color: Color(0x003446F2))
      ),
),

//Tab + ListView
YmTabPageView(_tabs,_items,
    onItemBuilder: (index){
      return _getListItemWidget(index);
    },
    onChanged:(index){
     
    },
),

```

🎉 A widget list.

### Widget List

- export 'http/ym_http.dart';                           //网络请求框架
- export 'widgets/AppBar/ym_app_bar.dart';              //自定义导航栏
- export 'widgets/Button/ym_text_button.dart';          //文字按钮（形状样式）
- export 'widgets/Button/ym_tab_button.dart';           //Tab按钮
- export 'widgets/Button/ym_image_button.dart';         //图片按钮
- export 'widgets/Button/ym_check_button.dart';         //选择状态按钮
- export 'widgets/SearchBar/ym_search_bar.dart';        //搜索框
- export 'widgets/TextField/ym_text_field.dart';        //文本框
- export 'widgets/Loading/ym_loading.dart';             //Loading页面样式
- export 'widgets/Toast/ym_toast.dart';                 //小提示Toast
- export 'widgets/Cascader/ym_cascader.dart';           //级联选择器
- export 'widgets/TextField/ym_text_marquee.dart';      //循环滚动文本
- export 'widgets/Html/ym_html.dart';                   //Html代码解析
- export 'widgets/Empty/ym_empty.dart';                 //空页面样式
- export 'widgets/Error/ym_error.dart';                 //错误页面样式
- export 'widgets/Dialog/ym_loading_dialog.dart';       //加载弹出框
- export 'widgets/Dialog/ym_dialog_box.dart';           //弹出层样式包裹
- export 'widgets/Image/ym_image_viewer.dart';          //图片弹出预览
- export 'widgets/Video/ym_video_viewer.dart';          //视频弹出预览
- export 'widgets/TabPageView/ym_tab_page_view.dart';   //Tab+ListView
- export 'widgets/TabPageView/ym_list_view.dart';       //ListView+分页+加载更多
- export 'utils/ym_string_util.dart';                   //字符串工具类
- export 'utils/ym_ui_util.dart';                       //UI工具类

