import 'package:cached_network_image/cached_network_image.dart';
import 'package:etm_crm/app/domain/models/user.dart';
import 'package:etm_crm/app/domain/states/school/school_branch_state.dart';
import 'package:etm_crm/app/ui/screens/school/profile/branchs/add_branch.dart';
import 'package:etm_crm/app/ui/theme/text_styles.dart';
import 'package:etm_crm/app/ui/widgets/empty_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/center_header.dart';
import 'item/branch_item_screen.dart';

class BranchList extends StatefulWidget {
  const BranchList({Key? key}) : super(key: key);

  @override
  State<BranchList> createState() => _BranchListState();
}

class _BranchListState extends State<BranchList> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<SchoolBranchState>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ColoredBox(
            color: const Color(0xFFF0F3F6),
            child: Column(
              children: [
                const CenterHeaderWithAction(
                    title: 'Branches'
                ),
                Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24
                      ),
                      physics: const ClampingScrollPhysics(),
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        if(state.listUserData?.users.isEmpty ?? true) ...[
                          const SizedBox(
                            height: 220,
                          ),
                        ],
                        EmptyWidget(
                            isEmpty: state.listUserData?.users.isEmpty ?? true,
                            title: "No branches yet!",
                            subtitle: "Click the button below to add branch",
                            onPress: () {
                              state.openPage(
                                  context,
                                  const AddBranch()
                              );
                            }
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        ...List.generate(
                            state.listUserData?.users.length ?? 0,
                            (index) => BranchItemWidget(
                              branch: state.listUserData?.users[index],
                                onPressed: () {
                                context.read<SchoolBranchState>().openPage(
                                    context,
                                    BranchItemScreen(
                                      branch: state.listUserData?.users[index],
                                    )
                                );
                              }
                            )
                        )
                      ],
                    )
                )
              ],
            ),
          )
      ),
    );
  }
}


class BranchItemWidget extends StatefulWidget {
  const BranchItemWidget({
    Key? key,
    required this.branch,
    required this.onPressed
  }) : super(key: key);

  final UserData? branch;
  final Function onPressed;

  @override
  State<BranchItemWidget> createState() => _BranchItemWidgetState();
}

class _BranchItemWidgetState extends State<BranchItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: CupertinoButton(
        minSize: 0.0,
        padding: EdgeInsets.zero,
        onPressed: () {
          widget.onPressed();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFE9EEF2),
            borderRadius: BorderRadius.circular(15)
          ),
          child: Column(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: widget.branch?.avatar != null ?
                    CachedNetworkImage(
                      imageUrl: '${widget.branch?.avatar}',
                      width: 32,
                      errorWidget: (context, error, stackTrace) =>
                      const SizedBox.shrink(),
                      fit: BoxFit.cover,
                    ) : Container(
                      width: 32,
                      height: 32,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    '${widget.branch?.school?.name}',
                    style: TextStyles.s14w600.copyWith(
                      color: const Color(0xFF242424)
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(
                    builder: (BuildContext context) {
                      String address = '';
                      if(widget.branch?.city != null){
                        address = '${widget.branch?.city}, ';
                      }
                      if(widget.branch?.street != null){
                        address = '$address${widget.branch?.street} ${widget.branch?.house}';
                      }
                      return Text(
                          address,
                        style: TextStyles.s12w400.copyWith(
                          color: const Color(0xFF848484)
                        ),
                      );
                    },
                  ),
                  Text(
                    '${widget.branch?.school?.category?.translate?.value}',
                    style: TextStyles.s12w400.copyWith(
                        color: const Color(0xFF848484)
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
