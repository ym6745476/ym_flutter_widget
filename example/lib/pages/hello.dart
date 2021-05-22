import 'package:flutter/material.dart';

class HelloPage extends StatefulWidget {

  HelloPage({Key? key}) : super(key: key);

  final String title = "Ym Flutter Widget";

  @override
  _HelloPageState createState() => _HelloPageState();
}

class _HelloPageState extends State<HelloPage> {

  @override
  void initState() {
    super.initState();
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
              padding: EdgeInsets.only(top:10,left: 16,right: 16,bottom: 10),
              child: Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: [
                      ElevatedButton(
                        child: Text('调用Native'),
                        onPressed:(){
                          Navigator.of(context).pushNamed('/demo/native',arguments: {'flutter':true});
                        },
                      ),

                      ElevatedButton(
                        child: Text('Http'),
                        onPressed:(){
                          Navigator.of(context).pushNamed('/demo/http',arguments: {'flutter':true});
                        },
                      ),

                      ElevatedButton(
                        child: Text('AppBar'),
                        onPressed:(){
                          Navigator.of(context).pushNamed('/demo/appbar',arguments: {'flutter':true});
                        },
                      ),
                      ElevatedButton(
                        child: Text('SearchBar'),
                        onPressed:(){
                          Navigator.of(context).pushNamed('/demo/searchbar',arguments: {'flutter':true});
                        },
                      ),
                      ElevatedButton(
                        child: Text('Button'),
                        onPressed:(){
                          Navigator.of(context).pushNamed('/demo/button',arguments: {'flutter':true});
                        },
                      ),
                      ElevatedButton(
                        child: Text('TextField'),
                        onPressed:(){
                          Navigator.of(context).pushNamed('/demo/textfield',arguments: {'flutter':true});
                        },
                      ),

                      ElevatedButton(
                        child: Text('Dialog'),
                        onPressed:(){
                          Navigator.of(context).pushNamed('/demo/dialog',arguments: {'flutter':true,'orderId':0});
                        },
                      ),

                      ElevatedButton(
                        child: Text('Toast'),
                        onPressed:(){
                          Navigator.of(context).pushNamed('/demo/toast',arguments: {'flutter':true,'orderId':0});
                        },
                      ),

                      ElevatedButton(
                        child: Text('Loading'),
                        onPressed:(){
                          Navigator.of(context).pushNamed('/demo/loading',arguments: {'flutter':true,'orderId':0});
                        },
                      ),

                      ElevatedButton(
                        child: Text('Empty'),
                        onPressed:(){
                          Navigator.of(context).pushNamed('/demo/empty',arguments: {'flutter':true,'orderId':0});
                        },
                      ),

                      ElevatedButton(
                        child: Text('Html'),
                        onPressed:(){
                          Navigator.of(context).pushNamed('/demo/html',arguments: {'flutter':true,'orderId':0});
                        },
                      ),

                      ElevatedButton(
                        child: Text('Image'),
                        onPressed:(){
                          Navigator.of(context).pushNamed('/demo/image',arguments: {'flutter':true,'orderId':0});
                        },
                      ),

                      ElevatedButton(
                        child: Text('Video'),
                        onPressed:(){
                          Navigator.of(context).pushNamed('/demo/video',arguments: {'flutter':true,'orderId':0});
                        },
                      ),

                      ElevatedButton(
                        child: Text('字符串工具类'),
                        onPressed:(){
                          Navigator.of(context).pushNamed('/demo/stringutil',arguments: {'flutter':true,'orderId':0});
                        },
                      ),

                      ElevatedButton(
                        child: Text('UI工具类'),
                        onPressed:(){
                          Navigator.of(context).pushNamed('/demo/uiutil',arguments: {'flutter':true,'orderId':0});
                        },
                      ),

                    ],
                  ),
              )
          ],
        ),
      ),
    );
  }
}