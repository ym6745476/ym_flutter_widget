import 'package:example/base/single_native_state_mixin.dart';
import 'package:flutter/material.dart';
import 'package:example/base/config.dart';
import 'package:ym_flutter_widget/utils/ym_date_util.dart';
import 'package:ym_flutter_widget/utils/ym_ui_util.dart';
import 'package:ym_flutter_widget/widgets/AppBar/ym_app_bar.dart';
import 'package:ym_flutter_widget/widgets/Picker/ym_cascader.dart';
import 'package:ym_flutter_widget/widgets/Dialog/ym_dialog_box.dart';
import 'package:ym_flutter_widget/widgets/Picker/ym_date_picker.dart';

///
/// 日期时间选择器
///
class DateTimePickerPage extends StatefulWidget {

  DateTimePickerPage({Key? key}) : super(key: key);

  final String title = "日期时间选择器";

  @override
  _DateTimePickerPageState createState() => _DateTimePickerPageState();
}

class _DateTimePickerPageState extends State<DateTimePickerPage> with SingleNativeStateMixin{

  String  _chooseDate = "";

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
          onStart();
        }
      }
    });

  }

  @override
  Future<void> onStart() async{
    super.onStart();

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
              height:  MediaQuery.of(context).size.height - appBarHeight,
              child:Column(
                children: [

                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 16),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          child: Padding(
                              padding: EdgeInsets.only(top:0,left: 16,bottom: 0),
                              child:Text(
                                "日期选择",
                                textAlign:TextAlign.left,
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 15,
                                ),
                              )
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child:GestureDetector(
                              child: Padding(
                                  padding: EdgeInsets.only(top:0,left:16,right: 16,bottom: 0),
                                  child:Text(
                                    _chooseDate==""?"请选择日期":_chooseDate,
                                    textAlign:TextAlign.left,
                                    style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 15,
                                    ),
                                  )
                              ),
                              onTap:_openDatePickerDialog ,
                            )
                        )
                      ],
                    ),
                  ),
                ],
              ),


            ),
          ],
        ),
      ),
    );
  }

  // 选择日期
  Future _openDatePickerDialog() async {
    YmUiUtil.showBottomDialog(context,StatefulBuilder(
      builder: (context,state){
        return  YmDatePicker(
          "1920-10-01",
          "2090-10-01",
          value: _chooseDate,
          onOkClick:(String date){
            Navigator.of(context).pop();
            setState(() {
              _chooseDate = date;
            });
          },
          onCancelClick:(){
            Navigator.of(context).pop();
          },
        );
      },
    ));
  }

}