import 'package:european_university_app/app/app.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:european_university_app/app/ui/widgets/auth_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../../resources/resources.dart';
import '../../../../constatns.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/text_styles.dart';
import '../../cupertino_modal_appbar.dart';
import '../../custom_scroll_physics.dart';
import '../../dropdown/dropdown.dart';

class ExchangeScreen extends StatelessWidget {
  const ExchangeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Payments(),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(
                horizontal: 24
            ),
            physics: const BottomBouncingScrollPhysics(),
            children: const [

            ],
          ),
        )
      ],
    );
  }
}

class Payments extends StatefulWidget {
  const Payments({super.key});

  @override
  State<Payments> createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  @override
  Widget build(BuildContext context) {
    final userData = context.watch<AppState>().userData;
    return Container(
      padding: const EdgeInsets.only(
        top: 24
      ),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 28,
              right: 24,
              left: 24
            ),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  '${getConstant('Current_debt')}: ${userData?.balance ?? 0} UAH',
                  style: TextStyles.s14w600.copyWith(
                      color: const Color(0xFF242424)
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                AppButton(
                  horizontalPadding: 24,
                  title: getConstant('PAY'),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            maintainState: true,
                            fullscreenDialog: true,
                            builder: (context) => Scaffold(
                              body: SafeArea(
                                  child: WebView(
                                    initialUrl: privatBankPay,
                                    javascriptMode: JavascriptMode.unrestricted,
                                    navigationDelegate: (NavigationRequest request) {
                                      return NavigationDecision.navigate;
                                    },
                                  )
                              ),
                            )
                        )
                    );
                  },
                )
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 55,
                  height: 55,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: AppColors.appButton,
                      borderRadius: BorderRadius.circular(100)
                  ),
                  child: SvgPicture.asset(
                      Svgs.payCache
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PayModal extends StatefulWidget {
  const PayModal({super.key});

  @override
  State<PayModal> createState() => _PayModalState();
}

class _PayModalState extends State<PayModal> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizerUtil.height * .922,
      child:  Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CustomCupertinoModalAppBar(
            title: getConstant('PAY'),
            isShareIconExist: false,
          ),
          Expanded(
            child: ListView(
              physics: const BottomBouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              children: [
                const SizedBox(
                  height: 24,
                ),
                DropdownInput(
                  title: getConstant('Payment_period'),
                  items: [
                    getConstant('1_month'),
                    getConstant('3_months'),
                    getConstant('half_year'),
                    getConstant('Year'),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                DropdownInput(
                  title: getConstant('Payment_method'),
                  items: const [
                    'WayForPay',
                  ],
                )
              ],
            ),
          ),
          AppButton(
              title: getConstant('PAY'),
              onPressed: () {
                routemaster.pop('close');
              }
          ),
          const SizedBox(height: 44.0),
        ],
      ),
    );
  }
}


