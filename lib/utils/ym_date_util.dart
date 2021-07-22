/// 日期时间工具类
class YmDateUtil {
  /// 字符串转换DateTime
  /// 2019-06-20 15:32:41
  static DateTime formatDateTime(String value) {
    return DateTime.parse(value);
  }

  /// DateTime转换字符串
  /// 2019-06-20 15:32:41
  static String formatString(DateTime dateTime) {
    int year = dateTime.year;
    int month = dateTime.month;
    int day = dateTime.day;
    int hour = dateTime.hour;
    int minute = dateTime.minute;
    int second = dateTime.second;
    return format2Number(year.toString()) +
        "-" +
        format2Number(month.toString()) +
        "-" +
        format2Number(day.toString()) +
        " " +
        format2Number(hour.toString()) +
        ":" +
        format2Number(minute.toString()) +
        ":" +
        format2Number(second.toString());
  }

  /// 当前日期时间DateTime
  static DateTime currentDateTime() {
    return DateTime.now();
  }

  /// 当前日期字符串
  /// 2021-06-20
  static String currentDateString() {
    DateTime dateTime = DateTime.now();
    int year = dateTime.year;
    int month = dateTime.month;
    int day = dateTime.day;
    return format2Number(year.toString()) + "-" + format2Number(month.toString()) + "-" + format2Number(day.toString());
  }

  /// 当前日期时间字符串
  /// 2021-06-20 15:32:41
  static String currentDateTimeString() {
    DateTime dateTime = DateTime.now();
    int year = dateTime.year;
    int month = dateTime.month;
    int day = dateTime.day;
    int hour = dateTime.hour;
    int minute = dateTime.minute;
    int second = dateTime.second;
    return format2Number(year.toString()) +
        "-" +
        format2Number(month.toString()) +
        "-" +
        format2Number(day.toString()) +
        " " +
        format2Number(hour.toString()) +
        ":" +
        format2Number(minute.toString()) +
        ":" +
        format2Number(second.toString());
  }

  /// 当前日期时间毫秒数
  static int currentMilliseconds() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  /// 日期时间毫秒数转DateTime
  static DateTime fromMilliseconds(int milliseconds) {
    return DateTime.fromMillisecondsSinceEpoch(milliseconds);
  }

  /// 计算月份所对应天数
  static int getDateCount(int year, int month) {
    switch (month) {
      case 1:
      case 3:
      case 5:
      case 7:
      case 8:
      case 10:
      case 12:
        return 31;
      case 2:
        if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
          return 29;
        }
        return 28;
    }
    return 30;
  }

  /// 长度少于两位补0
  static String format2Number(String value) {
    if (value.length == 1) {
      return "0" + value;
    } else {
      return value;
    }
  }
}
