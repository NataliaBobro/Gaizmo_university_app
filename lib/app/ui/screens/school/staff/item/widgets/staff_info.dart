import 'package:european_university_app/app/domain/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../theme/text_styles.dart';


class StaffInfo extends StatefulWidget {
  const StaffInfo({
    Key? key,
    this.staff
  }) : super(key: key);

  final UserData? staff;

  @override
  State<StaffInfo> createState() => _StaffInfoState();
}

class _StaffInfoState extends State<StaffInfo> {
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          Text(
            '${widget.staff?.firstName} ${widget.staff?.lastName}',
            style: TextStyles.s18w700.copyWith(
                color: const Color(0xFF242424)
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            constraints: const BoxConstraints(
                maxWidth: 270
            ),
            child: Text(
              '${widget.staff?.school?.name ?? ''} '
                  '${widget.staff?.city ?? ''}, '
                  '${widget.staff?.country ?? ''}',
              style: TextStyles.s14w400.copyWith(
                  color: const Color(0xFF242424)
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          if(isOpen) ...[
            RichText(
              text: TextSpan(
                  text: 'Mother: ',
                  style: TextStyles.s14w600.copyWith(
                      color: const Color(0xFF242424)
                  ),
                  children: [
                    TextSpan(
                      text: 'Anna Smith',
                      style: TextStyles.s14w400.copyWith(
                          color: const Color(0xFF242424)
                      ),
                    )
                  ]
              ),
            ),
            RichText(
              text: TextSpan(
                  text: 'Father: ',
                  style: TextStyles.s14w600.copyWith(
                      color: const Color(0xFF242424)
                  ),
                  children: [
                    TextSpan(
                      text: 'John Smith',
                      style: TextStyles.s14w400.copyWith(
                          color: const Color(0xFF242424)
                      ),
                    )
                  ]
              ),
            ),
          ],
        ],
      ),
    );
  }
}

