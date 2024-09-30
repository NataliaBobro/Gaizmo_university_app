import 'package:cached_network_image/cached_network_image.dart';
import 'package:european_university_app/app/domain/models/meta.dart';
import 'package:european_university_app/app/domain/models/shop.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:european_university_app/app/ui/widgets/app_field.dart';
import 'package:european_university_app/app/ui/widgets/auth_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../resources/resources.dart';
import '../../../domain/states/student/student_shop_state.dart';
import '../../theme/app_colors.dart';
import '../../theme/text_styles.dart';
import '../../utils/show_message.dart';
import '../../utils/url_launch.dart';
import '../center_header.dart';
import '../select_bottom_sheet_input.dart';

class ConfirmOrder extends StatefulWidget {
  const ConfirmOrder({
    super.key,
    required this.product
  });

  final Products product;

  @override
  State<ConfirmOrder> createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {
  bool isConfirm = false;
  TextEditingController name = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController post = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController postLocation = TextEditingController();
  TextEditingController comment = TextEditingController();
  final MaskedTextController phone = MaskedTextController(
      mask: '+00 (000) 000 00 00'
  );
  Map<String, dynamic>? selectPayment;
  List<Map<String, dynamic>> listPayment = [
    {
      "id": 'money',
      "name": getConstant('Money')
    },{
      "id": 'etm',
      "name": getConstant('EU')
    },
  ];

  ValidateError? validateError;

  @override
  void initState() {
    selectPayment = listPayment.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<StudentShopState>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ColoredBox(
            color: const Color(0xFFF0F3F6),
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  height: 55,
                ),
                CenterHeader(
                    title: getConstant('confirm_order')
                ),
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ListView(
                            physics: const ClampingScrollPhysics(),
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    Text(
                                      getConstant('client_info'),
                                      style: TextStyles.s14w500.copyWith(
                                          color: const Color(0xFF242424)
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    AppField(
                                      label: '${getConstant('name')} *',
                                      controller: name,
                                      error: validateError?.errors.name?.first,
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    AppField(
                                      label: '${getConstant('last_name')} *',
                                      controller: lastName,
                                      error: validateError?.errors.lastNameErrors?.first,
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    AppField(
                                      label: getConstant('Phone_number'),
                                      controller: phone,
                                      error: validateError?.errors.phoneErrors?.first,
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    AppField(
                                      label: '${getConstant('post')} *',
                                      controller: post,
                                      error: validateError?.errors.lastNameErrors?.first,
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    Text(
                                      getConstant('delivery'),
                                      style: TextStyles.s14w500.copyWith(
                                          color: const Color(0xFF242424)
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    AppField(
                                      label: getConstant('city'),
                                      controller: city,
                                      error: validateError?.errors.city?.first,
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    AppField(
                                      label: getConstant('post_location'),
                                      controller: postLocation,
                                      error: validateError?.errors.city?.first,
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    Text(
                                      getConstant('payment'),
                                      style: TextStyles.s14w500.copyWith(
                                          color: const Color(0xFF242424)
                                      ),
                                    ),
                                    SelectBottomSheetInput(
                                      label: "",
                                      placeholder: getConstant('payment'),
                                      labelModal: getConstant('payment'),
                                      selected: selectPayment,
                                      items: listPayment,
                                      onSelect: (value) {
                                        selectPayment = value;
                                        setState(() {});
                                      },
                                      horizontalPadding: 0,
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    AppField(
                                      label: getConstant('comment_order'),
                                      controller: comment,
                                      error: validateError?.errors.city?.first,
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 20
                                ),
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                    color: Colors.white
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Text(
                                      getConstant('you_order'),
                                      style: TextStyles.s16w600.copyWith(
                                          color: const Color(0xFF242424)
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    SizedBox(
                                      height: 80,
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: widget.product.image != null ? CachedNetworkImage(
                                                imageUrl: '${widget.product.image}',
                                                width: 90,
                                                height: 80,
                                                errorWidget: (context, error, stackTrace) =>
                                                const SizedBox.shrink(),
                                                fit: BoxFit.cover,
                                                progressIndicatorBuilder: (context, error, stackTrace) =>
                                                const CupertinoActivityIndicator()
                                            ) : const SizedBox(
                                              width: double.infinity,
                                              height: 0,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  '${widget.product.name}',
                                                  style: TextStyles.s14w500.copyWith(
                                                      color: const Color(0xFF242424)
                                                  ),
                                                ),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${widget.product.desc}',
                                                      style: TextStyles.s12w400.copyWith(
                                                          color: AppColors.grey90,
                                                          overflow: TextOverflow.ellipsis
                                                      ),
                                                      maxLines: 2,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        SvgPicture.asset(
                                                          Svgs.cache,
                                                          width: 24,
                                                        ),
                                                        const SizedBox(
                                                          width: 6,
                                                        ),
                                                        Text(
                                                          '${widget.product.priceEtm ?? ''} EU / ${widget.product.priceMoney ?? ''} UAH',
                                                          style: TextStyles.s12w400.copyWith(
                                                              color: AppColors.fNeutral800,
                                                              overflow: TextOverflow.ellipsis
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          getConstant('total'),
                                          style: TextStyles.s16w600.copyWith(
                                              color: const Color(0xFF242424)
                                          ),
                                        ),
                                        Text(
                                          selectPayment?['id'] == 'money' ? '${widget.product.priceMoney} UAH' : '${widget.product.priceEtm} EU',
                                          style: TextStyles.s16w600.copyWith(
                                              color: AppColors.appButton
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            getConstant('post_locale_info'),
                                            style: TextStyles.s16w600.copyWith(
                                                color: const Color(0xFF242424)
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: Text(
                                            getConstant('tarif'),
                                            style: TextStyles.s16w600.copyWith(
                                                color: const Color(0xFF242424)
                                            ),
                                            textAlign: TextAlign.end,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    CupertinoButton(
                                        padding: EdgeInsets.zero,
                                        minSize: 0.0,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 12,
                                              height: 12,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1,
                                                      color: const Color(0xFF848484)
                                                  ),
                                                  color: isConfirm ? const Color(0xFF848484) : null
                                              ),
                                              child: isConfirm ? const Icon(
                                                Icons.check,
                                                size: 10,
                                                color: Colors.white,
                                              ) : null,
                                            ),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            Container(
                                              constraints: const BoxConstraints(
                                                  maxWidth: 270
                                              ),
                                              child: RichText(
                                                text: TextSpan(
                                                    text: '${getConstant('i_confirm_order')} ',
                                                    style: TextStyles.s14w500.copyWith(
                                                        color: AppColors.appTitle,
                                                        letterSpacing: 0.0
                                                    ),
                                                    children: [
                                                      WidgetSpan(
                                                          child: CupertinoButton(
                                                            onPressed: () {
                                                              launchUrlParse('https://european-university.etmcrm.com.ua/privacy');
                                                            },
                                                            padding: EdgeInsets.zero,
                                                            minSize: 0.0,
                                                            child: Text(
                                                              getConstant('privacy_policy'),
                                                              style: TextStyles.s14w500.copyWith(
                                                                  color: AppColors.appButton,
                                                                  letterSpacing: 0.0
                                                              ),
                                                            ),
                                                          )
                                                      ),
                                                      TextSpan(
                                                        text: ', ${getConstant('terms_of_service')}, ${getConstant('and_community_guidlines')}',
                                                        style: TextStyles.s14w500.copyWith(
                                                            color: AppColors.appTitle,
                                                            letterSpacing: 0.0
                                                        ),
                                                      )
                                                    ]
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            isConfirm = !isConfirm;
                                          });
                                        }
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    AppButton(
                                      disabled: !isConfirm,
                                      horizontalPadding: 0,
                                        title: getConstant('check_order_confirm'),
                                        onPressed: () {
                                          if(name.text.isEmpty || lastName.text.isEmpty || post.text.isEmpty) {
                                            showMessage(getConstant('error_field'));
                                            return;
                                          }
                                            state.payProduct(
                                                widget.product,
                                                OrdersProduct(
                                                  clientLastName: lastName.text,
                                                  clientEmail: post.text,
                                                  clientPhone: phone.text,
                                                  clientName: name.text,
                                                  deliveryCity: city.text,
                                                  deliveryLocation: postLocation.text,
                                                  paymentType: selectPayment!['id'],
                                                  comment: comment.text
                                                )
                                            ).whenComplete(() {
                                              Navigator.pop(context);
                                            });
                                        }
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                )
              ],
            ),
          )
      ),
    );
  }
}
