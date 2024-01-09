import 'package:etm_crm/app/domain/models/user.dart';

String convertDaysToFormat(List<WorkDay> dayNumbers) {
  Map<int, String> daysMapping = {
    1: "Mo",
    2: "Tu",
    3: "We",
    4: "Th",
    5: "Fr",
    6: "Sa",
    7: "Su"
  };

  List<String> formattedDays = dayNumbers.map((day) {
    return daysMapping[day.day] ?? '';
  }).toList();

  return formattedDays.join('-');
}
