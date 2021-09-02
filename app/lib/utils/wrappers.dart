class Re {
  /// Example
  ///   firstGroup(somestr,r'value=\s*"(.*)"')
  static String? firstGroup(String input, String pattern) {
    var regexp = new RegExp(pattern);
    return regexp.firstMatch(input)?.group(1);
  }
}
