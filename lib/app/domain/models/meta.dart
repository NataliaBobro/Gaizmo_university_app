import 'package:european_university_app/app/domain/models/shop.dart';
import 'package:european_university_app/app/domain/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meta.g.dart';

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class Meta {
  bool status;
  String? message;

  Meta({
    required this.status,
    required this.message,
  });

  Map<String, dynamic> toJson() => _$MetaToJson(this);

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
}

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class MetaAppData {
  List<Gender>? genders;
  List<Language>? language;
  List<SchoolCategory>? categorySchool;
  List<UserData>? teacher;
  List<Currency>? currency;
  List<UserData>? branch;

  MetaAppData({
    required this.genders,
    required this.language,
    required this.categorySchool,
    required this.teacher,
    required this.currency,
    this.branch,
  });

  Map<String, dynamic> toJson() => _$MetaAppDataToJson(this);

  factory MetaAppData.fromJson(Map<String, dynamic> json) => _$MetaAppDataFromJson(json);
}

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class Gender {
  int id;
  String name;
  String define;

  Gender({
    required this.id,
    required this.name,
    required this.define,
  });

  Map<String, dynamic> toJson() => _$GenderToJson(this);

  factory Gender.fromJson(Map<String, dynamic> json) => _$GenderFromJson(json);
}

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class Language {
  int id;
  String name;

  Language({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toJson() => _$LanguageToJson(this);

  factory Language.fromJson(Map<String, dynamic> json) => _$LanguageFromJson(json);
}

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class Currency {
  int id;
  String name;
  String? symbol;

  Currency({
    required this.id,
    required this.name,
    required this.symbol,
  });

  Map<String, dynamic> toJson() => _$CurrencyToJson(this);

  factory Currency.fromJson(Map<String, dynamic> json) => _$CurrencyFromJson(json);
}

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class SchoolCategory {
  int id;
  String define;
  Translate? translate;

  SchoolCategory({
    required this.id,
    required this.define,
    required this.translate,
  });

  Map<String, dynamic> toJson() => _$SchoolCategoryToJson(this);

  factory SchoolCategory.fromJson(Map<String, dynamic> json) => _$SchoolCategoryFromJson(json);
}

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class Translate {
  String value;

  Translate({
    required this.value,
  });

  Map<String, dynamic> toJson() => _$TranslateToJson(this);

  factory Translate.fromJson(Map<String, dynamic> json) => _$TranslateFromJson(json);
}


@JsonSerializable()
class ValidateError {
  String message;
  Errors errors;

  ValidateError({required this.message, required this.errors});

  factory ValidateError.fromJson(Map<String, dynamic> json) => _$ValidateErrorFromJson(json);
  Map<String, dynamic> toJson() => _$ValidateErrorToJson(this);
}

@JsonSerializable()
class Errors {
  @JsonKey(name: 'user_type')
  List<String>? userTypeErrors;

  @JsonKey(name: 'surname')
  List<String>? surnameErrors;

  @JsonKey(name: 'first_name')
  List<String>? firstNameErrors;

  @JsonKey(name: 'last_name')
  List<String>? lastNameErrors;

  @JsonKey(name: 'full_name')
  List<String>? fullNameErrors;

  @JsonKey(name: 'gender')
  List<String>? genderErrors;

  @JsonKey(name: 'password')
  List<String>? passwordErrors;

  @JsonKey(name: 'date_birth')
  List<String>? dateBirthErrors;

  @JsonKey(name: 'phone')
  List<String>? phoneErrors;

  @JsonKey(name: 'email')
  List<String>? emailErrors;

  @JsonKey(name: 'language_id')
  List<String>? languageIdErrors;

  @JsonKey(name: 'privacy')
  List<String>? privacyErrors;

  @JsonKey(name: 'payment_number')
  List<String>? paymentNumberErrors;

  @JsonKey(name: 'payment_date')
  List<String>? paymentDateErrors;

  @JsonKey(name: 'payment_code')
  List<String>? paymentCodeErrors;

  @JsonKey(name: 'school_category')
  List<String>? schoolCategory;

  @JsonKey(name: 'site_address')
  List<String>? siteAddress;

  @JsonKey(name: 'country')
  List<String>? country;

  @JsonKey(name: 'city')
  List<String>? city;

  @JsonKey(name: 'school_name')
  List<String>? schoolName;

  @JsonKey(name: 'street')
  List<String>? street;

  @JsonKey(name: 'house')
  List<String>? house;

  @JsonKey(name: 'name')
  List<String>? name;

  @JsonKey(name: 'color')
  List<String>? color;

  @JsonKey(name: 'service')
  List<String>? service;

  @JsonKey(name: 'school_class')
  List<String>? schoolClass;

  @JsonKey(name: 'start')
  List<String>? start;

  @JsonKey(name: 'start_lesson')
  List<String>? startLesson;

  @JsonKey(name: 'end')
  List<String>? end;

  @JsonKey(name: 'day')
  List<String>? day;

  @JsonKey(name: 'old_password')
  List<String>? oldPassword;

  @JsonKey(name: 'confirm_password')
  List<String>? confirmPassword;

  @JsonKey(name: 'new_password')
  List<String>? newPassword;

  @JsonKey(name: 'about')
  List<String>? about;

  Errors({
    this.userTypeErrors,
    this.firstNameErrors,
    this.lastNameErrors,
    this.surnameErrors,
    this.genderErrors,
    this.passwordErrors,
    this.dateBirthErrors,
    this.phoneErrors,
    this.emailErrors,
    this.languageIdErrors,
    this.paymentNumberErrors,
    this.paymentDateErrors,
    this.paymentCodeErrors,
    this.schoolCategory,
    this.country,
    this.city,
    this.schoolName,
    this.street,
    this.house,
    this.name,
    this.color,
    this.service,
    this.schoolClass,
    this.start,
    this.end,
    this.day,
    this.startLesson,
    this.oldPassword,
    this.confirmPassword,
    this.newPassword,
    this.fullNameErrors,
    this.about,
    this.siteAddress
  });

  factory Errors.fromJson(Map<String, dynamic> json) => _$ErrorsFromJson(json);
  Map<String, dynamic> toJson() => _$ErrorsToJson(this);
}

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class CountryList {
  List<Country> value;

  CountryList({
    required this.value,
  });

  Map<String, dynamic> toJson() => _$CountryListToJson(this);

  factory CountryList.fromJson(Map<String, dynamic> json) => _$CountryListFromJson(json);
}

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class Country {
  String? name;

  Country({
    required this.name,
  });

  Map<String, dynamic> toJson() => _$CountryToJson(this);

  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);
}

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class DocumentTypeList {
  bool success;
  List<DocumentType> type;

  DocumentTypeList({
    required this.success,
    required this.type,
  });

  Map<String, dynamic> toJson() => _$DocumentTypeListToJson(this);

  factory DocumentTypeList.fromJson(Map<String, dynamic> json) => _$DocumentTypeListFromJson(json);
}

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class DocumentType {
  int id;
  String define;
  String name;

  DocumentType({
    required this.id,
    required this.define,
    required this.name,
  });

  Map<String, dynamic> toJson() => _$DocumentTypeToJson(this);

  factory DocumentType.fromJson(Map<String, dynamic> json) => _$DocumentTypeFromJson(json);
}

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class FilterDataString {
  bool success;
  List<String> city;

  FilterDataString({
    required this.success,
    required this.city,
  });

  Map<String, dynamic> toJson() => _$FilterDataStringToJson(this);

  factory FilterDataString.fromJson(Map<String, dynamic> json) => _$FilterDataStringFromJson(json);
}

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class ConstantsList {
  List<Constant> data;

  ConstantsList({
    required this.data,
  });

  Map<String, dynamic> toJson() => _$ConstantsListToJson(this);
  factory ConstantsList.fromJson(Map<String, dynamic> json) => _$ConstantsListFromJson(json);
}

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class Constant {
  String constant;
  String value;

  Constant({
    required this.constant,
    required this.value,
  });

  Map<String, dynamic> toJson() => _$ConstantToJson(this);
  factory Constant.fromJson(Map<String, dynamic> json) => _$ConstantFromJson(json);
}

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class PaymentSettings {
  List<PaymentSettingsItem> data;

  PaymentSettings({
    required this.data,
  });

  Map<String, dynamic> toJson() => _$PaymentSettingsToJson(this);
  factory PaymentSettings.fromJson(Map<String, dynamic> json) => _$PaymentSettingsFromJson(json);
}

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class PaymentSettingsItem {
  int userId;
  String type;
  Map<String, dynamic> credentials;

  PaymentSettingsItem({
    required this.userId,
    required this.type,
    required this.credentials,
  });

  Map<String, dynamic> toJson() => _$PaymentSettingsItemToJson(this);
  factory PaymentSettingsItem.fromJson(Map<String, dynamic> json) => _$PaymentSettingsItemFromJson(json);
}


@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class CredWithProductOrder {
  bool success;
  String orderReference;
  LiqPayCred? cred;
  Products product;

  CredWithProductOrder({
    required this.success,
    required this.orderReference,
    required this.cred,
    required this.product
  });

  Map<String, dynamic> toJson() => _$CredWithProductOrderToJson(this);
  factory CredWithProductOrder.fromJson(Map<String, dynamic> json) => _$CredWithProductOrderFromJson(json);
}

@JsonSerializable(includeIfNull: true, fieldRename: FieldRename.snake)
class LiqPayCred {
  String public;
  String secret;

  LiqPayCred({
    required this.public,
    required this.secret
  });

  Map<String, dynamic> toJson() => _$LiqPayCredToJson(this);
  factory LiqPayCred.fromJson(Map<String, dynamic> json) => _$LiqPayCredFromJson(json);
}

