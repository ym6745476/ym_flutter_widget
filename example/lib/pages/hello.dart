import 'package:example/base/single_native_state_mixin.dart';
import 'package:flutter/material.dart';

import '../my_router.dart';


class HelloPage extends StatefulWidget {
  HelloPage({Key? key}) : super(key: key);

  final String title = "Ym Flutter Widget";

  @override
  _HelloPageState createState() => _HelloPageState();
}

class _HelloPageState extends State<HelloPage> with SingleNativeStateMixin {
  @override
  void initState() {
    super.initState();
  }

  List<Widget> getListWidget() {
    List<Map> buttons = [
      {'text': '调用Native', 'path': MyRouter.nativePage},
      {'text': 'Http', 'path': MyRouter.httpPage},
      {'text': 'AppBar', 'path': MyRouter.appbarPage},
      {'text': 'SearchBar', 'path': MyRouter.searchbarPage},
      {'text': 'Button', 'path': MyRouter.buttonPage},
      {'text': 'TabButton', 'path': MyRouter.tabButtonPage},
      {'text': 'CheckButton', 'path': MyRouter.checkButtonPage},
      {'text': 'TextField', 'path': MyRouter.textFieldPage},
      {'text': 'Dialog', 'path': MyRouter.dialogPage},
      {'text': 'Toast', 'path': MyRouter.toastPage},
      {'text': 'Loading', 'path': MyRouter.loadingPage},
      {'text': 'Empty', 'path': MyRouter.emptyPage},
      {'text': 'Error', 'path': MyRouter.emptyPage},
      {'text': 'Html', 'path': MyRouter.htmlPage},
      {'text': 'Image', 'path': MyRouter.imagePage},
      {'text': 'Video', 'path': MyRouter.videoPage},
      {'text': 'DateTimePicker', 'path': MyRouter.dateTimePickerPage},
      {'text': 'Cascader', 'path': MyRouter.cascaderPage},
      {'text': 'TabPageView', 'path': MyRouter.tabViewPage},
      {'text': 'ListView', 'path': MyRouter.listViewPage},
      {'text': 'QrCode', 'path': MyRouter.qrCodePage},
      {'text': '下拉刷新', 'path': MyRouter.pullRefreshPage},
      {'text': 'Stream', 'path': MyRouter.streamPage},
      {'text': 'String工具类', 'path': ''},
      {'text': 'UI工具类', 'path': ''},
      {'text': 'Date工具类', 'path': ''},
    ];
    return List.generate(buttons.length, (index) {
      return ElevatedButton(
        child: Text(buttons[index]['text']),
        onPressed: () {
          Navigator.of(context).pushNamed(buttons[index]['path'], arguments: {'flutter': true});
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            //功能列表
            Padding(
              padding: EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 10),
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
