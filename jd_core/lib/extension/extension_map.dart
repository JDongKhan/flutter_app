import 'dart:convert';

import '../utils/jd_validator_utils.dart';

extension ExtensionMap on Map {
  /// Transform map to json
  /// 将map转化为json字符串
  String toJsonString() {
    return jsonEncode(this);
  }

  /// 将map转化为json字符串换行
  String getJsonPretty() {
    return JsonEncoder.withIndent('\t').convert(this);
  }

  /// Checks if length of map is LOWER than maxLength.
  /// 检查数据长度是否小于maxLength
  bool isLengthLowerThan(int maxLength) =>
      ValidatorUtils.isLengthLowerThan(this, maxLength);

  /// Checks if length of map is LOWER OR EQUAL to maxLength.
  bool isLengthLowerOrEqual(int maxLength) =>
      ValidatorUtils.isLengthLowerOrEqual(this, maxLength);

  /// Checks if length of map is GREATER than maxLength.
  bool isLengthGreaterThan(int maxLength) =>
      ValidatorUtils.isLengthGreaterThan(this, maxLength);

  /// Checks if length of map is GREATER OR EQUAL to maxLength.
  bool isLengthGreaterOrEqual(int maxLength) =>
      ValidatorUtils.isLengthGreaterOrEqual(this, maxLength);

  /// Checks if length of map is EQUAL than maxLength.
  bool isLengthEqualTo(int maxLength) =>
      ValidatorUtils.isLengthEqualTo(this, maxLength);

  /// Checks if length of map is BETWEEN minLength to maxLength.
  bool isLengthBetween(int minLength, int maxLength) =>
      ValidatorUtils.isLengthBetween(this, minLength, maxLength);
}
