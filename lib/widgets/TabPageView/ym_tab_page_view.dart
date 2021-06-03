import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ym_flutter_widget/widgets/Empty/ym_empty.dart';

///
/// 顶部是TabBar，内容是列表
///

class YmTabPageView extends StatefulWidget {

  //Tab数据
  late List<String> tabs;
  late List<dynamic> items;
  final int selectedIndex;
  final Function onChanged;
  final Function onItemBuilder;
  final double fontSize;
  final Size size;

  YmTabPageView(
      this.tabs,
      this.items,
      {
        Key? key,
        this.fontSize = 15,
        this.size = const Size(500, 500),
        this.selectedIndex = 0,
        required this.onChanged,
        required this.onItemBuilder,
      }
  ): super(key: key);

  @override
  _YmTabPageViewState createState() => _YmTabPageViewState(this.selectedIndex);

}

class _YmTabPageViewState extends State<YmTabPageView> with SingleTickerProviderStateMixin{

  late TabController _tabController;
  late int _selectedIndex;

  _YmTabPageViewState(this._selectedIndex);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: widget.tabs.length,vsync: this);
  }

  List<Widget> _getTabListWidget(){
    List<Widget>  tabWidgets = [];
    for(int i = 0;i < widget.tabs.length;i++){
      tabWidgets.add(Text(widget.tabs[i],
          textAlign:TextAlign.center,
          style: TextStyle(
            color: _selectedIndex==i?Color(0xff606FFF):Color(0xff666666),
            fontWeight: _selectedIndex==i?FontWeight.w800:FontWeight.normal,
            fontSize: widget.fontSize,
          )
      ));
    }
    return tabWidgets;
  }


  Widget _getListViewWidget(){

    if(widget.items.length > 0){
      return ListView.builder(
          primary: true,
          shrinkWrap: true,  //为true可以解决子控件必须设置高度的问题
          scrollDirection: Axis.vertical,
          physics: ClampingScrollPhysics(),
          itemCount: widget.items.length,
          itemBuilder: (context, index) {
            return widget.onItemBuilder(index);
          }
      );
    }else{
      print("显示空页面");
      return Container(
        width: widget.size.width,
        height: widget.size.height - 50,
        child: YmEmpty("暂无数据","assets/images/ic_no_data.png"),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size.width,
      height: widget.size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          Container(
            child:TabBar(
              isScrollable: false,
              controller: _tabController,
              labelColor: Color(0xff666666),
              unselectedLabelColor: Color(0xff666666),
              labelPadding:EdgeInsets.only(top:0,left: 0,right:0,bottom: 2),
              labelStyle: TextStyle(fontSize: 15),
              indicatorColor: Color(0xff3446F2),
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 2,
              tabs:_getTabListWidget(),
              onTap: (int index){
                print('Selected......$index');
                setState(() {
                  _selectedIndex = index;
                });
                widget.onChanged(index);
              },
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top:5,left: 0,right: 0,bottom: 0),
            child:Container(
                    child:MediaQuery.removePadding(
                      removeTop:true,
                      context:context,
                      child:_getListViewWidget(),
                    ),
                  ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

}