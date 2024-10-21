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
      branch: (json['branch'] as List<dynamic>?)
          ?.map((e) => UserData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MetaAppDataToJson(MetaAppData instance) =>
    <String, dynamic>{
      'genders': instance.genders,
      'language': instance.language,
      'category_school': instance.categorySchool,
      'teacher': instance.teacher,
      'currency': instance.currency,
      'branch': instance.branch,
    };

Gender _$GenderFromJson(Map<String, dynamic> json) => Gender(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      define: json['define'] as String,
    );

Map<String, dynamic> _$GenderToJson(Gender instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'define': instance.define,
    };

Language _$LanguageFromJson(Map<String, dynamic> json) => Language(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$LanguageToJson(Language instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

Currency _$CurrencyFromJson(Map<String, dynamic> json) => Currency(
      id: (json['id'] as num).toInt(),
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
      id: (json['id'] as num).toInt(),
      define: json['define'] as String,
      translate: json['translate'] == null
          ? null
          : Translate.fromJson(json['translate'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SchoolCategoryToJson(SchoolCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'define': instance.define,
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
      schoolCategory: (json['school_category'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      country:
          (json['country'] as List<dynamic>?)?.map((e) => e as String).toList(),
      city: (json['city'] as List<dynamic>?)?.map((e) => e as String).toList(),
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
      oldPassword: (json['old_password'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      confirmPassword: (json['confirm_password'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      newPassword: (json['new_password'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      fullNameErrors: (json['full_name'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      about:
          (json['about'] as List<dynamic>?)?.map((e) => e as String).toList(),
      siteAddress: (json['site_address'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      desc: (json['desc'] as List<dynamic>?)?.map((e) => e as String).toList(),
    )
      ..privacyErrors =
          (json['privacy'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..sheetId =
          (json['sheetId'] as List<dynamic>?)?.map((e) => e as String).toList();

Map<String, dynamic> _$ErrorsToJson(Errors instance) => <String, dynamic>{
      'user_type': instance.userTypeErrors,
      'surname': instance.surnameErrors,
      'first_name': instance.firstNameErrors,
      'last_name': instance.lastNameErrors,
      'full_name': instance.fullNameErrors,
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
      'site_address': instance.siteAddress,
      'country': instance.country,
      'city': instance.city,
      'school_name': instance.schoolName,
      'street': instance.street,
      'house': instance.house,
      'name': instance.name,
      'sheetId': instance.sheetId,
      'color': instance.color,
      'service': instance.service,
      'school_class': instance.schoolClass,
      'start': instance.start,
      'start_lesson': instance.startLesson,
      'end': instance.end,
      'day': instance.day,
      'old_password': instance.oldPassword,
      'confirm_password': instance.confirmPassword,
      'new_password': instance.newPassword,
      'about': instance.about,
      'desc': instance.desc,
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

DocumentTypeList _$DocumentTypeListFromJson(Map<String, dynamic> json) =>
    DocumentTypeList(
      success: json['success'] as bool,
      type: (json['type'] as List<dynamic>)
          .map((e) => DocumentType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DocumentTypeListToJson(DocumentTypeList instance) =>
    <String, dynamic>{
      'success': instance.success,
      'type': instance.type,
    };

DocumentType _$DocumentTypeFromJson(Map<String, dynamic> json) => DocumentType(
      id: (json['id'] as num).toInt(),
      define: json['define'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$DocumentTypeToJson(DocumentType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'define': instance.define,
      'name': instance.name,
    };

FilterDataString _$FilterDataStringFromJson(Map<String, dynamic> json) =>
    FilterDataString(
      success: json['success'] as bool,
      city: (json['city'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$FilterDataStringToJson(FilterDataString instance) =>
    <String, dynamic>{
      'success': instance.success,
      'city': instance.city,
    };

ConstantsList _$ConstantsListFromJson(Map<String, dynamic> json) =>
    ConstantsList(
      data: (json['data'] as List<dynamic>)
          .map((e) => Constant.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ConstantsListToJson(ConstantsList instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

Constant _$ConstantFromJson(Map<String, dynamic> json) => Constant(
      constant: json['constant'] as String,
      value: json['value'] as String,
    );

Map<String, dynamic> _$ConstantToJson(Constant instance) => <String, dynamic>{
      'constant': instance.constant,
      'value': instance.value,
    };

PaymentSettings _$PaymentSettingsFromJson(Map<String, dynamic> json) =>
    PaymentSettings(
      data: (json['data'] as List<dynamic>)
          .map((e) => PaymentSettingsItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PaymentSettingsToJson(PaymentSettings instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

PaymentSettingsItem _$PaymentSettingsItemFromJson(Map<String, dynamic> json) =>
    PaymentSettingsItem(
      userId: (json['user_id'] as num).toInt(),
      type: json['type'] as String,
      credentials: json['credentials'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$PaymentSettingsItemToJson(
        PaymentSettingsItem instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'type': instance.type,
      'credentials': instance.credentials,
    };

CredWithProductOrder _$CredWithProductOrderFromJson(
        Map<String, dynamic> json) =>
    CredWithProductOrder(
      success: json['success'] as bool,
      orderReference: json['order_reference'] as String,
      cred: json['cred'] == null
          ? null
          : LiqPayCred.fromJson(json['cred'] as Map<String, dynamic>),
      product: Products.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CredWithProductOrderToJson(
        CredWithProductOrder instance) =>
    <String, dynamic>{
      'success': instance.success,
      'order_reference': instance.orderReference,
      'cred': instance.cred,
      'product': instance.product,
    };

LiqPayCred _$LiqPayCredFromJson(Map<String, dynamic> json) => LiqPayCred(
      public: json['public'] as String,
      secret: json['secret'] as String,
    );

Map<String, dynamic> _$LiqPayCredToJson(LiqPayCred instance) =>
    <String, dynamic>{
      'public': instance.public,
      'secret': instance.secret,
    };

BalanceListData _$BalanceListDataFromJson(Map<String, dynamic> json) =>
    BalanceListData(
      data: (json['data'] as List<dynamic>)
          .map((e) => BalanceItemData.fromJson(e as Map<String, dynamic>))
          .toList(),
      success: json['success'] as bool,
    );

Map<String, dynamic> _$BalanceListDataToJson(BalanceListData instance) =>
    <String, dynamic>{
      'data': instance.data,
      'success': instance.success,
    };

BalanceItemData _$BalanceItemDataFromJson(Map<String, dynamic> json) =>
    BalanceItemData(
      value: json['value'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$BalanceItemDataToJson(BalanceItemData instance) =>
    <String, dynamic>{
      'value': instance.value,
      'name': instance.name,
    };
