import 'package:european_university_app/app/domain/models/meta.dart';
import 'package:flutter/material.dart';

import '../theme/text_styles.dart';

class CartNumber extends StatefulWidget {
  const CartNumber({
    Key? key,
    required this.controllerNumberCart,
    required this.controllerDateCart,
    required this.controllerCodeCart,
    required this.controllerFullName,
    this.validateError,
  }) : super(key: key);

  final TextEditingController controllerNumberCart;
  final TextEditingController controllerDateCart;
  final TextEditingController controllerCodeCart;
  final TextEditingController controllerFullName;
  final ValidateError? validateError;

  @override
  State<CartNumber> createState() => _CartNumberState();
}

class _CartNumberState extends State<CartNumber> {
  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: const BorderSide(
        width: 0.0,
        color: Colors.transparent,
      ),
      borderRadius: BorderRadius.circular(8.0),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Card number',
          style: TextStyles.s14w400.copyWith(
              color: const Color(0xFF242424)
          ),
        ),
        TextField(
          controller: widget.controllerNumberCart,
          style: TextStyles.s16w400.copyWith(
            color: const Color(0xFF848484),
          ),
          onChanged: (val) {

          },
          cursorColor: const Color(0xFF1167C3),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 0,
              vertical: 8,
            ),
            hintStyle: TextStyles.s16w400.copyWith(
              color: const Color(0xFF848484),
            ),
            enabledBorder: border,
            border: border,
            errorBorder: border,
            focusedBorder: border,
            hintText: '---- ---- ---- ----',
            fillColor: Colors.transparent,
          ),
        ),
        Container(
          height: 1,
          width: double.infinity,
          color: widget.validateError?.errors.paymentNumberErrors?.first == null ? const Color(0xFF848484) : const Color(0xFFFFC700),
        ),
        if(widget.validateError?.errors.paymentNumberErrors?.first != null) ...[
          Container(
            padding: const EdgeInsets.only(
                top: 4
            ),
            alignment: Alignment.centerRight,
            child: Text(
              '${widget.validateError?.errors.paymentNumberErrors?.first}',
              style: TextStyles.s12w400.copyWith(
                  color: const Color(0xFFFFC700)
              ),
            ),
          ),
        ],
        const SizedBox(
          height: 24,
        ),
        Row(
          children: [
            SizedBox(
              width: 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Vadility',
                    style: TextStyles.s14w400.copyWith(
                        color: const Color(0xFF242424)
                    ),
                  ),
                  TextField(
                    controller: widget.controllerDateCart,
                    style: TextStyles.s16w400.copyWith(
                      color: const Color(0xFF848484),
                    ),
                    onChanged: (val) {

                    },
                    cursorColor: const Color(0xFF1167C3),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical: 8,
                      ),
                      hintStyle: TextStyles.s16w400.copyWith(
                        color: const Color(0xFF848484),
                      ),
                      enabledBorder: border,
                      border: border,
                      errorBorder: border,
                      focusedBorder: border,
                      hintText: '_ _ / _ _',
                      fillColor: Colors.transparent,
                    ),
                  ),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: widget.validateError?.errors.paymentDateErrors?.first == null ? const Color(0xFF848484) : const Color(0xFFFFC700),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            SizedBox(
              width: 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CV-code',
                    style: TextStyles.s14w400.copyWith(
                        color: const Color(0xFF242424)
                    ),
                  ),
                  TextField(
                    controller: widget.controllerCodeCart,
                    style: TextStyles.s16w400.copyWith(
                      color: const Color(0xFF848484),
                    ),
                    onChanged: (val) {

                    },
                    cursorColor: const Color(0xFF1167C3),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical: 8,
                      ),
                      hintStyle: TextStyles.s16w400.copyWith(
                        color: const Color(0xFF848484),
                      ),
                      enabledBorder: border,
                      border: border,
                      errorBorder: border,
                      focusedBorder: border,
                      fillColor: Colors.transparent,
                    ),
                  ),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: widget.validateError?.errors.paymentCodeErrors?.first == null ? const Color(0xFF848484) : const Color(0xFFFFC700),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        Text(
          'Owner full name',
          style: TextStyles.s14w400.copyWith(
              color: const Color(0xFF242424)
          ),
        ),
        TextField(
          controller: widget.controllerFullName,
          style: TextStyles.s16w400.copyWith(
            color: const Color(0xFF848484),
          ),
          cursorColor: const Color(0xFF1167C3),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 0,
              vertical: 8,
            ),
            hintStyle: TextStyles.s16w400.copyWith(
              color: const Color(0xFF848484),
            ),
            enabledBorder: border,
            border: border,
            errorBorder: border,
            focusedBorder: border,
            fillColor: Colors.transparent,
          ),
        ),
        Container(
          height: 1,
          width: double.infinity,
          color: widget.validateError?.errors.fullNameErrors?.first == null ? const Color(0xFF848484) : const Color(0xFFFFC700),
        ),
        if(widget.validateError?.errors.fullNameErrors?.first != null) ...[
          Container(
            padding: const EdgeInsets.only(
                top: 4
            ),
            alignment: Alignment.centerRight,
            child: Text(
              '${widget.validateError?.errors.fullNameErrors?.first}',
              style: TextStyles.s12w400.copyWith(
                  color: const Color(0xFFFFC700)
              ),
            ),
          ),
        ],
      ],
    );
  }
}
