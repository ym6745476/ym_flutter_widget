# Ym Flutter Widget
A Light Weight Flutter Widget
(Including Http,AppBar,Dialog,Toast,Cascader,Loading,Button,SearchBar,Html,Image,Video and so on).


<p align="center" >
    <img src="https://img.shields.io/badge/flutter-2.2.3-green" />
    <img src="https://img.shields.io/badge/ym flutter widget-0.0.9-orange" />
    <img src="https://img.shields.io/badge/dio-4.9.0-blue" />
</p>
  
## Get started

https://ymbok.com/book-112-159.html

### Online Demo

https://ymbok.com/phone-112.html

### Add dependency

```yaml
dependencies:
  ym_flutter_widget: ^0.0.9
```

### Screenshot

![图片说明](https://raw.githubusercontent.com/ym6745476/ym_flutter_widget/master/screenshot/1.png "1.png")
![图片说明](https://raw.githubusercontent.com/ym6745476/ym_flutter_widget/master/screenshot/2.png "2.png")
![图片说明](https://raw.githubusercontent.com/ym6745476/ym_flutter_widget/master/screenshot/3.png "3.png")
![图片说明](https://raw.githubusercontent.com/ym6745476/ym_flutter_widget/master/screenshot/4.png "4.png")
![图片说明](https://raw.githubusercontent.com/ym6745476/ym_flutter_widget/master/screenshot/5.png "5.png")
![图片说明](https://raw.githubusercontent.com/ym6745476/ym_flutter_widget/master/screenshot/6.png "6.png")
![图片说明](https://raw.githubusercontent.com/ym6745476/ym_flutter_widget/master/screenshot/7.png "7.png")
![图片说明](https://raw.githubusercontent.com/ym6745476/ym_flutter_widget/master/screenshot/8.png "8.png")
![图片说明](https://raw.githubusercontent.com/ym6745476/ym_flutter_widget/master/screenshot/9.png "9.png")
![图片说明](https://raw.githubusercontent.com/ym6745476/ym_flutter_widget/master/screenshot/10.png "10.png")
![图片说明](https://raw.githubusercontent.com/ym6745476/ym_flutter_widget/master/screenshot/11.png "11.png")
![图片说明](https://raw.githubusercontent.com/ym6745476/ym_flutter_widget/master/screenshot/12.png "12.png")
![图片说明](https://raw.githubusercontent.com/ym6745476/ym_flutter_widget/master/screenshot/13.png "13.png")
![图片说明](https://raw.githubusercontent.com/ym6745476/ym_flutter_widget/master/screenshot/14.png "14.png")
![图片说明](https://raw.githubusercontent.com/ym6745476/ym_flutter_widget/master/screenshot/15.png "15.png")
![图片说明](https://raw.githubusercontent.com/ym6745476/ym_flutter_widget/master/screenshot/16.png "16.png")
![图片说明](https://raw.githubusercontent.com/ym6745476/ym_flutter_widget/master/screenshot/17.png "17.png")
![图片说明](https://raw.githubusercontent.com/ym6745476/ym_flutter_widget/master/screenshot/18.png "18.png")
![图片说明](https://raw.githubusercontent.com/ym6745476/ym_flutter_widget/master/screenshot/19.png "19.png")

### Super simple to use http

```dart

///登录接口示例
Future<void> _login() async {

    String url = await Config.LOGIN_USER_URL;

    //显示进度框
    YmUiUtil.showLoading(context);

    //postForm表单提交 post默认为Json方式提交
    YmHttp().postForm(
        url
        ,{"user_name":_account,"password":_password}
        ,success: (data) {

            //Json转换实体类
            UserEntity userEntity = UserEntity();
            userEntity.fromJson(data);

            if(userEntity.code == 1){
              YmUiUtil.showToast(context,"登录成功！");
              Config.token = userEntity.data.token;
              Config.userId = userEntity.data.userId.toString();
            }else{
              YmUiUtil.showToast(context,userEntity.msg);
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

//导航栏
YmAppBar("标题",
  background:[
    const Color(0xFF606FFF),
    const Color(0xFF3446F2),
  ],onBackClick: goBack,textColor: Colors.white,
  textAlign: TextAlign.left,
  rightWidget: YmTextButton(
      "右边按钮",
      textColor:Color(0xFFFFFFFF),
      backgroundColor: Colors.transparent,
      pressedBackgroundColor: Color(0x50606FFF),
      size: Size(90,40),
      onClick:  (){
        print("right button click");
      }
  ),
),

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
},outlinedBorder: StadiumBorder()),

//带图标和文字的按钮
YmImageButton("ImageButton", Color(0xFFFFFFFF), (){
   print("Button Pressed");
},size:Size(180,42),iconLeft:"assets/images/ic_share_down.png",outlinedBorder:StadiumBorder()),

//文本框
YmTextField([],"默认值",
  _onTextChange,
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

//级联选择器
YmCascader(
  _data,
  currentIndex: [1],
  onOkClick:(){
  },
  onCancelClick:(){
  },
  onChanged: (position,index,value){
    _pickerSelected[position] = index;
  },
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

### 🎉  Widget List

- export 'http/ym_http.dart';                           //网络请求框架
- export 'widgets/AppBar/ym_app_bar.dart';              //自定义导航栏
- export 'widgets/Button/ym_text_button.dart';          //文字按钮（形状样式）
- export 'widgets/Button/ym_tab_button.dart';           //Tab按钮
- export 'widgets/Button/ym_image_button.dart';         //图片按钮
- export 'widgets/Button/ym_check_button.dart';         //选择状态按钮
- export 'widgets/SearchBar/ym_search_bar.dart';        //搜索框
- export 'widgets/TextField/ym_text_field.dart';        //文本框
- export 'widgets/Toast/ym_toast.dart';                 //小提示Toast
- export 'widgets/Dialog/ym_loading_dialog.dart';       //加载弹出框
- export 'widgets/Dialog/ym_dialog_box.dart';           //弹出层样式包裹
- export 'widgets/Picker/ym_cascader.dart';             //级联选择器
- export 'widgets/Picker/ym_picker.dart';               //滚动选择器
- export 'widgets/TextField/ym_text_marquee.dart';      //循环滚动文本
- export 'widgets/Html/ym_html.dart';                   //Html代码解析
- export 'widgets/Loading/ym_loading.dart';             //Loading页面样式
- export 'widgets/Empty/ym_empty.dart';                 //空页面样式
- export 'widgets/Error/ym_error.dart';                 //错误页面样式
- export 'widgets/Image/ym_image_viewer.dart';          //图片弹出预览
- export 'widgets/Video/ym_video_viewer.dart';          //视频弹出预览
- export 'widgets/TabPageView/ym_tab_page_view.dart';   //Tab+ListView
- export 'widgets/ListView/ym_list_view.dart';          //ListView+分页+加载更多
- export 'utils/ym_string_util.dart';                   //字符串工具类
- export 'utils/ym_ui_util.dart';                       //UI工具类

# 推荐Flutter游戏开发引擎框架（超轻游戏开发引擎）
https://github.com/ym6745476/devilf  
<img src="https://raw.githubusercontent.com/ym6745476/devilf/master/screenshot/demo.gif" width="600" height="292"/>