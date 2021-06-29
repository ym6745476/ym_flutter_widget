import 'package:example/base/single_native_state_mixin.dart';
import 'package:flutter/material.dart';
import 'package:example/base/config.dart';
import 'package:ym_flutter_widget/widgets/AppBar/ym_app_bar.dart';
import 'package:ym_flutter_widget/widgets/Button/ym_check_button.dart';
import 'package:ym_flutter_widget/widgets/Button/ym_gradient_button.dart';
import 'package:ym_flutter_widget/widgets/Button/ym_image_button.dart';
import 'package:ym_flutter_widget/widgets/Button/ym_radio_button.dart';
import 'package:ym_flutter_widget/widgets/Button/ym_tab_button.dart';
import 'package:ym_flutter_widget/widgets/Button/ym_text_button.dart';

///单选按钮和多选按钮
class CheckButtonPage extends StatefulWidget {

  CheckButtonPage({Key? key}) : super(key: key);

  final String title = "Check Button";

  @override
  _CheckButtonPageState createState() => _CheckButtonPageState();
}

class _CheckButtonPageState extends State<CheckButtonPage> with SingleNativeStateMixin {

  List<bool> _isChecked = [false,false,false];
  int _radioGroupValue1 = 0;
  int _radioGroupValue2 = 0;

  @override
  void initState() {
    super.initState();

    //获取name路由过来的参数
    Future.delayed(Duration.zero, () {
      dynamic  arguments = ModalRoute.of(context)!.settings.arguments;
      print("路由传递过来的参数：" + arguments.toString());
      if (arguments != null) {
        isRouteFlutter = arguments["flutter"];
        if(!Config.isNative || isRouteFlutter){
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

                      Row(
                        children: [
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
                        ],
                      ),

                      Row(
                        children: [
                          YmCheckButton(value:0,checked:_isChecked[0],onChanged: (bool checked,dynamic value){ _checkedMultipleButton(0,checked,value);},text: "多选1",),
                          YmCheckButton(value:1,checked:_isChecked[1],onChanged:(bool checked,dynamic value){ _checkedMultipleButton(1,checked,value);},text: "多选2",),
                          YmCheckButton(value:2,checked:_isChecked[2],onChanged:(bool checked,dynamic value){ _checkedMultipleButton(2,checked,value);},text: "多选3",),
                        ],
                      ),

                      Row(
                        children: [
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
                        ],
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