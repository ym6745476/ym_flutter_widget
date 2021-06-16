import 'package:example/base/single_native_state_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:example/base/config.dart';
import 'package:ym_flutter_widget/widgets/AppBar/ym_app_bar.dart';
import 'package:ym_flutter_widget/widgets/Button/ym_check_button.dart';
import 'package:ym_flutter_widget/widgets/Button/ym_gradient_button.dart';
import 'package:ym_flutter_widget/widgets/Button/ym_image_button.dart';
import 'package:ym_flutter_widget/widgets/Button/ym_tab_button.dart';
import 'package:ym_flutter_widget/widgets/Button/ym_text_button.dart';

class ButtonPage extends StatefulWidget {

  ButtonPage({Key? key}) : super(key: key);

  final String title = "Button";

  @override
  _ButtonPageState createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> with SingleNativeStateMixin {

  List<bool> _isChecked = [true,false];
  List<String> _tabButtonList = ["全部","待付款","待发货"];
  int _tabButtonSelectedIndex = 0;

  @override
  void initState() {
    super.initState();

    //获取name路由过来的参数
    Future.delayed(Duration.zero, () {
      dynamic  arguments = ModalRoute.of(context)!.settings.arguments;
      print("路由传递过来的参数：" + arguments.toString());
      if (arguments != null) {
        isRouteFromFlutter = arguments["flutter"];
        if(Config.isWeb || isRouteFromFlutter){
          //加载数据
        }
      }
    });

  }

  void _checkedButton(int index){

    setState(() {
       for(int i = 0;i<_isChecked.length;i++){
          if(i==index){
            _isChecked[i] = true;
          }else{
            _isChecked[i] = false;
          }
       }
    });
  }

  Widget _getTabWidget(int index){

    if(index == 0){
      return  Container(
        child: YmTabButton(_tabButtonList.elementAt(index), Color(0xffffffff),14, this._tabButtonSelectedIndex == index,()=>{
              tabButtonChange(index)
            },size:Size(90,40),borderRadius: BorderRadius.horizontal(left:Radius.circular(20),right:Radius.circular(2)),
        ),
      );
    }else if(index == 1){
      return  Container(
        child: YmTabButton(_tabButtonList.elementAt(index), Color(0xffffffff),14, this._tabButtonSelectedIndex == index,()=>{
              tabButtonChange(index)
            },size:Size(90,40),borderRadius: BorderRadius.horizontal(left:Radius.circular(2),right:Radius.circular(2)),
        ),
      );
    }else{
      return  Container(
        child: YmTabButton(_tabButtonList.elementAt(index), Color(0xffffffff),14, this._tabButtonSelectedIndex == index,()=>{
              tabButtonChange(index)
            },size:Size(90,40),borderRadius: BorderRadius.horizontal(left:Radius.circular(2),right:Radius.circular(20)),
        ),
      );
    }
  }

  void tabButtonChange(int index){
    setState(() {
      _tabButtonSelectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[

            ///导航栏
            Positioned(
              top: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: YmAppBar(widget.title,[
                  const Color(0xFF606FFF),
                  const Color(0xFF3446F2),
                ],goBack,titleTextColor: Colors.white,),
              ),
            ),

            Positioned(
              top: appBarHeight,
              left:0,
              width:  MediaQuery.of(context).size.width,
              child:Padding(
                padding: EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 16),
                child:Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: [

                      YmTextButton("Stadium", Color(0xFFFFFFFF), (){
                        print("Button Pressed");
                      }),

                      YmTextButton("Stadium", Color(0xFFFFFFFF), (){
                        print("Button Pressed");
                      },outlinedBorder: StadiumBorder(),),

                      YmTextButton("Circle", Color(0xFFFFFFFF), (){
                        print("Button Pressed");
                      },outlinedBorder:CircleBorder()),

                      YmTextButton("RoundedRectangle", Color(0xFFFFFFFF), (){
                        print("Button Pressed");
                      },outlinedBorder:RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),

                      YmTextButton("BeveledRectangle", Color(0xFFFFFFFF), (){
                        print("Button Pressed");
                      },outlinedBorder:BeveledRectangleBorder(borderRadius: BorderRadius.circular(10))),

                      YmTextButton("Outlined", Color(0xFF3446F2), (){
                        print("Button Pressed");
                      },isOutlined: true,borderColor:Color(0xFF3446F2),outlinedBorder:RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),

                      Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top:0,left: 10,right: 0,bottom: 0),
                              child:YmImageButton("按钮",(){},size:Size(100,42),textColor:Color(0xFF666666),backgroundColor:Color(0xFFFFFFFF),foregroundColor:Color(0xFFEFEFEF),iconLeft: "assets/images/ic_download.png"),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top:0,left: 10,right: 10,bottom: 0),
                              child:YmImageButton("按钮",(){},size:Size(100,42),textColor:Color(0xFF666666),backgroundColor:Color(0xFFFFFFFF),foregroundColor:Color(0xFFEFEFEF),iconLeft: "assets/images/ic_download.png"),
                            ),
                          ]
                      ),

                      YmImageButton("ImageButton", (){
                        print("Button Pressed");
                      },textColor:Color(0xFFFFFFFF),size:Size(160,42),backgroundColor:Color(0xFF3446F2),foregroundColor:Color(0xFF606FFF),iconLeft:"assets/images/ic_download.png"),

                      YmImageButton("ImageButton", (){
                        print("Button Pressed");
                      },textColor:Color(0xFFFFFFFF),size:Size(160,42),backgroundColor:Color(0xFF3446F2),foregroundColor:Color(0xFF606FFF),iconLeft:"assets/images/ic_download.png",outlinedBorder:StadiumBorder()),

                      YmImageButton("ImageButton", (){
                        print("Button Pressed");
                      },textColor:Color(0xFFFFFFFF),size:Size(160,42),backgroundColor:Color(0xFF3446F2),foregroundColor:Color(0xFF606FFF),iconRight:"assets/images/ic_download.png",outlinedBorder:RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),

                      YmImageButton("ImageButton", (){
                        print("Button Pressed");
                      },textColor:Color(0xFF3446F2),size:Size(160,42),isOutlined:true,iconRight:"assets/images/ic_download.png",outlinedBorder:RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),



                      YmGradientButton(
                        "渐变色",
                        Color(0xff3244ED),
                            (){
                          print("Button Pressed");
                        }
                        ,
                        size: Size(100, 32),
                        fontSize: 14,
                        borderColor:Color(0xFFEFAD40),
                        pressedBackgroundColor: Color(0xFFEFAD40),
                        fontWeight: FontWeight.w600,
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xFFFFE4B7),Color(0xFFEFAD40)]
                        ),
                      ),

                      YmCheckButton(_isChecked[0],(){ _checkedButton(0);},text: "不选中",),
                      YmCheckButton(_isChecked[1],(){_checkedButton(1);},text: "选中",),


                      //Tab Button
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height:40,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children:[
                                ListView.builder(
                                    padding: EdgeInsets.only(top:0,left: 0,right: 0,bottom: 0),
                                    primary: true,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    physics: new ClampingScrollPhysics(),
                                    itemCount: 3,
                                    itemBuilder: (context, index) => this._getTabWidget(index)
                                ),
                              ]
                          ),
                      ),

                    ]
                )
              ),
            ),

          ],
        ),
      ),
    );
  }


}