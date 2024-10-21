import 'package:european_university_app/app/ui/theme/app_colors.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:european_university_app/app/ui/widgets/app_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/states/services_state.dart';
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
    final state = context.watch<ServicesState>();
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
            getConstant('Service_information'),
            style: TextStyles.s14w600.copyWith(
                color: AppColors.appButton
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          AppField(
              label: '${getConstant('Category_name')} *',
              controller: state.categoryName,
              error: state.validateError?.errors.name?[0],
          ),
          const SizedBox(
            height: 40,
          ),
          AppField(
            label: '${getConstant('Sheet_id')} *',
            controller: state.sheetId,
            error: state.validateError?.errors.sheetId?[0],
          ),
          const SizedBox(
            height: 40,
          ),
          SelectColor(
              label: getConstant('Category_color'),
              selected: state.selectColor,
              onSelect: (value) {
                state.selectServiceColor(value);
              }
          ),
          const SizedBox(
            height: 40,
          ),
          AppButton(
            title: state.onEditId != null ? getConstant('Edit_category') : getConstant('ADD_category'),
            onPressed: () {
              state.addOrEditCategory();
            },
            horizontalPadding: 17.0,
          ),
        ],
      ),
    );
  }
}
