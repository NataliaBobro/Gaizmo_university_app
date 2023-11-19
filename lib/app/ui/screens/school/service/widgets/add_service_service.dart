import 'package:etm_crm/app/ui/widgets/select_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/states/school/school_services_state.dart';
import '../../../../theme/text_styles.dart';
import '../../../../widgets/app_field.dart';
import '../../../../widgets/auth_button.dart';
import '../../../../widgets/select_bottom_sheet_input.dart';

class AddServiceService extends StatefulWidget {
  const AddServiceService({Key? key}) : super(key: key);

  @override
  State<AddServiceService> createState() => _AddServiceServiceState();
}

class _AddServiceServiceState extends State<AddServiceService> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<SchoolServicesState>();
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 24
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          Text(
            'Service information',
            style: TextStyles.s14w600.copyWith(
                color: const Color(0xFFFFC700)
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          AppField(
              label: 'Service name *',
              controller: state.serviceName
          ),
          const SizedBox(
            height: 24,
          ),
          SelectBottomSheetInput(
            label: "Branch *",
            labelModal: "Branch",
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
            label: "Category",
            labelModal: "Category",
            selected: state.selectCategory,
            items: state.listCategory,
            onSelect: (value) {
              state.changeCategory(value);
            },
            horizontalPadding: 0,
          ),
          const SizedBox(
            height: 24,
          ),
          SelectBottomSheetInput(
            label: "Teacher",
            labelModal: "Teacher",
            selected: state.selectTeacher,
            items: state.listTeacher,
            onSelect: (value) {
              state.changeSelectTeacher(value);
            },
            horizontalPadding: 0,
          ),
          const SizedBox(
            height: 40,
          ),
          Text(
            'Service details',
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
                    label: 'Validity',
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
          const SizedBox(
            height: 24,
          ),
          AppField(
            label: 'Service duration',
            controller: state.duration,
            placeholder: '_ _ : _ _',
          ),
          const SizedBox(
            height: 24,
          ),
          AppField(
            label: 'Number of visits',
            controller: state.visits,
          ),
          const SizedBox(
            height: 40,
          ),
          Text(
            'Payment details',
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
                    label: 'Cost',
                    controller: state.cost
                ),
              ),
              const SizedBox(
                width: 23,
              ),
              Expanded(
                child: SelectBottomSheetInput(
                  label: "Currency",
                  labelModal: "Currency",
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
              label: 'ETM',
              controller: state.etm
          ),
          const SizedBox(
            height: 24,
          ),
          SelectColor(
            selected: state.selectColor,
            label: 'Service color',
            onSelect: (value) {
              state.selectServiceColor(value);
            }
          ),
          const SizedBox(
            height: 24,
          ),
          AppButton(
            title: 'ADD service',
            onPressed: () {
              state.addService();
            },
            horizontalPadding: 17.0,
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
