

class YmStringUtil {


  static toStringMoney(double money) {
       String moneyNew = money.toStringAsFixed(2);
       return moneyNew.replaceAll(".00", "");
  }

}