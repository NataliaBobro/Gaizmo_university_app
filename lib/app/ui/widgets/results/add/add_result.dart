import 'package:european_university_app/app/ui/theme/text_styles.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:european_university_app/app/ui/widgets/auth_button.dart';
import 'package:european_university_app/app/ui/widgets/center_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/states/my_results_state.dart';
import '../../../screens/school/schedule/filter/type_lesson.dart';



class AddResult extends StatefulWidget {
  const AddResult({Key? key}) : super(key: key);

  @override
  State<AddResult> createState() => _AddResultState();
}

class _AddResultState extends State<AddResult> {
  @override
  Widget build(BuildContext context) {
    final read = context.read<MyResultsState>();
    final state = context.watch<MyResultsState>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ColoredBox(
            color: const Color(0xFFF0F3F6),
            child: Column(
              children: [
                CenterHeader(
                    title: getConstant('Add_result')
                ),
                Expanded(
                    child: ListView(
                      children: [
                        CupertinoButton(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 42
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                state.filterSchedule.type.isNotEmpty ? getConstant('Type_of_lesson') : getConstant('Choose_type_of_lesson'),
                                style: TextStyles.s14w400.copyWith(
                                  color: const Color(0xFF242424)
                                ),
                              ),
                              if(state.filterSchedule.type.isNotEmpty) ...[
                                Builder(
                                  builder: (context) {
                                    final service = state.listTypeServices.firstWhere(
                                        (element) => element['id'] == state.filterSchedule.type.first
                                    );
                                    return Text(
                                      "${service['name']}",
                                      style: TextStyles.s14w400.copyWith(
                                          color: const Color(0xFFACACAC)
                                      ),
                                    );
                                  },
                                )
                              ]
                            ],
                          ),
                          onPressed: () async {
                            await Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => ChangeNotifierProvider.value(
                                      value: read,
                                      child: TypeLesson(
                                        isMultipart: false,
                                        selected: state.filterSchedule.type,
                                        list: state.listTypeServices,
                                        onChange: (value){
                                          if(value is List<int>){
                                            state.changeFilterType(value.first);
                                          }
                                        },
                                      )
                                    )
                                )
                            );
                          }
                        )
                      ],
                    )
                ),
                if(state.filterSchedule.type.isNotEmpty) ...[
                  AppButton(
                      title: getConstant('Add_result'),
                      onPressed: () async {
                        state.openAddPhoto();
                      }
                  )
                ],
                const SizedBox(
                  height: 40,
                )
              ],
            ),
          )
      ),
    );
  }
}
