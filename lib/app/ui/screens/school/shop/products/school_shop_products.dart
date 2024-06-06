import 'package:european_university_app/app/domain/models/shop.dart';
import 'package:european_university_app/app/ui/screens/school/shop/products/add_or_edit_product.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:european_university_app/app/ui/widgets/empty_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/states/school/school_shop_state.dart';
import '../../../../widgets/custom_scroll_physics.dart';
import '../../../../widgets/products/products_item_block.dart';
import '../../../../widgets/sceleton_loaders.dart';

class SchoolShopProducts extends StatefulWidget {
  const SchoolShopProducts({super.key});

  @override
  State<SchoolShopProducts> createState() => _SchoolShopProductsState();
}

class _SchoolShopProductsState extends State<SchoolShopProducts> {

  Future<void> onAddOrEditProduct({Products? product}) async {
    final read = context.read<SchoolShopState>();
    read.initDataEditProduct(product);
    await Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => ChangeNotifierProvider.value(
              value: read,
              child: const AddOrEditProduct(),
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SchoolShopState>();
    return ListView(
      physics: const BottomBouncingScrollPhysics(),
      children: [
        Column(
          children: [
            SizedBox(
              height: state.listProducts?.data.length == 0 ? 200 : 24,
            ),
            EmptyWidget(
              title: getConstant('As_long_as_you_havent_added_any_products'),
              subtitle: getConstant('Add_a_product'),
              onPress: () async {
                onAddOrEditProduct();
              },
              isEmpty: state.listProducts?.data.length == 0,
            ),

            if(state.isLoading) ...[
              const SkeletonLoader(),
            ] else ...[
              ...List.generate(
                  state.listProducts?.data.length ?? 0,
                    (index) => ProductItemBlock(
                    item: state.listProducts?.data[index],
                    hasEdit: true,
                    onEditProduct: () {
                      Navigator.pop(context);
                      onAddOrEditProduct(product: state.listProducts?.data[index]);
                    },
                    onDeleteProduct: () {
                      state.onDeleteProduct(state.listProducts?.data[index].id);
                    },
                  )
              )
            ]
          ],
        )
      ],
    );
  }
}

