import 'package:etm_crm/app/domain/states/payment_state.dart';
import 'package:etm_crm/app/ui/widgets/payments/wayforpay_payment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/get_constant.dart';
import '../center_header.dart';

class PaymentList extends StatefulWidget {
  const PaymentList({super.key});

  @override
  State<PaymentList> createState() => _PaymentListState();
}

class _PaymentListState extends State<PaymentList> {
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
                    title: getConstant('Payments')
                ),
                Expanded(
                  child: state.isLoading ?
                    const Center(
                      child: CupertinoActivityIndicator(),
                    ) :
                    ListView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 25
                      ),
                      physics: const ClampingScrollPhysics(),
                      children: const [
                        WayForPayPreview()
                      ],
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
