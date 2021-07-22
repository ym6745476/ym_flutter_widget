/// 字符串工具类
class YmStringUtil {
  /// int为空
  static bool intEmpty(int? value) {
    return value == null;
  }

  /// int不为空
  static bool intNotEmpty(int? value) {
    return value != null;
  }

  /// 字符串为空
  static bool strEmpty(String? value) {
    if (value == null) return true;
    return value.trim().isEmpty;
  }

  /// 字符串不为空
  static bool strNotEmpty(String? value) {
    if (value == null) return false;
    return value.trim().isNotEmpty;
  }

  /// Map为空
  static bool mapEmpty(Map? value) {
    if (value == null) return true;
    return value.isEmpty;
  }

  /// Map不为空
  static bool mapNotEmpty(Map? value) {
    if (value == null) return false;
    return value.isNotEmpty;
  }

  /// List为空
  static bool listEmpty(List? list) {
    if (list == null) return true;
    if (list.length == 0) return true;
    return false;
  }

  /// List不为空
  static bool listNotEmpty(List? list) {
    if (list == null) return false;
    if (list.length == 0) return false;
    return true;
  }

  /// 去掉金额的.00
  static String toStringMoney(double money) {
    String moneyNew = money.toStringAsFixed(2);
    return moneyNew.replaceAll(".00", "");
  }

  /// 每3位加逗号
  static String formatMoney(double money, {separate: 3}) {
    String str = money.toStringAsFixed(2);
    List<String> sub = str.split('.');
    List val = List.from(sub[0].split(''));
    //处理分割符
    for (int index = 0, i = val.length - 1; i >= 0; index++, i--) {
      // 除以三没有余数、不等于零并且不等于1 就加个逗号
      if (index % separate == 0 && index != 0) {
        val[i] = val[i] + ',';
      }
    }
    return '${val.join('')}.${sub[1]}';
  }

  /// 判断是否为手机号
  static isMobile(String mobile) {
    RegExp exp = RegExp(r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
    return exp.hasMatch(mobile);
  }

  /// 将姓名变为*号
  static String formatStarName(String name) {
    String newStr;
    if (name.length == 2) {
      newStr = "*" + name.substring(1, 2);
    } else if (name.length == 3) {
      newStr = name.substring(0, 1) + "*" + name.substring(2);
    } else if (name.length == 4) {
      newStr = name.substring(0, 2) + "*" + name.substring(3);
    } else if (name.length > 4) {
      newStr = name.substring(0, 2) + "**" + name.substring(4);
    } else {
      newStr = name;
    }
    return newStr;
  }
}
