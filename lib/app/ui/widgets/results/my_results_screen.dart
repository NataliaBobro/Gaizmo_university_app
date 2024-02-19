import 'package:cached_network_image/cached_network_image.dart';
import 'package:etm_crm/app/domain/models/results.dart';
import 'package:etm_crm/app/ui/theme/text_styles.dart';
import 'package:etm_crm/app/ui/widgets/center_header.dart';
import 'package:etm_crm/app/ui/widgets/empty_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../resources/resources.dart';
import '../../../domain/states/my_results_state.dart';
import 'add/add_result.dart';

class MyResultsScreen extends StatefulWidget {
  const MyResultsScreen({Key? key}) : super(key: key);

  @override
  State<MyResultsScreen> createState() => _MyResultsScreenState();
}

class _MyResultsScreenState extends State<MyResultsScreen> {
  @override
  Widget build(BuildContext context) {
    final read = context.read<MyResultsState>();
    final state = context.watch<MyResultsState>();

    final results = state.resultsModel?.results ?? [];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ColoredBox(
            color: const Color(0xFFF0F3F6),
            child: Column(
              children: [
                 CenterHeaderWithAction(
                    title: 'My results',
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
                Expanded(
                    child: ListView(
                      children: [
                        if(state.isLoading) ...[
                          const SizedBox(
                            height: 233,
                          ),
                          const CupertinoActivityIndicator()
                        ] else ...[
                          if(results.isEmpty) ...[
                            const SizedBox(
                              height: 233,
                            ),
                          ],
                          EmptyWidget(
                            isEmpty: results.isEmpty,
                            title: "No results yet :(",
                            subtitle: "Click the button below to add result! ",
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
                          const SizedBox(
                            height: 16,
                          ),
                          ...List.generate(
                              results.length,
                              (index) => ResultItemWidget(
                                item: results[index]
                              )
                          )
                        ],
                      ],
                    )
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
                    'Results',
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
          memCacheWidth: 200,
          maxWidthDiskCache: 200,
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
