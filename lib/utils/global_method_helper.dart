class GlobalMethodHelper {
  static bool isEmpty(text) {
    if (text == "" || text == null || text == "null") {
      return true;
    } else {
      return false;
    }
  }

  static bool isEmptyList(List<dynamic>? list) {
    if (list == null) {
      return true;
    } else if (list.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  /*static String formatter(String number) {
    // TODO: implement format
    final format = NumberFormat("#,##0.###", "en-US");
    int newNumber;
    String newValue = "0";
    try {
      newNumber = int.parse(GlobalMethodHelper.formatNumberToString(number));
      newValue = format.format(newNumber);
    } catch(e){
      print(e);
    }

    return newValue;
  }*/

  static String formatNumberToString(String text, {String defaultValue = "0"}) {
    if (GlobalMethodHelper.isEmpty(text)) {
      return defaultValue;
    }
    return int.parse(double.parse(text).toStringAsFixed(0)).toString();
  }
}
