import 'package:etm_crm/app/ui/widgets/center_header.dart';
import 'package:flutter/material.dart';

import '../auth_button.dart';
import 'add_payment_cart_screen.dart';

class PaymentCartScreen extends StatefulWidget {
  const PaymentCartScreen({
    Key? key,
    required this.userId
  }) : super(key: key);

  final int? userId;

  @override
  State<PaymentCartScreen> createState() => _PaymentCartScreenState();
}

class _PaymentCartScreenState extends State<PaymentCartScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ColoredBox(
            color: const Color(0xFFF0F3F6),
            child: Column(
              children: [
                const CenterHeaderWithAction(
                    title: 'My cards'
                ),
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            const SizedBox(
                              height: 24,
                            ),

                          ],
                        ),
                      ],
                    )
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: AppButton(
                      title: 'ADD  CARD',
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddPaymentCart(
                                userId: widget.userId,
                              )
                          ),
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
