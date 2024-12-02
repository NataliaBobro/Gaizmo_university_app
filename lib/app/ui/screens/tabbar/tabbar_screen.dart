import 'package:european_university_app/app/ui/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

import '../../../app.dart';
import '../../../domain/states/chats/chats_state.dart';


class TabBarScreen extends StatefulWidget {
  const TabBarScreen({
    Key? key,
    this.initIndex,
    required this.icons,
  }) : super(key: key);

  final String? initIndex;
  final List<Map<String, String>> icons;

  @override
  State<TabBarScreen> createState() => TabBarScreenState();
}

class TabBarScreenState extends State<TabBarScreen> with TickerProviderStateMixin{
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  Future<void> onTapped(int index, TabPageState pageState) async {
    pageState.index = index;
    if(index == 0){
      onPressHome();
    }
    if(index == 4){
      final chatState = context.read<ChatsState>();
      chatState.updateChatsState();
    }
    HapticFeedback.lightImpact();
    setState(() {});
  }

  void onPressHome(){
    context.read<AppState>().pressHome();
  }

  @override
  Widget build(BuildContext context) {
    final pageState = TabPage.of(context);
    final selectedIndex = pageState.index;
    final stack = pageState.stacks[selectedIndex];
    context.watch<ChatsState>();

    return Scaffold(
      extendBody: false,
      backgroundColor: const Color(0xFFF0F3F6),
      body: AnimatedSwitcher(
        duration: kThemeAnimationDuration,
        child: PageStackNavigator(
          key: ValueKey(selectedIndex),
          stack: stack,
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 92.0,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            widget.icons.length,
                (index) => Expanded(
              child: Column(
                children: [
                  CupertinoButton(
                      padding: const EdgeInsets.only(top: 8),
                      onPressed: () => onTapped(index, pageState),
                      child: SvgPicture.asset(
                        widget.icons[index]['icon']!,
                        width: 28,
                        height: 28,
                        fit: BoxFit.contain,
                        color: selectedIndex == index
                            ? const Color(0xFF242424)
                            : const Color(0xFFACACAC),
                      )
                  ),
                  Text(
                    '${widget.icons[index]['name']}',
                    style: TextStyles.s10w600.copyWith(
                      color: selectedIndex == index
                          ? const Color(0xFF242424)
                          : const Color(0xFFACACAC),
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
