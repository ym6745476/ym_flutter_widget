import 'package:example/base/single_native_state_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:example/base/config.dart';
import 'package:example/data/user_entity.dart';
import 'package:ym_flutter_widget/http/ym_http.dart';
import 'package:ym_flutter_widget/utils/ym_ui_util.dart';
import 'package:ym_flutter_widget/widgets/TextField/ym_text_field.dart';

///http接口调用示例
class HttpPage extends StatefulWidget {

  HttpPage({Key? key}) : super(key: key);

  final String title = "Http请求";

  @override
  _HttpPageState createState() => _HttpPageState();
}

class _HttpPageState extends State<HttpPage> with SingleNativeStateMixin{

  String _account = "ym6745476";
  String _password = "ym6745476";
  String _result = "";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Future<void> loadData() async{
    YmHttp.getInstance().setHeader({'sign':"123456"});
  }

  void onTextChangeAccount(text){
    _account = text;
  }

  void onTextChangePassword(text){
    _password = text;
  }

  ///登录接口示例
  Future<void> _login() async {
    String url = await Config.getURL(Config.LOGIN_PASSWORD_URL);

    //显示进度框
    YmUiUtil.showLoading(context);

    //postForm表单提交 post默认为Json方式提交
    YmHttp.getInstance().postForm(
        url
        ,{"user_name":_account,"password":_password}
        ,success: (data) {

            //Json转换实体类
            UserEntity userEntity = UserEntity();
            userEntity.fromJson(data);

            if(userEntity.code == 1){
              YmUiUtil.showToast(context,"登录成功！");
              setState(() {
                _result = "userId:" + userEntity.data.userId.toString() + ",token:" + userEntity.data.token;
              });
              Config.token = userEntity.data.token;
              Config.userId = userEntity.data.userId.toString();
            }else{
              YmUiUtil.showToast(context,userEntity.msg);
              setState(() {
                _result = "error:" + userEntity.msg;
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

  @override
  Widget build(BuildContext context) {

    BoxDecoration boxDecoration = BoxDecoration( color: Color(0xffffffff),
      border: Border(
          top: BorderSide(color: Colors.white, width: 0.3),      // 上边边框
          right: BorderSide(color: Colors.white, width: 0.3),    // 右侧边框
          bottom: BorderSide(color: Colors.white, width: 0.3),   // 底部边框
          left: BorderSide(color: Colors.white, width: 0.3)),

      borderRadius: BorderRadius.horizontal(left:Radius.circular(5),right: Radius.circular(5)),// 左侧边框
    );
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

            //登录
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(16),
              decoration: boxDecoration,
              child: Column(
                children: [
                  YmTextField([FilteringTextInputFormatter.allow(RegExp("[0-9]")),NumberTextInputFormatter()],_account,onTextChangeAccount,
                      fontSize: 14,
                      outlineInputBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Color(0xff606FFF))
                      ),
                      focusedBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Color(0xff3446F2))
                      ),
                  ),
                  Divider(height: 5,color:Color(0x003446F2)),
                  YmTextField([FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]"))],_password,onTextChangePassword,
                      fontSize: 14,
                      outlineInputBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Color(0xff606FFF))
                      ),
                      focusedBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Color(0xff3446F2))
                      ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top:20,left: 0,right: 0,bottom: 10),
                    child:  ElevatedButton(
                      child: Text('登录'),
                      onPressed: _login,
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width - 60, 50)),
                        padding:MaterialStateProperty.all(EdgeInsets.only(top:0,left: 0,right: 0,bottom: 0)),
                      ),
                    ),
                  ),

                  //登录接口结果
                  Padding(
                    padding: EdgeInsets.only(top:5,left: 0,right: 0,bottom: 0),
                    child:  Text(_result),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}