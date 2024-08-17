import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../domain/states/order_state.dart';
import '../../custom_scroll_physics.dart';
import '../../products/products_item_orders.dart';
import '../../sceleton_loaders.dart';

class StudentOrdersScreen extends StatelessWidget {
  const StudentOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<OrderState>();
    return ListView(
      padding: const EdgeInsets.symmetric(
        vertical: 24
      ),
      physics: const BottomBouncingScrollPhysics(),
      children: [
        Column(
          children: [
            if(state.isLoading) ...[
              const SkeletonLoader(),
            ] else ...[
              ...List.generate(
                  state.listProducts?.data.length ?? 0,
                      (index) => ProductItemOrders(
                    item: state.listProducts?.data[index],
                    hasEdit: false,
                    hasPay: false,
                    hasDeliveryStatus: true
                  ),
              ),
            ]

          ],
        )
      ],
    );
  }
}
