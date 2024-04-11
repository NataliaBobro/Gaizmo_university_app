import 'package:european_university_app/app/ui/theme/app_colors.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:european_university_app/app/ui/widgets/profile/passport/presents_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../resources/resources.dart';
import '../../../theme/text_styles.dart';
import 'exchange_tab.dart';

class PassportScreen extends StatefulWidget {
  const PassportScreen({
    Key? key,
    required this.changeTab
  }) : super(key: key);

  final Function changeTab;

  @override
  State<PassportScreen> createState() => _PassportScreenState();
}

class _PassportScreenState extends State<PassportScreen>  with TickerProviderStateMixin{
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Container(
            width: double.infinity,
            color: const Color(0xFFF0F3F6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                PassportHeader(
                  back: () {
                    widget.changeTab();
                  }
                ),
                ColoredBox(
                  color: Colors.white,
                  child: Row(
                    children: const [
                      SizedBox(
                        height: 224,
                      )
                    ],
                  ),
                ),
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
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      )
                  ),
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorPadding: EdgeInsets.zero,
                    controller: _tabController,
                    labelStyle: TextStyles.s14w700,
                    indicator: const UnderlineTabIndicator(
                      borderSide: BorderSide(width: 3.0, color: AppColors.appButton),
                      insets: EdgeInsets.only(right: 30.0),
                    ),
                    labelPadding: const EdgeInsets.symmetric(
                        horizontal: 16
                    ),
                    labelColor: const Color(0xFF242424),
                    unselectedLabelStyle: TextStyles.s14w400,
                    unselectedLabelColor: const Color(0xFFACACAC),
                    tabs: [
                      Tab(
                        text: getConstant('Presents'),
                        iconMargin: EdgeInsets.zero,
                      ),
                      Tab(
                        text: getConstant('Exchange'),
                        iconMargin: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      PresentsScreen(),
                      ExchangeScreen()
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

class PassportHeader extends StatelessWidget {
  const PassportHeader({
    Key? key,
    required this.back,
  }) : super(key: key);

  final Function back;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          bottom: 8
      ),
      color: Colors.white,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
                vertical: 16
            ),
            alignment: Alignment.center,
            child: Text(
              getConstant('My_ID_Passport'),
              style: TextStyles.s24w700.copyWith(
                  color: const Color(0xFF242424)
              ),
            ),
          ),
          Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: CupertinoButton(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16
                ),
                child: SvgPicture.asset(
                  Svgs.back,
                  width: 32,
                ),
                onPressed: () {
                  back();
                },
              )
          )
        ],
      ),
    );
  }
}

