

class YmStringUtil {


  static toStringMoney(double money) {
       String moneyNew = money.toStringAsFixed(2);
       return moneyNew.replaceAll(".00", "");
  }

  static isMobile(String mobile){
    RegExp exp = RegExp(r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
    return exp.hasMatch(mobile);
  }

}