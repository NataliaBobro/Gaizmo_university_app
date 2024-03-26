import 'package:hive/hive.dart';

String getConstant(String key) {
  return Hive.box('constants').get(key, defaultValue: key);
}