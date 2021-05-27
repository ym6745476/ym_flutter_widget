
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart' as dom;

class YmHtml extends StatelessWidget {

  String html;
  final double width;
  final List<HtmlTag> tagList = [];

  YmHtml(this.html,this.width);

  @override
  Widget build(BuildContext context) {
    //html = "<html><head></head><body><p><p>测试标题</p><img src=\"http://wtycadmin.weiwogroup.cn/images/shd7ecbop35l7xvfwxyk.png\" alt=\"\" width=\"750\" height=\"5020\"></p></body></html>";
    var document = parse(html);
    print(document.outerHtml);
    _parseHtml(document.body!);
    return Container(
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _getWidget(),
      ),
    );
  }

  _getWidget(){
    List<Widget> widgetList = [];
    for(HtmlTag tag in tagList){
      if(tag.name == "p"){
        widgetList.add(
            Container(
              width:width ,
              alignment: AlignmentDirectional.centerStart,
              child:  Padding(
                  padding: EdgeInsets.only(top: 2, left: 10, right: 10, bottom: 2),
                  child:  Text(tag.text,
                    textAlign:TextAlign.left,
                    style: TextStyle(
                      color: Color(0xff222222),
                      fontSize: 14,
                    ),
                  )
              )
            )
        );
      }else if(tag.name == "img"){
        widgetList.add(
          Image.network(
            tag.src,
            fit:BoxFit.fitWidth,
            width:width,
            loadingBuilder:(BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null){
                     return child;
                }
                return Center(
                      child:Padding(
                          padding: EdgeInsets.all(30),
                          child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                  : null),
                      ),
                );
            },
          )
        );
      }

    }

    return widgetList;
  }

  _parseHtml(dom.Element element){

    List<dom.Element> elementList = element.children;
    if(elementList.length > 0){
      for(dom.Element element in elementList){
        _parseHtml(element);
      }
    }else{
      print(element.localName);
      HtmlTag tag = HtmlTag();
      if(element.localName == "p"){
        tag.name = element.localName!;
        tag.text = element.innerHtml;
        tagList.add(tag);
      }else if(element.localName == "img"){
        tag.name = element.localName!;
        tag.src = element.attributes['src']!;
        tagList.add(tag);
      }
    }

  }

}

class HtmlTag{

  late String name;
  late String src;
  late String text;

}