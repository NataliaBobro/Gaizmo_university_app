import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../../../resources/resources.dart';
import '../../../../../domain/states/services_state.dart';
import '../../../../widgets/center_header.dart';
import '../../../../widgets/header_search_field.dart';

class ServicesHeader extends StatefulWidget {
  const ServicesHeader({Key? key}) : super(key: key);

  @override
  State<ServicesHeader> createState() => _ServicesHeaderState();
}

class _ServicesHeaderState extends State<ServicesHeader> {
  bool viewSearchField = false;
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ServicesState>();
    return CenterHeaderWithAction(
      title: 'Services',
      action: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          if(!viewSearchField) ...[
            CupertinoButton(
              padding: const EdgeInsets.only(
                  top: 20,
                  bottom: 20,
                  left: 20,
                  right: 12
              ),
              child: SvgPicture.asset(
                  Svgs.search
              ),
              onPressed: () {
                setState(() {
                  viewSearchField = true;
                });
              },
            ),
          ] else ...[
            HeaderSearchField(
              controller: search,
              onChanged: (value) {
                state.fetchServices(search: value);
              },
            )
          ],
        ],
      ),
    );
  }
}
