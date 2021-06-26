import 'package:example/base/single_native_state_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:example/base/config.dart';
import 'package:ym_flutter_widget/widgets/AppBar/ym_app_bar.dart';
import 'package:ym_flutter_widget/widgets/Button/ym_check_button.dart';
import 'package:ym_flutter_widget/widgets/Button/ym_gradient_button.dart';
import 'package:ym_flutter_widget/widgets/Button/ym_image_button.dart';
import 'package:ym_flutter_widget/widgets/Button/ym_radio_button.dart';
import 'package:ym_flutter_widget/widgets/Button/ym_tab_button.dart';
import 'package:ym_flutter_widget/widgets/Button/ym_text_button.dart';

class ButtonPage extends StatefulWidget {

  ButtonPage({Key? key}) : super(key: key);

  final String title = "Button";

  @override
  _ButtonPageState createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> with SingleNativeStateMixin {

  List<bool> _isChecked = [false,false,false];
  int _radioGroupValue1 = 0;
  int _radioGroupValue2 = 0;
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

  void _checkedMultipleButton(int index,bool checked,dynamic value){
    setState(() {
      _isChecked[index] = checked;
    });
  }

  void _checkedSingleButton(bool checked,dynamic value){
    if(checked){
      setState(() {
        _radioGroupValue1 = value;
      });
    }
  }

  Widget _getTabWidget(int index){

    if(index == 0){
      return  Container(
        child: YmTabButton(_tabButtonList.elementAt(index), textColor:Color(0xffffffff),fontSize:14, isSelected:this._tabButtonSelectedIndex == index,onClick: ()=>{
              tabButtonChange(index)
            },size:Size(90,40),borderRadius: BorderRadius.horizontal(left:Radius.circular(20),right:Radius.circular(2)),
        ),
      );
    }else if(index == 1){
      return  Container(
        padding: EdgeInsets.only(left:5,right: 5),
        child: YmTabButton(_tabButtonList.elementAt(index), textColor:Color(0xffffffff),fontSize:14, isSelected:this._tabButtonSelectedIndex == index,onClick:()=>{
              tabButtonChange(index)
            },size:Size(90,40),borderRadius: BorderRadius.horizontal(left:Radius.circular(2),right:Radius.circular(2)),
        ),
      );
    }else{
      return  Container(
        child: YmTabButton(_tabButtonList.elementAt(index), textColor:Color(0xffffffff),fontSize:14, isSelected:this._tabButtonSelectedIndex == index,onClick:()=>{
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
                child: YmAppBar(widget.title,
                  background:[
                    const Color(0xFF606FFF),
                    const Color(0xFF3446F2),
                  ],onBackClick: goBack,textColor: Colors.white,),
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

                      YmTextButton("RoundedRectangle", textColor:Color(0xFFFFFFFF),onClick:  (){
                        print("Button Pressed");
                      }),

                      YmTextButton("Stadium", textColor:Color(0xFFFFFFFF), onClick:(){
                        print("Button Pressed");
                      },outlinedBorder: StadiumBorder(),),

                      YmTextButton("Circle", textColor:Color(0xFFFFFFFF), onClick:(){
                        print("Button Pressed");
                      },outlinedBorder:CircleBorder()),

                      YmTextButton("RoundedRectangle", textColor:Color(0xFFFFFFFF),onClick: (){
                        print("Button Pressed");
                      },outlinedBorder:RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),

                      YmTextButton("BeveledRectangle", textColor:Color(0xFFFFFFFF), onClick:(){
                        print("Button Pressed");
                      },outlinedBorder:BeveledRectangleBorder(borderRadius: BorderRadius.circular(10))),

                      YmTextButton("Outlined", textColor:Color(0xFF3446F2),onClick: (){
                        print("Button Pressed");
                      },isOutlined: true,borderColor:Color(0xFF3446F2),outlinedBorder:RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),

                      Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top:0,left: 10,right: 0,bottom: 0),
                              child:YmImageButton("按钮",onClick: (){},size:Size(100,42),textColor:Color(0xFF666666),backgroundColor:Color(0xFFFFFFFF),pressedBackgroundColor:Color(0xFFEFEFEF),iconLeft: "assets/images/ic_download.png"),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top:0,left: 10,right: 10,bottom: 0),
                              child:YmImageButton("按钮",onClick:(){},size:Size(100,42),textColor:Color(0xFF666666),backgroundColor:Color(0xFFFFFFFF),pressedBackgroundColor:Color(0xFFEFEFEF),iconLeft: "assets/images/ic_download.png"),
                            ),
                          ]
                      ),

                      YmImageButton("ImageButton", onClick:(){
                        print("Button Pressed");
                      },textColor:Color(0xFFFFFFFF),size:Size(160,42),backgroundColor:Color(0xFF3446F2),pressedBackgroundColor:Color(0xFF606FFF),iconLeft:"assets/images/ic_download.png"),

                      YmImageButton("ImageButton", onClick:(){
                        print("Button Pressed");
                      },textColor:Color(0xFFFFFFFF),size:Size(160,42),backgroundColor:Color(0xFF3446F2),pressedBackgroundColor:Color(0xFF606FFF),iconLeft:"assets/images/ic_download.png",outlinedBorder:StadiumBorder()),

                      YmImageButton("ImageButton", onClick:(){
                        print("Button Pressed");
                      },textColor:Color(0xFFFFFFFF),size:Size(160,42),backgroundColor:Color(0xFF3446F2),pressedBackgroundColor:Color(0xFF606FFF),iconRight:"assets/images/ic_download.png",outlinedBorder:RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),

                      YmImageButton("ImageButton", onClick:(){
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


                      YmCheckButton(value:0,
                        checked:_radioGroupValue1==0,
                        onChanged: (bool checked,dynamic value){ _checkedSingleButton(checked,value);},
                        text: "单选1",
                        image: "assets/images/ic_radio.png",
                        checkedImage: "assets/images/ic_radio_checked.png",
                      ),

                      YmCheckButton(value:1,
                        checked:_radioGroupValue1==1,
                        onChanged:(bool checked,dynamic value){ _checkedSingleButton(checked,value);},
                        text: "单选2",
                        image: "assets/images/ic_radio.png",
                        checkedImage: "assets/images/ic_radio_checked.png",
                      ),

                      YmCheckButton(value:0,checked:_isChecked[0],onChanged: (bool checked,dynamic value){ _checkedMultipleButton(0,checked,value);},text: "多选1",),
                      YmCheckButton(value:1,checked:_isChecked[1],onChanged:(bool checked,dynamic value){ _checkedMultipleButton(1,checked,value);},text: "多选2",),
                      YmCheckButton(value:2,checked:_isChecked[2],onChanged:(bool checked,dynamic value){ _checkedMultipleButton(2,checked,value);},text: "多选3",),

                      YmRadioButton(
                        value:0,
                        groupValue:_radioGroupValue2,
                        onChanged: (value){
                          setState(() {
                            _radioGroupValue2 = value;
                          });
                        },
                        text: "心情好",
                      ),
                      YmRadioButton(
                        value:1,
                        groupValue:_radioGroupValue2,
                        onChanged: (value){
                          setState(() {
                            _radioGroupValue2 = value;
                          });
                        },
                        text: "心情不好",
                      ),


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