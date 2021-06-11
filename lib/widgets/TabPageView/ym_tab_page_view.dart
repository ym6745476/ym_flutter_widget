import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ym_flutter_widget/widgets/Empty/ym_empty.dart';
import 'package:ym_flutter_widget/widgets/ListView/ym_list_view.dart';

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
  final Function onLoadMore;
  final double fontSize;
  final Size size;
  final double tabBarHeight;
  bool hasMoreData;

  YmTabPageView(
      this.tabs,
      this.items,
      {
        Key? key,
        this.fontSize = 15,
        this.size = const Size(500, 500),
        this.tabBarHeight = 40,
        this.selectedIndex = 0,
        this.hasMoreData = true,
        required this.onChanged,
        required this.onItemBuilder,
        required this.onLoadMore,

      }
  ): super(key: key);

  @override
  _YmTabPageViewState createState() {
    return _YmTabPageViewState(this.selectedIndex);
  }
}

class _YmTabPageViewState extends State<YmTabPageView> with SingleTickerProviderStateMixin{

  late TabController _tabController;
  late ScrollController _scrollController;
  late int _selectedIndex;

  _YmTabPageViewState(this._selectedIndex);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: widget.tabs.length,vsync: this);
    _scrollController = ScrollController();
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
            height: widget.tabBarHeight,
            child:TabBar(
              isScrollable: false,
              controller: _tabController,
              labelColor: Color(0xff666666),
              unselectedLabelColor: Color(0xff666666),
              labelPadding:EdgeInsets.only(top:5,left: 0,right:0,bottom: 5),
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
                _scrollController.jumpTo(0);
              },
            ),
          ),

          Padding(
            padding:EdgeInsets.only(top:0,left: 0,right: 0,bottom: 0),
            child:YmListView(widget.items,
                  _scrollController,
                  size: Size(widget.size.width, widget.size.height - widget.tabBarHeight),
                  hasMoreData: widget.hasMoreData,
                  onItemBuilder: (index) {
                    return widget.onItemBuilder(index);
                  },
                  onLoadMore: (){
                    widget.onLoadMore();
                  }
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