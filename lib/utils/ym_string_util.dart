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

  /// 校验身份证合法性
  static String verifyIdCard(String idCard) {
    const Map city = {
      11: "北京",
      12: "天津",
      13: "河北",
      14: "山西",
      15: "内蒙古",
      21: "辽宁",
      22: "吉林",
      23: "黑龙江 ",
      31: "上海",
      32: "江苏",
      33: "浙江",
      34: "安徽",
      35: "福建",
      36: "江西",
      37: "山东",
      41: "河南",
      42: "湖北 ",
      43: "湖南",
      44: "广东",
      45: "广西",
      46: "海南",
      50: "重庆",
      51: "四川",
      52: "贵州",
      53: "云南",
      54: "西藏 ",
      61: "陕西",
      62: "甘肃",
      63: "青海",
      64: "宁夏",
      65: "新疆",
      71: "台湾",
      81: "香港",
      82: "澳门",
      91: "国外 "
    };
    bool pass = true;

    RegExp cardReg = RegExp(r'^\d{6}(18|19|20)?\d{2}(0[1-9]|1[012])(0[1-9]|[12]\d|3[01])\d{3}(\d|X)$');
    if (idCard.isEmpty || !cardReg.hasMatch(idCard)) {
      pass = false;
      return "身份证号格式错误";
    }
    if (city[int.parse(idCard.substring(0, 2))] == null) {
      pass = false;
      return "地址编码错误";
    }

    /// 18位身份证需要验证最后一位校验位，15位不检测了，现在也没15位的了
    if (idCard.length == 18) {
      List numList = idCard.split('');

      /// ∑(ai×Wi)(mod 11)
      /// 加权因子
      List factor = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2];

      /// 校验位
      List parity = [1, 0, 'X', 9, 8, 7, 6, 5, 4, 3, 2];
      int sum = 0;
      int ai = 0;
      int wi = 0;
      for (var i = 0; i < 17; i++) {
        ai = int.parse(numList[i]);
        wi = factor[i];
        sum += ai * wi;
      }
      var last = parity[sum % 11];
      if (parity[sum % 11].toString() != numList[17]) {
        pass = false;
        return "校验位错误";
      }
    } else {
      pass = false;
      return "身份证号不是18位";
    }
    return "";
  }
}
