import 'package:dio/dio.dart';
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
import '../../../../domain/models/meta.dart';
import '../../../../domain/services/user_service.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/text_styles.dart';
import '../../../utils/show_message.dart';
import '../../cupertino_modal_appbar.dart';
import '../../custom_scroll_physics.dart';
import '../../dropdown/dropdown.dart';
import '../../snackbars.dart';

class ExchangeScreen extends StatelessWidget {
  const ExchangeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
          horizontal: 24
      ),
      physics: const BottomBouncingScrollPhysics(),
      children: const [
        Payments(),
        SizedBox(
          height: 24,
        ),
        BalanceList()
      ],
    );
  }
}

class BalanceList extends StatefulWidget {
  const BalanceList({super.key});

  @override
  State<BalanceList> createState() => _BalanceListState();
}

class _BalanceListState extends State<BalanceList> {
  BalanceListData? _balanceListData;
  bool _isLoading = true;

  @override
  void initState() {
    fetchUserBalanceList();
    super.initState();
  }

  Future<void> fetchUserBalanceList() async {
    try {
      final result =  await UserService.fetchUserBalanceList(context);
      if(result != null){
        _balanceListData = result;
      }
    } on DioError catch (e) {
      showMessage(e.message.isEmpty ? e.toString() : e.message);
    } catch (e) {
      showErrorSnackBar(title: getConstant('app_error'));
    }finally{
      _isLoading = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ?
      const CupertinoActivityIndicator() :
      Column(
        children: List.generate(
            _balanceListData?.data.length ?? 0,
            (index) => BalanceViewItem(
              item: _balanceListData?.data[index]
            )
        ),
      );
  }
}

class BalanceViewItem extends StatelessWidget {
  const BalanceViewItem({
    super.key,
    required this.item
  });

  final BalanceItemData? item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16)
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
                '${item?.name}'
            ),
          ),
          Text(
              '${item?.value}'
          )
        ],
      ),
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
              top: 28
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


