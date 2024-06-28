import 'package:cached_network_image/cached_network_image.dart';
import 'package:european_university_app/app/app.dart';
import 'package:european_university_app/app/domain/models/results.dart';
import 'package:european_university_app/app/domain/states/timesheet.dart';
import 'package:european_university_app/app/ui/theme/text_styles.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:european_university_app/app/ui/widgets/center_header.dart';
import 'package:european_university_app/app/ui/widgets/empty_widget.dart';
import 'package:european_university_app/app/ui/widgets/results/timesheet_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../resources/resources.dart';
import '../../../domain/states/my_results_state.dart';
import '../../theme/app_colors.dart';
import 'add/add_result.dart';

class MyResultsScreen extends StatefulWidget {
  const MyResultsScreen({Key? key}) : super(key: key);

  @override
  State<MyResultsScreen> createState() => _MyResultsScreenState();
}

class _MyResultsScreenState extends State<MyResultsScreen> with TickerProviderStateMixin{
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
    final state = context.watch<MyResultsState>();
    final appState = context.read<AppState>();
    final results = state.resultsModel?.results ?? [];
    final task = state.myTaskModel?.results ?? [];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ColoredBox(
            color: const Color(0xFFF0F3F6),
            child: Column(
              children: [
                CenterHeaderWithAction(
                    withBorder: false,
                    title: getConstant('My_results'),
                    action: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CupertinoButton(
                          minSize: 0.0,
                          padding: const EdgeInsets.symmetric(
                            vertical: 25,
                            horizontal: 24
                          ),
                          onPressed: () {
                            openFilter();
                          },
                          child: SvgPicture.asset(
                              Svgs.menu
                          ),
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
                      insets: EdgeInsets.only(right: 35.0),
                    ),
                    labelPadding: const EdgeInsets.symmetric(
                        horizontal: 16
                    ),
                    labelColor: const Color(0xFF242424),
                    unselectedLabelStyle: TextStyles.s14w400,
                    unselectedLabelColor: const Color(0xFFACACAC),
                    tabs: [
                      if(state.isTeacher == true) ...[
                        Tab(
                          text: getConstant('My_tasks'),
                          iconMargin: EdgeInsets.zero,
                        ),
                      ],
                      Tab(
                        text: getConstant('Results'),
                        iconMargin: EdgeInsets.zero,
                      ),
                      if(state.isTeacher != true) ...[
                        Tab(
                          text: getConstant('Timesheet'),
                          iconMargin: EdgeInsets.zero,
                        ),
                      ],
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      if(state.isTeacher == true) ...[
                        ResultTab(
                            hasAdd: false,
                            list: task
                        )
                      ],
                      ResultTab(
                          list: results
                      ),
                      if(state.isTeacher != true) ...[
                        ChangeNotifierProvider(
                            create: (context) => TimesheetState(
                                context,
                                appState.userData?.id
                            ),
                            child: const TimesheetTab(),
                        )
                      ],
                    ],
                  ),
                )
              ],
            ),
          )
      ),
    );
  }

  void openFilter() {
    final read = context.read<MyResultsState>();
    showModalBottomSheet(
      context: context,
      enableDrag: true,
      isDismissible: true,
      useRootNavigator: true,
      barrierColor: Colors.black.withOpacity(.75),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) {
        final heightItems = (read.listTypeServices.length * 48) + 68;
        final height = heightItems > 300 ? 300 : heightItems;
        return SizedBox(
          height: height.toDouble(),
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)
                )
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 14
                  ),
                  child: Text(
                    getConstant('Results'),
                    style: TextStyles.s14w400.copyWith(
                        color: Colors.black
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      ...List.generate(
                          read.listTypeServices.length,
                              (index) => CupertinoButton(
                            minSize: 0.0,
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              read.onChangeFilter(read.listTypeServices[index]);
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 14
                              ),
                              child: Text(
                                read.listTypeServices[index]['name'],
                                style: TextStyles.s14w400.copyWith(
                                    color: Colors.black
                                ),
                              ),
                            ),
                          )
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}


class ResultTab extends StatefulWidget {
  const ResultTab({
    Key? key,
    required this.list,
    this.hasAdd = true
  }) : super(key: key);

  final List<ResultItem> list;
  final bool hasAdd;

  @override
  State<ResultTab> createState() => _ResultTabState();
}

class _ResultTabState extends State<ResultTab> {
  @override
  Widget build(BuildContext context) {
    final read = context.read<MyResultsState>();
    final state = context.watch<MyResultsState>();

    return  ListView(
      children: [
        if(state.isLoading) ...[
          const SizedBox(
            height: 233,
          ),
          const CupertinoActivityIndicator()
        ] else ...[
          if(widget.list.isEmpty) ...[
            const SizedBox(
              height: 233,
            ),
          ],
          if(widget.hasAdd) ...[
            EmptyWidget(
              isEmpty: widget.list.isEmpty,
              title: getConstant('No_results_yet_'),
              subtitle: getConstant('Click_the_button_below_to_add_result'),
              onPress: () async {
                await Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => ChangeNotifierProvider.value(
                          value: read,
                          child: const AddResult(),
                        )
                    )
                );
              },
            ),
          ],
          const SizedBox(
            height: 16,
          ),
          ...List.generate(
              widget.list.length,
                  (index) => ResultItemWidget(
                  item: widget.list[index]
              )
          )
        ],
      ],
    );
  }
}



class ResultItemWidget extends StatelessWidget {
  const ResultItemWidget({
    Key? key,
    required this.item
  }) : super(key: key);

  final ResultItem item;

  @override
  Widget build(BuildContext context) {
    String date = '';
    if(item.createdAt != null) {
      DateTime inputDate = DateTime.parse("${item.createdAt}");
      date = DateFormat('dd.MM.yyyy').format(inputDate);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${item.user?.firstName} ${item.user?.lastName}",
                style: TextStyles.s14w600.copyWith(
                  color: Colors.black
                ),
              ),
              Text(
                "${item.service?.name}/ $date",
                style: TextStyles.s14w400.copyWith(
                    color: Colors.black
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        CachedNetworkImage(
          key: Key("${item.image}"),
          cacheKey: "${item.image}",
          imageUrl: "${item.image}",
          width: SizerUtil.width,
          errorWidget: (context, error, stackTrace) =>
          const SizedBox.shrink(),
          fit: BoxFit.cover,
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
