// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Test.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Test _$TestFromJson(Map<String, dynamic> json) {
  return Test()
    ..id = json['id'] as int
    ..title = json['title'] as String
    ..content = json['content'] as String
    ..tags = json['tags'] as String
    ..userTypeEnum =
        _$enumDecodeNullable(_$UserTypeEnumEnumMap, json['userTypeEnum'])
    ..userType = json['user_type'] as String
    ..user = json['user'] as String
    ..published = json['published'] as bool;
}

Map<String, dynamic> _$TestToJson(Test instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'tags': instance.tags,
      'userTypeEnum': _$UserTypeEnumEnumMap[instance.userTypeEnum],
      'user_type': instance.userType,
      'user': instance.user,
      'published': instance.published,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$UserTypeEnumEnumMap = {
  UserTypeEnum.Admin: 'Admin',
  UserTypeEnum.AppUser: 'AppUser',
  UserTypeEnum.Normal: 'Normal',
};
