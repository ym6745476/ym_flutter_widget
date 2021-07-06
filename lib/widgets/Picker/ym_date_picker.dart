import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ym_flutter_widget/utils/ym_date_util.dart';
import 'package:ym_flutter_widget/utils/ym_string_util.dart';
import 'package:ym_flutter_widget/widgets/Button/ym_text_button.dart';
import 'package:ym_flutter_widget/widgets/Picker/ym_picker.dart';

/// 日期选择器（年-月-日）
class YmDatePicker extends StatefulWidget {

  //开始日期
  final String beginDate;

  //结束日期
  final String endDate;

  //默认值
  final String value;

  final Function onOkClick;
  final Function onCancelClick;
  final Color backgroundColor;
  final double itemHeight;

  YmDatePicker(this.beginDate,
      this.endDate,
      {
        Key? key,
        required this.onOkClick,
        required this.onCancelClick,
        this.itemHeight = 36,
        this.backgroundColor = const Color(0xffffffff),
        this.value = "",
      }) : super(key: key);

  @override
  YmDatePickerState createState() => YmDatePickerState();

}

class YmDatePickerState extends State<YmDatePicker>{

  //数据
  List<List<Map>> _data = [];

  //默认值
  List<int> _currentIndex = [0,0,0,0];

  @override
  void initState() {
    super.initState();

    DateTime beginDate = YmDateUtil.formatDateTime(widget.beginDate + " 23:59:59");
    DateTime endDate = YmDateUtil.formatDateTime(widget.endDate + " 23:59:59");


    String value = YmStringUtil.strEmpty(widget.value)?YmDateUtil.currentDateString():widget.value;

    DateTime currentDate = YmDateUtil.formatDateTime(value + " 23:59:59");

    _data = [];
    //生成年的数据
    _data.add(List.generate(endDate.year - beginDate.year + 1, (index) => {"label": (beginDate.year + index).toString(), "value": (beginDate.year + index).toString()}));
    //生成月的数据
    _data.add(List.generate(12, (index) => {"label": YmDateUtil.format2Number((index+1).toString()), "value": (index+1).toString()}));
    //生成日的数据
    _data.add(List.generate(YmDateUtil.getDateCount(int.parse(_data[0][0]['value']),int.parse( _data[1][0]['value'])), (index) => {"label": YmDateUtil.format2Number((index + 1).toString()), "value": (index + 1).toString()}));

    _currentIndex[0] = _data[0].indexWhere((element) => element['value']==currentDate.year.toString());
    _currentIndex[1] = _data[1].indexWhere((element) => element['value']==currentDate.month.toString());
    _currentIndex[2] = _data[2].indexWhere((element) => element['value']==currentDate.day.toString());

    //print(_data[0]);
    //print(_data[1]);
    //print(_data[2]);
  }


  void _onChanged(int position,int index){
    _currentIndex[position] = index;
    if(position == 0){
      //生成月的数据
      var _dataMonth = (List.generate(12, (index) => {"label": YmDateUtil.format2Number((index+1).toString()), "value": (index+1).toString()}));
      var _dataDay = (List.generate(YmDateUtil.getDateCount(int.parse(_data[0][_currentIndex[0]]['value']),int.parse(_data[1][_currentIndex[1]]['value'])), (index) => {"label": YmDateUtil.format2Number((index + 1).toString()), "value": (index + 1).toString()}));

      setState(() {
        _data[1] =_dataMonth;
        _currentIndex[1] = _currentIndex[1] > _data[1].length-1?_data[1].length-1:_currentIndex[1];
        _data[2] =_dataDay;
        _currentIndex[2] = _currentIndex[2] > _data[2].length-1?_data[2].length-1:_currentIndex[2];
      });
    }else if(position == 1){
      //生成日的数据
      var _dataDay = (List.generate(YmDateUtil.getDateCount(int.parse(_data[0][_currentIndex[0]]['value']),int.parse( _data[1][_currentIndex[1]]['value'])), (index) => {"label": YmDateUtil.format2Number((index + 1).toString()), "value": (index + 1).toString()}));
      print(_dataDay);
      setState(() {
        _data[2] =_dataDay;
        _currentIndex[2] = _currentIndex[2] > _data[2].length-1?_data[2].length-1:_currentIndex[2];
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    double pickerItemWidth = (MediaQuery.of(context).size.width)/this._data.length;

    return Container(
      height:220,
      decoration: BoxDecoration(color: Color(0xFFFFFFFF)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Divider(
            height: 1,
            color: Color(0xFFEFEFEF),
            thickness: 1,
          ),
          Container(
            height:39,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  YmTextButton("取消", textColor:Color(0xFF666666), onClick: (){
                    widget.onCancelClick();
                  },size: Size(80,40),backgroundColor: Colors.transparent,pressedBackgroundColor:Color(0xFFEFEFEF) ,),

                  YmTextButton("确定", textColor:Color(0xFF3446F2), onClick:(){
                    String date = _data[0][_currentIndex[0]]['value'] + "-" + YmDateUtil.format2Number(_data[1][_currentIndex[1]]['value']) + "-" + YmDateUtil.format2Number(_data[2][_currentIndex[2]]['value']);
                    print("选择的日期是：" + date);
                    widget.onOkClick(date);
                  },size:Size(80,40),backgroundColor: Colors.transparent,pressedBackgroundColor:Color(0xFFEFEFEF)),
                ]
            ),
          ),

          Row(
            children:List.generate(this._data.length, (position) {
              return YmPicker(
                this._data[position],
                currentIndex: this._currentIndex[position],
                width: pickerItemWidth,
                itemHeight: 40,
                height: 180,
                onChanged: (index,val) {
                  print("Picker onChanged  position=" + position.toString() + ",index=" + index.toString() + ",val=" + val);
                  _onChanged(position,index);
                },
              );
            }),
          )
        ],
      ),
    );
  }

}

