// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
      status: json['status'] as bool,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };

MetaAppData _$MetaAppDataFromJson(Map<String, dynamic> json) => MetaAppData(
      genders: (json['genders'] as List<dynamic>?)
          ?.map((e) => Gender.fromJson(e as Map<String, dynamic>))
          .toList(),
      language: (json['language'] as List<dynamic>?)
          ?.map((e) => Language.fromJson(e as Map<String, dynamic>))
          .toList(),
      categorySchool: (json['category_school'] as List<dynamic>?)
          ?.map((e) => SchoolCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
      teacher: (json['teacher'] as List<dynamic>?)
          ?.map((e) => UserData.fromJson(e as Map<String, dynamic>))
          .toList(),
      currency: (json['currency'] as List<dynamic>?)
          ?.map((e) => Currency.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MetaAppDataToJson(MetaAppData instance) =>
    <String, dynamic>{
      'genders': instance.genders,
      'language': instance.language,
      'category_school': instance.categorySchool,
      'teacher': instance.teacher,
      'currency': instance.currency,
    };

Gender _$GenderFromJson(Map<String, dynamic> json) => Gender(
      id: json['id'] as int,
      name: json['name'] as String,
      define: json['define'] as String,
    );

Map<String, dynamic> _$GenderToJson(Gender instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'define': instance.define,
    };

Language _$LanguageFromJson(Map<String, dynamic> json) => Language(
      id: json['id'] as int,
      name: json['name'] as String,
    );

Map<String, dynamic> _$LanguageToJson(Language instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

Currency _$CurrencyFromJson(Map<String, dynamic> json) => Currency(
      id: json['id'] as int,
      name: json['name'] as String,
      symbol: json['symbol'] as String?,
    );

Map<String, dynamic> _$CurrencyToJson(Currency instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'symbol': instance.symbol,
    };

SchoolCategory _$SchoolCategoryFromJson(Map<String, dynamic> json) =>
    SchoolCategory(
      id: json['id'] as int,
      translate: json['translate'] == null
          ? null
          : Translate.fromJson(json['translate'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SchoolCategoryToJson(SchoolCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'translate': instance.translate,
    };

Translate _$TranslateFromJson(Map<String, dynamic> json) => Translate(
      value: json['value'] as String,
    );

Map<String, dynamic> _$TranslateToJson(Translate instance) => <String, dynamic>{
      'value': instance.value,
    };

ValidateError _$ValidateErrorFromJson(Map<String, dynamic> json) =>
    ValidateError(
      message: json['message'] as String,
      errors: Errors.fromJson(json['errors'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ValidateErrorToJson(ValidateError instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
    };

Errors _$ErrorsFromJson(Map<String, dynamic> json) => Errors(
      userTypeErrors: (json['user_type'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      firstNameErrors: (json['first_name'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      lastNameErrors: (json['last_name'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      surnameErrors:
          (json['surname'] as List<dynamic>?)?.map((e) => e as String).toList(),
      genderErrors:
          (json['gender'] as List<dynamic>?)?.map((e) => e as String).toList(),
      passwordErrors: (json['password'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      dateBirthErrors: (json['date_birth'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      phoneErrors:
          (json['phone'] as List<dynamic>?)?.map((e) => e as String).toList(),
      emailErrors:
          (json['email'] as List<dynamic>?)?.map((e) => e as String).toList(),
      languageIdErrors: (json['language_id'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      paymentNumberErrors: (json['payment_number'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      paymentDateErrors: (json['payment_date'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      paymentCodeErrors: (json['payment_code'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      schoolCategory: json['school_category'] as String?,
      country: json['country'] as String?,
      city: json['city'] as String?,
      schoolName: (json['school_name'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      street:
          (json['street'] as List<dynamic>?)?.map((e) => e as String).toList(),
      house:
          (json['house'] as List<dynamic>?)?.map((e) => e as String).toList(),
      name: (json['name'] as List<dynamic>?)?.map((e) => e as String).toList(),
      color:
          (json['color'] as List<dynamic>?)?.map((e) => e as String).toList(),
      service:
          (json['service'] as List<dynamic>?)?.map((e) => e as String).toList(),
      schoolClass: (json['school_class'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      start:
          (json['start'] as List<dynamic>?)?.map((e) => e as String).toList(),
      end: (json['end'] as List<dynamic>?)?.map((e) => e as String).toList(),
      day: (json['day'] as List<dynamic>?)?.map((e) => e as String).toList(),
      startLesson: (json['start_lesson'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    )..privacyErrors =
        (json['privacy'] as List<dynamic>?)?.map((e) => e as String).toList();

Map<String, dynamic> _$ErrorsToJson(Errors instance) => <String, dynamic>{
      'user_type': instance.userTypeErrors,
      'surname': instance.surnameErrors,
      'first_name': instance.firstNameErrors,
      'last_name': instance.lastNameErrors,
      'gender': instance.genderErrors,
      'password': instance.passwordErrors,
      'date_birth': instance.dateBirthErrors,
      'phone': instance.phoneErrors,
      'email': instance.emailErrors,
      'language_id': instance.languageIdErrors,
      'privacy': instance.privacyErrors,
      'payment_number': instance.paymentNumberErrors,
      'payment_date': instance.paymentDateErrors,
      'payment_code': instance.paymentCodeErrors,
      'school_category': instance.schoolCategory,
      'country': instance.country,
      'city': instance.city,
      'school_name': instance.schoolName,
      'street': instance.street,
      'house': instance.house,
      'name': instance.name,
      'color': instance.color,
      'service': instance.service,
      'school_class': instance.schoolClass,
      'start': instance.start,
      'start_lesson': instance.startLesson,
      'end': instance.end,
      'day': instance.day,
    };

CountryList _$CountryListFromJson(Map<String, dynamic> json) => CountryList(
      value: (json['value'] as List<dynamic>)
          .map((e) => Country.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CountryListToJson(CountryList instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
      name: json['name'] as String?,
    );

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'name': instance.name,
    };
