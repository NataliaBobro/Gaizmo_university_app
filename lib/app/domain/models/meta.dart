import 'package:etm_crm/app/domain/models/user.dart';
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

  MetaAppData({
    required this.genders,
    required this.language,
    required this.categorySchool,
    required this.teacher,
    required this.currency,
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
  Translate? translate;

  SchoolCategory({
    required this.id,
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
  String? schoolCategory;

  @JsonKey(name: 'country')
  String? country;

  @JsonKey(name: 'city')
  String? city;

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

