import 'package:etm_crm/app/domain/states/school/school_services_state.dart';
import 'package:etm_crm/app/ui/widgets/app_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../theme/text_styles.dart';
import '../../../../widgets/auth_button.dart';
import '../../../../widgets/select_color.dart';


class AddCategoryService extends StatefulWidget {
  const AddCategoryService({Key? key}) : super(key: key);

  @override
  State<AddCategoryService> createState() => _AddCategoryServiceState();
}

class _AddCategoryServiceState extends State<AddCategoryService> {
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
              label: 'Category name *',
              controller: state.categoryName,
              error: state.validateError?.errors.name?[0],
          ),
          const SizedBox(
            height: 40,
          ),
          SelectColor(
              label: "Category color *",
              selected: state.selectColor,
              onSelect: (value) {
                state.selectServiceColor(value);
              }
          ),
          const SizedBox(
            height: 40,
          ),
          AppButton(
            title: 'ADD category',
            onPressed: () {
              state.addCategory();
            },
            horizontalPadding: 17.0,
          ),
        ],
      ),
    );
  }
}
