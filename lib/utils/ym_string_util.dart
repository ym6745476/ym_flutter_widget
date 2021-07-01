
/// 字符串工具类
class YmStringUtil {

  ///去掉金额的.00
  static toStringMoney(double money) {
       String moneyNew = money.toStringAsFixed(2);
       return moneyNew.replaceAll(".00", "");
  }

  ///判断是否为手机号
  static isMobile(String mobile){
    RegExp exp = RegExp(r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
    return exp.hasMatch(mobile);
  }


  ///将姓名变为*号
  static String formatStarName(String name) {
    String newStr;
    if (name.length == 2) {
      newStr = "*" + name.substring(1, 2);
    } else if (name.length == 3) {
      newStr = name.substring(0, 1) + "*" + name.substring(2);
    } else if (name.length == 4) {
      newStr = name.substring(0, 2) + "*" + name.substring(3);
    }  else if (name.length > 4) {
      newStr = name.substring(0, 2) + "**" + name.substring(4);
    } else {
      newStr = name;
    }
    return newStr;
  }

}