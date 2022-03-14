

class ImageElement{

  String src = "";

  late CssStyleDeclaration style;
}

class DivElement{

}

class CssStyleDeclaration{
  String width = "";
  String height = "";
  String left = "";
  String position = "";
  String transform = "";
}

class Dimension{
  num _value;
  String _unit;

  Dimension.percent(this._value) : _unit = '%';
  Dimension.px(this._value) : _unit = 'px';

}