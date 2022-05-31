import 'dart:async';
import 'package:flutter/material.dart';

/*class StreamPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stream')),
      body: Center(
        child: StreamBuilder<String>(
            initialData: "",
            stream: Stream.periodic(Duration(seconds: 1), (value) {
              return DateTime.now().toIso8601String();
            }),
            builder: (context, AsyncSnapshot<String> snapshot) {
              return Text(
                '${snapshot.data}',
                style: TextStyle(fontSize: 24.0),
              );
            }),
      ),
    );
  }
}*/

class StreamPage extends StatefulWidget {
  @override
  _StreamPageState createState() => _StreamPageState();
}

class _StreamPageState extends State<StreamPage> {
  late StreamController<int> _streamController;
  var _counter = 0;

  @override
  void initState() {
    _streamController = StreamController<int>();
    super.initState();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  Stream<int> counter() {
    return _streamController.stream;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stream')),
      body: Center(
        child: StreamBuilder<int>(
            initialData: 0,
            stream: counter(),
            builder: (context, AsyncSnapshot<int> snapshot) {
              return Text(
                '${snapshot.data}',
                style: TextStyle(fontSize: 24.0),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _streamController.add(++_counter);
        },
      ),
    );
  }
}
