import 'package:etm_crm/app/ui/screens/school/schedule/widgets/schedule_header.dart';
import 'package:etm_crm/app/ui/widgets/empty_widget.dart';
import 'package:flutter/material.dart';

class SchoolScheduleScreen extends StatefulWidget {
  const SchoolScheduleScreen({Key? key}) : super(key: key);

  @override
  State<SchoolScheduleScreen> createState() => _SchoolScheduleScreenState();
}

class _SchoolScheduleScreenState extends State<SchoolScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ColoredBox(
          color: const Color(0xFFF0F3F6),
          child: Column(
            children: [
              const ScheduleHeader(),
              Expanded(
                child: EmptyWidget(
                  isEmpty: true,
                  title: 'No classes today :(',
                  subtitle: 'Click the button below to add lessons',
                  onPress: () {

                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
