import 'package:example/base/single_native_state_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:example/base/config.dart';
import 'package:ym_flutter_widget/widgets/AppBar/ym_app_bar.dart';
import 'package:ym_flutter_widget/widgets/SearchBar/ym_search_bar.dart';

class SearchBarPage extends StatefulWidget {
  SearchBarPage({Key? key}) : super(key: key);

  final String title = "SearchBar";

  @override
  _SearchBarPageState createState() => _SearchBarPageState();
}

class _SearchBarPageState extends State<SearchBarPage> with SingleNativeStateMixin {
  String _searchTextValue = "";

  @override
  void initState() {
    super.initState();
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
                child: YmAppBar(
                  widget.title,
                  background: [
                    const Color(0xFF606FFF),
                    const Color(0xFF3446F2),
                  ],
                  onBackClick: goBack,
                  textColor: Colors.white,
                ),
              ),
            ),

            Positioned(
              top: appBarHeight,
              left: 0,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 5),
                child: YmSearchBar(
                    hint: "请输入关键词",
                    width: MediaQuery.of(context).size.width - 40,
                    height: 40,
                    onSubmitted: (text) {
                      print("搜索$text");
                      setState(() {
                        _searchTextValue = text;
                      });
                    },
                    clearCallback: () {
                      setState(() {
                        _searchTextValue = "";
                      });
                    },
                    onBackCallback: () {}),
              ),
            ),

            Positioned(
              top: 300,
              left: 0,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(_searchTextValue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
