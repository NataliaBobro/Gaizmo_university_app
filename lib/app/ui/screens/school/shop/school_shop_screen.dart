import 'package:european_university_app/app/app.dart';
import 'package:european_university_app/app/ui/screens/school/shop/products/school_shop_products.dart';
import 'package:european_university_app/app/ui/screens/school/shop/school_orders_screen.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../domain/states/order_state.dart';
import '../../../theme/text_styles.dart';


class SchoolShopScreen extends StatefulWidget {
  const SchoolShopScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SchoolShopScreen> createState() => _SchoolShopScreenState();
}

class _SchoolShopScreenState extends State<SchoolShopScreen> with TickerProviderStateMixin{
  late int isActiveTab = 0;
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this,
      animationDuration: const Duration(milliseconds: 100),
    );

    _tabController.addListener(() {
      viewTab(_tabController.index);
    });
    super.initState();
  }

  void viewTab (index) {
    setState(() {
      isActiveTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appSate = context.watch<AppState>();

    return Scaffold(
      backgroundColor: Colors.white,
      key: ValueKey(appSate.constantsList),
      body: SafeArea(
          child: Container(
            width: double.infinity,
            color: const Color(0xFFF0F3F6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(
                      bottom: 24
                  ),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20)
                      )
                  ),
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorPadding: EdgeInsets.zero,
                    controller: _tabController,
                    labelStyle: TextStyles.s14w700,
                    indicator: const UnderlineTabIndicator(
                      borderSide: BorderSide(width: 3.0, color: Color(0xFFFFC700)),
                      insets: EdgeInsets.only(right: 35.0),
                    ),
                    labelPadding: const EdgeInsets.symmetric(
                        horizontal: 16
                    ),
                    labelColor: const Color(0xFF242424),
                    unselectedLabelStyle: TextStyles.s14w400,
                    unselectedLabelColor: const Color(0xFFACACAC),
                    tabs: [
                      Tab(
                        text: getConstant('Products'),
                        iconMargin: EdgeInsets.zero,
                      ),
                      Tab(
                        text: getConstant('Orders'),
                        iconMargin: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      const SchoolShopProducts(),
                      ChangeNotifierProvider(
                        create: (context) => OrderState(context, isSchool: true),
                        child: const SchoolOrdersScreen(),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
