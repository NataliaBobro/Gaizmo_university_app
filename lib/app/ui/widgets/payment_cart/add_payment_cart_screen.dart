import 'package:dio/dio.dart';
import 'package:european_university_app/app/domain/models/meta.dart';
import 'package:european_university_app/app/domain/services/user_service.dart';
import 'package:european_university_app/app/ui/widgets/cart_number.dart';
import 'package:european_university_app/app/ui/widgets/center_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

import '../../utils/show_message.dart';
import '../auth_button.dart';

class AddPaymentCart extends StatefulWidget {
  const AddPaymentCart({
    Key? key,
    required this.userId
  }) : super(key: key);

  final int? userId;

  @override
  State<AddPaymentCart> createState() => _AddPaymentCartState();
}

class _AddPaymentCartState extends State<AddPaymentCart> {
  ValidateError? _validateError;
  bool _loading = false;
  final MaskedTextController controllerNumberCart = MaskedTextController(
      mask: '0000 0000 0000 0000'
  );
  final MaskedTextController controllerDateCart = MaskedTextController(
      mask: '00/00'
  );
  final MaskedTextController controllerCodeCart = MaskedTextController(
      mask: '000'
  );
  TextEditingController controllerFullName = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
              child: ColoredBox(
                color: const Color(0xFFF0F3F6),
                child: Column(
                  children: [
                    const CenterHeader(
                        title: 'Add card'
                    ),
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  CartNumber(
                                      controllerNumberCart: controllerNumberCart,
                                      controllerDateCart: controllerDateCart,
                                      controllerCodeCart: controllerCodeCart,
                                      controllerFullName: controllerFullName,
                                      validateError: _validateError
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: AppButton(
                          title: 'ADD  CARD',
                          onPressed: () async {
                            // addCard();
                          }
                      ),
                    )
                  ],
                ),
              )
          ),
          if(_loading)...[
            Positioned(
                top: 0,
                right: 0,
                bottom: 0,
                left: 0,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.white.withOpacity(.5),
                  child: const CupertinoActivityIndicator(
                    color: Colors.black,
                    radius: 30,
                  ),
                )
            )
          ]
        ],
      ),
    );
  }

  Future<void> addCard() async {
    _validateError = null;
    _loading = true;
    setState(() {});
    try{
      await UserService.addPaymentCard(
          context,
          controllerNumberCart.text,
          controllerDateCart.text,
          controllerCodeCart.text,
          controllerFullName.text,
      );
    } on DioError catch (e) {
      if(e.response?.statusCode == 422){
        final data = e.response?.data as Map<String, dynamic>;
        _validateError = ValidateError.fromJson(data);
        showMessage('${_validateError?.message}', color: const Color(0xFFFFC700));
      }else{
        showMessage(e.message.isEmpty ? e.toString() : e.message);
      }
    }catch(e){
      print(e);
    }finally{
      _loading = false;
      setState(() {});
    }
  }
}
