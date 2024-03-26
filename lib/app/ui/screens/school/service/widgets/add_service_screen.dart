import 'package:etm_crm/app/ui/screens/school/service/widgets/add_service_service.dart';
import 'package:etm_crm/app/ui/widgets/custom_scroll_physics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/states/services_state.dart';
import '../../../../utils/get_constant.dart';
import '../../../../widgets/center_header.dart';
import '../../../../widgets/select_bottom_sheet_input.dart';
import 'add_category_service.dart';

class AddServiceScreen extends StatefulWidget {
  const AddServiceScreen({
    Key? key,
    this.isEdit = false
  }) : super(key: key);

  final bool isEdit;

  @override
  State<AddServiceScreen> createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  @override
  void initState() {
    context.read<ServicesState>().getMeta().then((value) {
      if(widget.isEdit){
        context.read<ServicesState>().setStateEdit();
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final state = context.watch<ServicesState>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ColoredBox(
          color: const Color(0xFFF0F3F6),
          child: Column(
            children: [
              CenterHeaderWithAction(
                  title: getConstant('Add_service')
              ),
              Expanded(
                child: ListView(
                  physics: const BottomBouncingScrollPhysics(),
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    SelectBottomSheetInput(
                      label: getConstant('Type_of_service'),
                      labelModal: getConstant('Type_of_service'),
                      selected: state.selectService,
                      items: state.listTypeServices,
                      onSelect: (value) {
                        state.selectServiceType(value);
                      }
                    ),
                    if(state.selectService != null && state.selectService?['id'] == 1) ...[
                      const AddCategoryService()
                    ] else if(state.selectService != null && state.selectService?['id'] == 2) ...[
                      const AddServiceService()
                    ],
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
