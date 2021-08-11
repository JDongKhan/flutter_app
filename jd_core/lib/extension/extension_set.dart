import '../utils/jd_validator_utils.dart';

extension ExtensionSet on Set {
  /// Checks if length of set is LOWER than maxLength.
  bool isLengthLowerThan(int maxLength) =>
      ValidatorUtils.isLengthLowerThan(this, maxLength);

  /// Checks if length of set is LOWER OR EQUAL to maxLength.
  bool isLengthLowerOrEqual(int maxLength) =>
      ValidatorUtils.isLengthLowerOrEqual(this, maxLength);

  /// Checks if length of set is GREATER than maxLength.
  bool isLengthGreaterThan(int maxLength) =>
      ValidatorUtils.isLengthGreaterThan(this, maxLength);

  /// Checks if length of set is GREATER OR EQUAL to maxLength.
  bool isLengthGreaterOrEqual(int maxLength) =>
      ValidatorUtils.isLengthGreaterOrEqual(this, maxLength);

  /// Checks if length of set is EQUAL than maxLength.
  bool isLengthEqualTo(int maxLength) =>
      ValidatorUtils.isLengthEqualTo(this, maxLength);

  /// Checks if length of set is BETWEEN minLength to maxLength.
  bool isLengthBetween(int minLength, int maxLength) =>
      ValidatorUtils.isLengthBetween(this, minLength, maxLength);
}
