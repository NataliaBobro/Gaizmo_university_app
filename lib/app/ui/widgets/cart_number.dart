import 'package:flutter/material.dart';

import '../theme/text_styles.dart';

class CartNumber extends StatefulWidget {
  const CartNumber({
    Key? key,
    required this.controllerNumberCart,
    required this.controllerDateCart,
    required this.controllerCodeCart,
    this.errorsCode,
    this.errorsNumber,
    this.errorsDate,
  }) : super(key: key);

  final TextEditingController controllerNumberCart;
  final TextEditingController controllerDateCart;
  final TextEditingController controllerCodeCart;
  final String? errorsCode;
  final String? errorsNumber;
  final String? errorsDate;

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
              color: const Color(0xFF848484)
          ),
        ),
        TextField(
          controller: widget.controllerNumberCart,
          style: TextStyles.s16w400.copyWith(
            color: Colors.white,
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
              color: Colors.white,
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
          color: widget.errorsNumber == null ? const Color(0xFF848484) : const Color(0xFFFFC700),
        ),
        if(widget.errorsNumber != null) ...[
          Container(
            padding: const EdgeInsets.only(
                top: 4
            ),
            alignment: Alignment.centerRight,
            child: Text(
              '${widget.errorsNumber}',
              style: TextStyles.s12w400.copyWith(
                  color: const Color(0xFFFFC700)
              ),
            ),
          ),
        ],
        const SizedBox(
          height: 32,
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
                        color: const Color(0xFF848484)
                    ),
                  ),
                  TextField(
                    controller: widget.controllerDateCart,
                    style: TextStyles.s16w400.copyWith(
                      color: Colors.white,
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
                        color: Colors.white,
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
                    color: widget.errorsDate == null ? const Color(0xFF848484) : const Color(0xFFFFC700),
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
                        color: const Color(0xFF848484)
                    ),
                  ),
                  TextField(
                    controller: widget.controllerCodeCart,
                    style: TextStyles.s16w400.copyWith(
                      color: Colors.white,
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
                        color: Colors.white,
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
                    color: widget.errorsCode == null ? const Color(0xFF848484) : const Color(0xFFFFC700),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
