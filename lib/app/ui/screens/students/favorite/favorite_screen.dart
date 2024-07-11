
import 'package:european_university_app/app/ui/screens/students/favorite/widgets/favorite_tab.dart';
import 'package:european_university_app/app/ui/screens/students/favorite/widgets/pay_tab.dart';
import 'package:european_university_app/app/ui/theme/app_colors.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:european_university_app/app/ui/widgets/center_header.dart';
import 'package:flutter/material.dart';

import '../../../theme/text_styles.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({
    Key? key,
    this.initTab
  }) : super(key: key);

  final int? initTab;

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> with TickerProviderStateMixin{
  late int isActiveTab = 0;
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      initialIndex: widget.initTab ?? 0,
      length: 2,
      vsync: this,
      animationDuration: const Duration(milliseconds: 100),
    );

    if(widget.initTab != null){
      viewTab(widget.initTab);
    }

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Container(
            width: double.infinity,
            color: const Color(0xFFF0F3F6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CenterHeader(title: getConstant('Favorite_lessons')),
                Container(
                  height: 55,
                  alignment: Alignment.center,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorPadding: EdgeInsets.zero,
                    controller: _tabController,
                    indicatorColor: Colors.transparent,
                    indicatorWeight: 0.5,
                    labelStyle: TextStyles.s14w700,
                    // isScrollable: true,
                    labelPadding: const EdgeInsets.symmetric(
                        horizontal: 16
                    ).copyWith(
                        bottom: 24
                    ),
                    labelColor: const Color(0xFF242424),
                    unselectedLabelStyle: TextStyles.s14w400,
                    unselectedLabelColor: const Color(0xFFACACAC),
                    tabs: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Tab(
                            height: 24,
                            text: getConstant('Favorites'),
                            iconMargin: EdgeInsets.zero,
                          ),
                          if(isActiveTab == 0) ...[
                            Container(
                              height: 4,
                              width: 40,
                              color: AppColors.appButton,
                            )
                          ]
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Tab(
                            height: 19,
                            text: getConstant('Active'),
                          ),
                          if(isActiveTab == 1) ...[
                            Container(
                              height: 4,
                              width: 40,
                              color: AppColors.appButton,
                            )
                          ]
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      FavoriteTab(),
                      PayTab(),
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
