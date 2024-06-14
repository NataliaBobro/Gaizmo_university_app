import 'package:european_university_app/app/domain/states/payment_state.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:european_university_app/app/ui/widgets/app_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../resources/resources.dart';
import '../../theme/text_styles.dart';
import '../auth_button.dart';
import '../center_header.dart';


class LiqPaySettings extends StatefulWidget {
  const LiqPaySettings({super.key});

  @override
  State<LiqPaySettings> createState() => _LiqPaySettingsState();
}

class _LiqPaySettingsState extends State<LiqPaySettings> {
  final TextEditingController _public = TextEditingController();
  final TextEditingController _secret = TextEditingController();

  @override
  void initState() {
    final read = context.read<PaymentState>();
    final wayForPay = read.paymentSettings?.data.where((element) => element.type == 'liqpay');

    if((wayForPay?.length ?? 0) > 0){
      _public.text = wayForPay?.first.credentials['public'];
      _secret.text = wayForPay?.first.credentials['secret'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PaymentState>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ColoredBox(
            color: const Color(0xFFF0F3F6),
            child: Column(
              children: [
                CenterHeader(
                    title: getConstant('LiqPay')
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                        vertical: 25,
                        horizontal: 24
                    ),
                    physics: const ClampingScrollPhysics(),
                    children: [
                      AppField(
                        label: 'Public',
                        controller: _public,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      AppField(
                        label: 'Secret',
                        controller: _secret,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: AppButton(
                      title: getConstant('SAVE_CHANGES'),
                      onPressed: () {
                        state.checkPayCredStatusConnectStatus(
                            _public.text,
                            _secret.text
                        );
                      }
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}


class LiqPayPreview extends StatefulWidget {
  const LiqPayPreview({super.key});

  @override
  State<LiqPayPreview> createState() => _LiqPayPreviewState();
}

class _LiqPayPreviewState extends State<LiqPayPreview> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<PaymentState>();
    final read = context.read<PaymentState>();
    final liqPay = state.paymentSettings?.data.where((element) => element.type == 'liqpay');

    return Container(
      margin: const EdgeInsets.only(
          bottom: 16
      ),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        minSize: 0.0,
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider.value(
                value: read,
                child: const LiqPaySettings(),
              ),
            ),
          ).whenComplete(() {
            read.fetchPaymentSettings();
          });
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16)
          ),
          child: Row(
            children: [
              SizedBox(
                width: 100,
                height: 80,
                child: Image.asset(
                  Images.liqPay,
                  width: double.infinity,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if((liqPay?.length ?? 0) == 0) ...[
                      Text(
                        getConstant('Not_connected'),
                        style: TextStyles.s14w400.copyWith(
                            color: Colors.grey
                        ),
                      )
                    ] else ...[
                      RichText(
                        text: TextSpan(
                          text: 'Public:',
                          children: [
                            TextSpan(
                              text: ' ${liqPay?.first.credentials['public']}',
                              style: TextStyles.s11w400.copyWith(
                                  color: Colors.grey
                              ),
                            )
                          ],
                          style: TextStyles.s12w600.copyWith(
                              color: Colors.grey
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Private:',
                          children: [
                            TextSpan(
                              text: ' ${'*' * (liqPay?.first.credentials['secret'].toString().length ?? 0)}',
                              style: TextStyles.s11w400.copyWith(
                                  color: Colors.grey
                              ),
                            )
                          ],
                          style: TextStyles.s12w600.copyWith(
                              color: Colors.grey
                          ),
                        ),
                      ),
                    ]
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
