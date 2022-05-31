import 'dart:convert';

import 'package:example/base/config.dart';
import 'package:example/base/single_native_state_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///和Native进行通信示例
class NativePage extends StatefulWidget {
  NativePage({Key? key}) : super(key: key);

  final String title = "Flutter与Native通信";

  @override
  _NativePageState createState() => _NativePageState();
}

class _NativePageState extends State<NativePage> with SingleNativeStateMixin {
  String _resultMessage = "";

  @override
  void initState() {
    super.initState();

  }

  ///Flutter调用原生
  Future<void> _callNative() async {
    try {
      Map<String, dynamic> message = {'message': 'flutter'};
      String result = await flutterChannel.invokeMethod('callNative', message);
      setState(() {
        _resultMessage = result;
      });
    } on PlatformException catch (e) {
      setState(() {
        _resultMessage = "Failed: '${e.message}'.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            //按钮
            Padding(
              padding: EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 10),
              child: Wrap(
                spacing: 5,
                runSpacing: 5,
                children: [
                  ElevatedButton(
                    child: Text('调用Native'),
                    onPressed: _callNative,
                  ),
                ],
              ),
            ),

            //结果
            Padding(
              padding: EdgeInsets.only(top: 5, left: 0, right: 0, bottom: 0),
              child: Text(_resultMessage),
            ),
          ],
        ),
      ),
    );
  }
}
