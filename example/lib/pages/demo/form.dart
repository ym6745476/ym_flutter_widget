import 'package:example/base/single_native_state_mixin.dart';
import 'package:flutter/material.dart';
import 'package:example/base/config.dart';
import 'package:ym_flutter_widget/widgets/AppBar/ym_app_bar.dart';
import 'package:ym_flutter_widget/widgets/Button/ym_check_button.dart';
import 'package:ym_flutter_widget/widgets/Button/ym_text_button.dart';
import 'package:ym_flutter_widget/widgets/Form/ym_form_item_input.dart';
import 'package:ym_flutter_widget/widgets/Form/ym_form_item_number.dart';
import 'package:ym_flutter_widget/widgets/Form/ym_form_item_radio.dart';
import 'package:ym_flutter_widget/widgets/Form/ym_form_item_select.dart';
import 'package:ym_flutter_widget/widgets/Form/ym_form_item_title.dart';

///表单
class FormPage extends StatefulWidget {
  FormPage({Key? key}) : super(key: key);

  final String title = "表单";

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> with SingleNativeStateMixin {


  String _selectText = "请选择";
  String _inputText = "";
  int _radioCheck = 0;
  int _number = 1;


  @override
  void initState() {
    super.initState();
  }

  @override
  Future<void> onStart(Map<String, dynamic>? arguments) async{
    super.onStart(arguments);
    //加载数据
    print("FormPage onStart");
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
                  background:appBarColors,
                  onBackClick: goBack,
                  textColor: Colors.white,
                ),
              ),
            ),

            ///表单
            Positioned(
              top: appBarHeight + 30,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    YmFormItemTitle(
                      "表单标题",
                      fontSize: 14,
                      textColor: Color(0xFF333333),
                      iconLeft: "assets/images/logo.png",
                      size: Size(MediaQuery.of(context).size.width, 44),
                    ),


                    YmFormItemSelect(
                      _selectText,
                      label: "选择器",
                      size: Size(MediaQuery.of(context).size.width, 44),
                      onClick: () {
                        //_showSelectDialog();
                      },
                      rightImage: "assets/images/ic_right.png",
                      hintText: "请选择",
                      // required: true,
                    ),

                    YmFormItemInput(
                      _inputText,
                      label: "输入项",
                      size: Size(MediaQuery.of(context).size.width, 44),
                      onTextChanged: (value) {
                        _inputText = value;
                      },
                      hintText: "请输入",
                      required: true,
                    ),

                    YmFormItemRadio(
                      ["男", "女"],
                      [0, 1],
                      _radioCheck,
                      label: "性别",
                      size: Size(MediaQuery.of(context).size.width, 44),
                      onChanged: (bool checked, dynamic value) {
                        if (checked) {
                          setState(() {
                            _radioCheck = value;
                          });
                        }
                      },
                    ),

                    Container(
                      padding: EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 10),
                      child:  Row(
                        children: [
                          YmCheckButton(
                            value: 0,
                            checked: true,
                            onChanged: (bool checked, dynamic value) {
                              //_onCheckedChanged(checked, value);
                            },
                            text: "选中1",
                            fontSize: 12,
                            image: "assets/images/ic_box.png",
                            checkedImage: "assets/images/ic_box_checked.png",
                          ),
                          YmCheckButton(
                            value: 1,
                            checked: false,
                            onChanged: (bool checked, dynamic value) {
                              //_onCheckedChanged(checked, value);
                            },
                            text: "选中2",
                            fontSize: 12,
                            image: "assets/images/ic_box.png",
                            checkedImage: "assets/images/ic_box_checked.png",
                          ),
                        ],
                      ),
                    ),

                    YmFormItemNumber(
                      _number,
                      size: Size(MediaQuery.of(context).size.width, 44),
                      label: "数量",
                      onMinusClick: () {
                        setState(() {
                          _number = _number-1;
                        });
                      },
                      onPlusClick: () {
                        setState(() {
                          _number = _number+1;
                        });
                      },
                    )

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
