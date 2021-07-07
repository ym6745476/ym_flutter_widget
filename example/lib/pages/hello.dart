import 'package:example/base/single_native_state_mixin.dart';
import 'package:flutter/material.dart';
import 'package:ym_flutter_widget/widgets/Button/ym_image_button.dart';

class HelloPage extends StatefulWidget {

  HelloPage({Key? key}) : super(key: key);

  final String title = "Ym Flutter Widget";

  @override
  _HelloPageState createState() => _HelloPageState();
}

class _HelloPageState extends State<HelloPage> with SingleNativeStateMixin{

  @override
  void initState() {
    super.initState();
  }

  List<Widget>  getListWidget(){

    List<Map> buttons = [
      {'text':'调用Native','path':'/demo/native'},
      {'text':'Http','path':'/demo/http'},
      {'text':'AppBar','path':'/demo/appbar'},
      {'text':'SearchBar','path':'/demo/searchbar'},
      {'text':'Button','path':'/demo/button'},
      {'text':'CheckButton','path':'/demo/checkbutton'},
      {'text':'TextField','path':'/demo/textfield'},
      {'text':'Dialog','path':'/demo/dialog'},
      {'text':'Toast','path':'/demo/toast'},
      {'text':'Loading','path':'/demo/loading'},
      {'text':'Empty','path':'/demo/empty'},
      {'text':'Error','path':'/demo/error'},
      {'text':'Html','path':'/demo/html'},
      {'text':'Image','path':'/demo/image'},
      {'text':'Video','path':'/demo/video'},
      {'text':'DateTimePicker','path':'/demo/datetimepicker'},
      {'text':'Cascader','path':'/demo/cascader'},
      {'text':'TabPageView','path':'/demo/tabview'},
      {'text':'ListView','path':'/demo/listview'},
      {'text':'QrCode','path':'/demo/qrcode'},
      {'text':'String工具类','path':'/demo/stringutil'},
      {'text':'UI工具类','path':'/demo/uiutil'},
      {'text':'Date工具类','path':'/demo/dateutil'},
    ];
    return List.generate(buttons.length, (index) {

        return ElevatedButton(
          child: Text(buttons[index]['text']),
          onPressed:(){
            Navigator.of(context).pushNamed(buttons[index]['path'],arguments: {'flutter':true});
          },
        );

    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

            //功能列表
            Padding(
              padding: EdgeInsets.only(top:10,left: 16,right: 16,bottom: 10),
              child: Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: getListWidget(),
                  ),
              )
          ],
        ),
      ),
    );
  }
}