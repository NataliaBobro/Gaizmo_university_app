import 'package:flutter/cupertino.dart';
import 'package:sliver_tools/sliver_tools.dart';

class CustomSliverPinnedHeader extends StatelessWidget {
  final Widget child;
  final bool isPinned;
  const CustomSliverPinnedHeader(
      {required this.child, this.isPinned = true, super.key});

  @override
  Widget build(BuildContext context) {
    return isPinned
        ? SliverPinnedHeader(child: child)
        : SliverToBoxAdapter(child: child);
  }
}
