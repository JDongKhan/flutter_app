import 'package:json_annotation/json_annotation.dart';


part 'Test.g.dart';

@JsonSerializable()
class Test {
      Test();

  int id;
  String title;
  String content;
  String tags;
  UserTypeEnum 
    get userTypeEnum => _userTypeEnumFromString(userType);
    set userTypeEnum(UserTypeEnum value) => userType = _stringFromUserTypeEnum(value);
  @JsonKey(name: 'user_type') String userType;
  String user;
  bool published;

  factory Test.fromJson(Map<String,dynamic> json) => _$TestFromJson(json);
  Map<String, dynamic> toJson() => _$TestToJson(this);

  UserTypeEnum _userTypeEnumFromString(String input) {
    return UserTypeEnum.values.firstWhere(
      (e) => _stringFromUserTypeEnum(e) == input.toLowerCase(),
      orElse: () => null,
    );
  }
  
  String _stringFromUserTypeEnum(UserTypeEnum input) {
    return input.toString().substring(input.toString().indexOf('.') + 1).toLowerCase();
  }}

enum UserTypeEnum { Admin, AppUser, Normal }
