import 'package:etm_crm/app/domain/models/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../../resources/resources.dart';
import '../../../../school/schedule/school_schedule_screen.dart';


class ServiceItemContent extends StatefulWidget {
  const ServiceItemContent({
    Key? key,
    required this.service
  }) : super(key: key);

  final ServicesModel? service;

  @override
  State<ServiceItemContent> createState() => _ServiceItemContentState();
}

class _ServiceItemContentState extends State<ServiceItemContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ).copyWith(
          top: 14,
          bottom: 10
      ),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color(int.parse('${widget.service?.color}')).withOpacity(.4)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ContentRowInfo(
            title: 'Teacher',
            value: '${widget.service?.teacher?.firstName} '
                '${widget.service?.teacher?.lastName}',
          ),
          const ContentRowInfo(
            title: 'Students',
            value: '0',
          ),
          ContentRowInfo(
            title: 'School',
            value: '${widget.service?.school?.name}'
          ),
          ContentRowInfo(
            title: 'Adress',
            value: '${widget.service?.school?.street} '
                '${widget.service?.school?.house}',
          ),
          const ContentRowInfo(
              title: 'Lesson links',
              value: ''
          ),
          ContentRowInfo(
            title: 'Description',
            content: CupertinoButton(
              minSize: 0.0,
              padding: EdgeInsets.zero,
              onPressed: () {

              },
              child: RotatedBox(
                quarterTurns: 2,
                child: SvgPicture.asset(
                    Svgs.open
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
