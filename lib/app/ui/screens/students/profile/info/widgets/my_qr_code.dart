import 'package:etm_crm/app/ui/utils/get_constant.dart';
import 'package:flutter/material.dart';

import '../../../../../../../resources/resources.dart';
import '../../../../../widgets/center_header.dart';

class MuQrCode extends StatelessWidget {
  const MuQrCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ColoredBox(
            color: const Color(0xFFF0F3F6),
            child: Column(
              children: [
                 CenterHeader(
                    title: getConstant('My_QR_code')
                ),
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          Images.testQr,
                          width: 200,
                          fit: BoxFit.cover,
                        )
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
