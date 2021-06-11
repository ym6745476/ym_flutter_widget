import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ym_flutter_widget/widgets/Empty/ym_empty.dart';

///
/// 顶部是TabBar，内容是列表
///

class YmListView extends StatefulWidget {


  late List<dynamic> items;
  late ScrollController scrollController;
  final Function onItemBuilder;
  final Function onLoadMore;
  final Size size;
  bool hasMoreData;


  YmListView(
      this.items,
      this.scrollController,
      {
        Key? key,
        this.size = const Size(500, 500),
        this.hasMoreData = true,
        required this.onItemBuilder,
        required this.onLoadMore,

      }
  ): super(key: key);

  @override
  _YmListViewState createState() {
    return _YmListViewState();
  }
}

class _YmListViewState extends State<YmListView> with SingleTickerProviderStateMixin{


  bool _isLoading = false;

  _YmListViewState();

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(() {
      if (widget.scrollController.position.pixels == widget.scrollController.position.maxScrollExtent) {
        if(widget.hasMoreData){
            setState(() {
              _isLoading = true;
            });
            widget.onLoadMore();
        }
      }
    });
  }

  Widget _buildProgressIndicator() {
    if(_isLoading && widget.hasMoreData){
      return Center(
        child:Container(
          width:40,
          height:40,
          child:Padding(
            padding: EdgeInsets.all(8),
            child:CircularProgressIndicator(
              color:Color(0xFF606FFF),
              strokeWidth: 3,
            ),
          ),
        )
      );
    }else {
      return Center(
        child: Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              "没有更多了~",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF666666)
              ),)
        ),
      );
    }
  }

  Widget _getListViewWidget(){

    if(widget.items.length > 0){
      return ListView.builder(
          controller:widget.scrollController,
          shrinkWrap: true,  //为true可以解决子控件必须设置高度的问题
          scrollDirection: Axis.vertical,
          physics: ClampingScrollPhysics(),
          itemCount: widget.items.length + 1,
          itemBuilder: (context, index) {
            if(index == widget.items.length){
              return _buildProgressIndicator();
            }else{
              return widget.onItemBuilder(index);
            }
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
      child: MediaQuery.removePadding(
        removeTop:true,
        context:context,
        child:_getListViewWidget(),
      ),
    );
  }

  @override
  void dispose() {
    widget.scrollController.dispose();
    super.dispose();
  }

}