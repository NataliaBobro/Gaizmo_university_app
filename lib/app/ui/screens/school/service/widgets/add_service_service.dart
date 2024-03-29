import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:european_university_app/app/ui/widgets/select_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../domain/states/services_state.dart';
import '../../../../theme/text_styles.dart';
import '../../../../widgets/app_field.dart';
import '../../../../widgets/auth_button.dart';
import '../../../../widgets/dropzone.dart';
import '../../../../widgets/select_bottom_sheet_input.dart';

class AddServiceService extends StatefulWidget {
  const AddServiceService({Key? key}) : super(key: key);

  @override
  State<AddServiceService> createState() => _AddServiceServiceState();
}

class _AddServiceServiceState extends State<AddServiceService> {
  String? openField;

  void changeOpen(value){
    if(openField == value){
      openField = null;
    }else{
      openField = value;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ServicesState>();
    return  Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 24
      ),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        onVerticalDragUpdate: (details){
          FocusScope.of(context).unfocus();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            Text(
              getConstant('Service_information'),
              style: TextStyles.s14w600.copyWith(
                  color: const Color(0xFFFFC700)
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            AppField(
                label: getConstant('Service_name'),
                controller: state.serviceName
            ),
            const SizedBox(
              height: 16,
            ),
            AppField(
              label: getConstant('Description'),
              controller: state.desc,
            ),
            const SizedBox(
              height: 24,
            ),
            SelectBottomSheetInput(
              label: getConstant('Branch'),
              labelModal: getConstant('Branch'),
              selected: state.selectBranch,
              items: state.listBranch,
              onSelect: (value) {
                state.selectBranchType(value);
              },
              horizontalPadding: 0,
            ),
            const SizedBox(
              height: 24,
            ),
            SelectBottomSheetInput(
              label: getConstant('Category'),
              labelModal: getConstant('Category'),
              selected: state.selectCategory,
              items: state.listCategory,
              onSelect: (value) {
                state.changeCategory(value);
              },
              horizontalPadding: 0,
            ),
            // const SizedBox(
            //   height: 24,
            // ),
            // ToolTipOnAdd(
            //   title: getConstant('Teacher'),
            //   titleStyle: TextStyles.s14w600.copyWith(
            //       color: const Color(0xFF242424)
            //   ),
            //   style: TextStyles.s14w400.copyWith(
            //       color: Colors.black
            //   ),
            //   hintText: '',
            //   items: state.listTeacherData,
            //   selected: state.selectTeacher,
            //   onSelect: (value) {
            //     state.changeSelectTeacher(value);
            //     changeOpen(null);
            //   },
            //   changeOpen: () {
            //     changeOpen('teacher');
            //   },
            //   isOpen: openField == 'teacher',
            //   onAdd: () async {
            //     await Navigator.push(
            //         context,
            //         CupertinoPageRoute(
            //             builder: (context) => ChangeNotifierProvider(
            //               create: (context) => SchoolStaffState(context),
            //               child: const AddStaffScreen(),
            //             )
            //         )
            //     ).whenComplete(() {
            //       state.getMeta();
            //     });
            //   },
            // ),
            const SizedBox(
              height: 40,
            ),
            Text(
              getConstant('Service_details'), 
              style: TextStyles.s14w600.copyWith(
                  color: const Color(0xFFFFC700)
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                  child: AppField(
                      keyboardType: TextInputType.number,
                      label: getConstant('Validity'),
                      controller: state.validity
                  ),
                ),
                const SizedBox(
                  width: 23,
                ),
                Expanded(
                  child: SelectBottomSheetInput(
                    label: "",
                    labelModal: "",
                    selected: state.selectValidityType,
                    items: state.listValidityType,
                    onSelect: (value) {
                      state.changeValidityType(value);
                    },
                    horizontalPadding: 0,
                  ),
                ),
              ],
            ),
            // const SizedBox(
            //   height: 24,
            // ),
            // CupertinoButton(
            //   minSize: 0.0,
            //   padding: EdgeInsets.zero,
            //   child: IgnorePointer(
            //     child: AppField(
            //       label: getConstant('Service_duration'),
            //       controller: state.duration,
            //       placeholder: '_ _ : _ _',
            //     ),
            //   ),
            //   onPressed: () {
            //     _showDialog(
            //       CupertinoDatePicker(
            //         initialDateTime: state.duration.text.isNotEmpty ? DateFormat('dd.MM.yyyy HH:mm').parse('01.01.2024 ${(state.duration.text).replaceAll(' ', '')}:00') : null,
            //         mode: CupertinoDatePickerMode.time,
            //         use24hFormat: true,
            //         onDateTimeChanged: (DateTime newTime) {
            //           setState(() {
            //             state.duration.text = DateFormat('HH:mm').format(newTime);
            //           });
            //         },
            //       ),
            //     );
            //   }
            // ),
            const SizedBox(
              height: 24,
            ),
            AppField(
              keyboardType: TextInputType.number,
              label: getConstant('Number_of_visits'),
              controller: state.visits,
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              getConstant('Payment_details'),
              style: TextStyles.s14w600.copyWith(
                  color: const Color(0xFFFFC700)
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                  child: AppField(
                      keyboardType: TextInputType.number,
                      label: getConstant('Cost'),
                      controller: state.cost
                  ),
                ),
                const SizedBox(
                  width: 23,
                ),
                Expanded(
                  child: SelectBottomSheetInput(
                    label: getConstant('Currency'),
                    labelModal: getConstant('Currency'),
                    selected: state.selectCurrency,
                    items: state.listCurrency,
                    onSelect: (value) {
                      state.changeCurrency(value);
                    },
                    horizontalPadding: 0,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            AppField(
                keyboardType: TextInputType.number,
                label: 'ETM',
                controller: state.etm
            ),
            const SizedBox(
              height: 24,
            ),
            Dropzone(
              selectImage: (image){
                state.selectImage(image);
              },
              file: state.uploadsFile,
            ),
            const SizedBox(
              height: 24,
            ),
            SelectColor(
                selected: state.selectColor,
                label: getConstant('Service_color'),
                onSelect: (value) {
                  state.selectServiceColor(value);
                }
            ),
            const SizedBox(
              height: 24,
            ),
            AppButton(
              title: state.onEditId != null ? getConstant('Edit_service') : getConstant('Add_service'),
              onPressed: () {
                state.addOrEditServiceService();
              },
              horizontalPadding: 17.0,
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
