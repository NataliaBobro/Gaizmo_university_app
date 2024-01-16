import 'package:flutter/material.dart';

import '../../../../../widgets/center_header.dart';

class ServiceItem extends StatefulWidget {
  const ServiceItem({
    Key? key,
    required this.serviceId
  }) : super(key: key);

  final int? serviceId;

  @override
  State<ServiceItem> createState() => _ServiceItemState();
}

class _ServiceItemState extends State<ServiceItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          color: const Color(0xFFF0F3F6),
          child: Column(
            children: [
              CenterHeader(
                title: 'Lesson',
              ),

            ],
          ),
        ),
      ),
    );
  }
}
