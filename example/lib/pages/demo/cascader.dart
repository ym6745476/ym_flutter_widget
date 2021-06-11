import 'package:example/base/single_native_state_mixin.dart';
import 'package:flutter/material.dart';
import 'package:example/base/config.dart';
import 'package:ym_flutter_widget/widgets/AppBar/ym_app_bar.dart';
import 'package:ym_flutter_widget/widgets/Cascader/ym_cascader.dart';
import 'package:ym_flutter_widget/widgets/Dialog/ym_dialog_box.dart';

///
/// Cascader级联选择器
///
class CascaderPage extends StatefulWidget {

  CascaderPage({Key? key}) : super(key: key);

  final String title = "Cascader";

  @override
  _CascaderPageState createState() => _CascaderPageState();
}

class _CascaderPageState extends State<CascaderPage> with SingleNativeStateMixin{

  //显示底部弹窗
  bool _showPickerDialog = false;

  //计算拼接地址字符串的
  List<int> _pickerSelected = [0,0,0];
  String  _address3 = "请选择";

  //{"label": "请选择", "value": ""},
  List<List<Map>> _regionData = [[],[],[]];    //数据
  List<String> _regionValue = ["0","0","0"];   //默认值

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
          _loadData(0,0);
        }
      }
    });

  }


  ///get请求数据
  Future<void> _loadData(int pid,int index) async {

    List<Map> listNew = [
    ];
    for (var i = 0; i < 20; i++) {
      listNew.add({"label": pid.toString() + "-" + i.toString(), "value": i.toString()});
      //判断默认值
      if(i.toString() == _regionValue[index]){
        _pickerSelected[index] = i;
      }
    }
    if(index == 0){
      setState(() {
        _regionData[0] = listNew;
      });
      print("update list1...............");

      //接着查询市
      _loadData(int.parse(_regionValue[0]),1);

    }else if(index == 1){
      print("update list2...............");
      setState(() {
        _regionData[1] = listNew;
      });
      //接着查询区
      _loadData(int.parse(_regionValue[1]),2);

    }else if(index == 2){
      print("update list3...............");
      setState(() {
        _regionData[2] = listNew;
      });
    }

  }

  Future<void> _changeData(int pid,int index) async {
    List<Map> listNew = [
    ];

    for (var i = 0; i < 20; i++) {
      listNew.add({"label": pid.toString() + "-" + i.toString(), "value": i.toString()});
    }

    if(index == 1){
      print("update list2...............");
      setState(() {
        _regionData[1] = listNew;
      });

      //父节点变化后，选中第一个
      _regionValue[1] = _regionData[1][0]['value'];
      //接着查询区
      _loadData(pid,2);

    }else if(index == 2){
      print("update list3...............");
      setState(() {
        _regionData[2] = listNew;
      });

      //父节点变化后，选中第一个
      _regionValue[2] = _regionData[2][0]['value'];

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
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      child: Padding(
                          padding: EdgeInsets.only(top:0,left: 16,bottom: 0),
                          child:Text(
                            "级联组件",
                            textAlign:TextAlign.left,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
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
                                _address3,
                                textAlign:TextAlign.left,
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                ),
                              )
                          ),
                          onTap:_openPickerDialog ,
                        )
                    )
                  ],
                ),
              ),
            ),

            _showPickerDialog?
            Positioned(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: YmDialogBox(
                  child:_pickerDialog(),
              ),
            ):Container()
          ],
        ),
      ),
    );
  }


  Widget _pickerDialog() {
    return YmCascader(
      _regionData,_regionValue,
      onOkClick:(){
        closePickerDialog();
        setState(() {
          _address3 = _regionData[0].elementAt(_pickerSelected[0])['label'] + "/" + _regionData[1].elementAt(_pickerSelected[1])['label'] + "/" + _regionData[2].elementAt(_pickerSelected[2])['label'];
        });
      },
      onCancelClick:(){
        closePickerDialog();

      },
      onChanged: (position,index,value){
        if(position == 0){
          _pickerSelected[0] = index;
          _pickerSelected[1] = 0;
          _pickerSelected[2] = 0;
          _regionValue[0] = value;
          _changeData(int.parse(value),1);
        }else if(position == 1){
          _pickerSelected[1] = index;
          _pickerSelected[2] = 0;
          _regionValue[1] = value;
          _changeData(int.parse(value),2);
        }else if(position == 2){
          _pickerSelected[2] = index;
          _regionValue[2] = value;
        }
      },
    );

  }

  // 对话框式底部滑动窗口
  Future _openPickerDialog() async {
    setState(() {
      _showPickerDialog = true;
    });
  }

  void closePickerDialog(){
    setState(() {
      _showPickerDialog = false;
    });
  }

}