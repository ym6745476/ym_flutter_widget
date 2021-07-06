import 'package:example/base/single_native_state_mixin.dart';
import 'package:flutter/material.dart';
import 'package:example/base/config.dart';
import 'package:ym_flutter_widget/utils/ym_ui_util.dart';
import 'package:ym_flutter_widget/widgets/AppBar/ym_app_bar.dart';
import 'package:ym_flutter_widget/widgets/Picker/ym_cascader.dart';
import 'package:ym_flutter_widget/widgets/Dialog/ym_dialog_box.dart';

///
/// Cascader级联选择器
///
class CascaderPage extends StatefulWidget {

  CascaderPage({Key? key}) : super(key: key);

  final String title = "级联选择器";

  @override
  _CascaderPageState createState() => _CascaderPageState();
}

class _CascaderPageState extends State<CascaderPage> with SingleNativeStateMixin{

  //计算拼接地址字符串的
  String  _chooseText = "请选择";
  String  _chooseAddress = "请选择地址";

  List<List<Map>> _textData = [[{"label": "不满意", "value": "0"},{"label": "满意", "value": "1"},{"label": "非常满意", "value": "2"}]];  //数据
  List<int> _textIndex = [0];            //选择的索引

  //{"label": "请选择", "value": ""},
  List<List<Map>> _regionData = [[],[],[]];    //数据
  List<String> _regionValue = ["0","0","0"];   //默认值
  List<int> _regionIndex = [0,0,0];            //选择的索引


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
          //加载数据
          _initData(0,0);
        }
      }
    });

  }


  ///初始化数据
  Future<void> _initData(int pid,int index) async {

    List<Map> listNew = [];

    for (var i = 0; i < 20; i++) {
      listNew.add({"label": pid.toString() + "-" + i.toString(), "value": i.toString()});
      //判断默认值
      if(i.toString() == _regionValue[index]){
        _regionIndex[index] = i;
      }
    }

    setState(() {
      _regionData[index] = listNew;
    });

    _regionValue[index] = _regionData[index][0]['value'];

    if(index == 0 || index == 1){
      //接着查询下级
      _initData(int.parse(_regionValue[index]),index + 1);
    }

  }

  ///切换数据
  Future<void> _changeData(Function dialogState,int pid,int index) async {

    List<Map> listNew = [];

    for (var i = 0; i < 20; i++) {
      listNew.add({"label": pid.toString() + "-" + i.toString(), "value": i.toString()});
    }

    dialogState(() {
      _regionData[index] = listNew;
      _regionIndex[index] = _regionIndex[index] > _regionData[index].length-1?_regionData[index].length-1:_regionIndex[index];
    });

    _regionValue[index] = _regionData[index][0]['value'];

    if(index == 1){
      //接着查询下级
      _changeData(dialogState,int.parse(_regionValue[index]),index + 1);
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
                                "一级选择",
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
                                    _chooseText,
                                    textAlign:TextAlign.left,
                                    style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 15,
                                    ),
                                  )
                              ),
                              onTap:_openTextPickerDialog ,
                            )
                        )
                      ],
                    ),
                  ),

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
                                "三级选择",
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
                                    _chooseAddress,
                                    textAlign:TextAlign.left,
                                    style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 15,
                                    ),
                                  )
                              ),
                              onTap:_openAddressPickerDialog ,
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

  // 对话框式底部滑动窗口
  Future _openTextPickerDialog() async {
    YmUiUtil.showBottomDialog(context,StatefulBuilder(
      builder: (context,state){
        return  YmCascader(
          _textData,
          currentIndex: [1],
          onOkClick:(){
            Navigator.of(context).pop();
            setState(() {
              _chooseText = _textData[0].elementAt(_textIndex[0])['label'];
            });
          },
          onCancelClick:(){
            Navigator.of(context).pop();
          },
          onChanged: (position,index,value){
            _textIndex[position] = index;
          },
        );
      },
    ));
  }

  // 对话框式底部滑动窗口
  Future _openAddressPickerDialog() async {
    YmUiUtil.showBottomDialog(context,StatefulBuilder(
      builder: (context,state){
        return  YmCascader(
            _regionData,
            currentIndex: _regionIndex,
            onOkClick:(){
              Navigator.of(context).pop();
              setState(() {
                _chooseAddress = _regionData[0].elementAt(_regionIndex[0])['label'] + "/" + _regionData[1].elementAt(_regionIndex[1])['label'] + "/" + _regionData[2].elementAt(_regionIndex[2])['label'];
              });
            },
            onCancelClick:(){
              Navigator.of(context).pop();
            },
            onChanged: (position,index,value){

              //保存选中的值
              _regionIndex[position] = index;
              _regionValue[position] = value;

              if(position == 0 || position == 1){
                _changeData(state,int.parse(value),position + 1);
              }
            },
        );
      },
    ));
  }

}