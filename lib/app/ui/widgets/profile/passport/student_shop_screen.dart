import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/states/student/student_shop_state.dart';
import '../../../utils/get_constant.dart';
import '../../custom_scroll_physics.dart';
import '../../products/products_item_block.dart';
import '../../sceleton_loaders.dart';
import '../../select_bottom_sheet_input.dart';

class StudentShopScreen extends StatefulWidget {
  const StudentShopScreen({
    Key? key,
    required this.onUpdateScroll,
    required this.initOffset,
  }) : super(key: key);

  final Function onUpdateScroll;
  final double? initOffset;


  @override
  State<StudentShopScreen> createState() => _StudentShopScreenState();
}

class _StudentShopScreenState extends State<StudentShopScreen> {
  ScrollController? controller;
  double offsetScroll = 0;

  @override
  void initState() {
    controller = ScrollController(initialScrollOffset: widget.initOffset ?? 0.0);
    controller?.addListener(() {
      addListener();
    });
    super.initState();
  }

  @override
  void dispose() {
    controller?.removeListener(() {
      addListener();
    });
    super.dispose();
  }

  void addListener(){
    setState(() {
      offsetScroll = controller?.offset ?? 0.0;
      widget.onUpdateScroll(controller?.offset ?? 0.0);
    });
  }

  List<Map<String, dynamic>> get listSchool {
    List<Map<String, dynamic>> list = [];
    final schoolList = context.read<StudentShopState>().schoolList;
    list.add(
      {
        "id": 0,
        "name": getConstant('All_school')
      },
    );
    for(var a = 0; a < (schoolList?.users.length ?? 0); a++){
      if(a > 1) break;
      list.add(
        {
          "id": schoolList?.users[a].school?.id,
          "name": schoolList?.users[a].school?.name
        },
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<StudentShopState>();
    return Column(
      children: [
        if(offsetScroll > 100)...[
          SizedBox(
            height: 8,
          ),
          SelectBottomSheetInput(
              label: getConstant('Select_school'),
              labelModal: getConstant('Select_school'),
              selected: state.filterSchool,
              items: listSchool,
              onSelect: (value) {
                state.changeFilter(value);
              }
          ),
          const SizedBox(
            height: 8,
          ),
        ],
        Expanded(
          child: ListView(
            controller: controller,
            padding: const EdgeInsets.symmetric(
                vertical: 24
            ),
            physics: const BottomBouncingScrollPhysics(),
            children: [
              SizedBox(
                height: offsetScroll > 224 ? 224 : offsetScroll,
              ),
              Column(
                children: [
                  if(state.isLoading) ...[
                    const SkeletonLoader(),
                  ] else ...[
                    ...List.generate(
                        state.listProducts?.data.length ?? 0,
                            (index) => ProductItemBlock(
                          item: state.listProducts?.data[index],
                          hasEdit: false,
                          hasPay: true,
                          onPayProduct: (type) {
                            state.payProduct(state.listProducts?.data[index].id, type);
                          },
                        )
                    ),
                  ]

                ],
              )
            ],
          ),
        )
      ],
    );
  }
}