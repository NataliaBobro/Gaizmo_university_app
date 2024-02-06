import 'package:etm_crm/app/ui/theme/text_styles.dart';
import 'package:etm_crm/app/ui/widgets/auth_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../resources/resources.dart';
import '../../../../../domain/states/student/my_results_state.dart';
import '../../../../widgets/take_photo_result.dart';

class AddImage extends StatefulWidget {
  const AddImage({Key? key}) : super(key: key);

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<MyResultsState>();
    return state.selectFile == null ? TakePhotoResultWidget(
      takePhoto: (file) {
        state.changeFile(file);
      },
    ) : const ViewSelectedFile();
  }
}

class ViewSelectedFile extends StatefulWidget {
  const ViewSelectedFile({Key? key}) : super(key: key);

  @override
  State<ViewSelectedFile> createState() => _ViewSelectedFileState();
}

class _ViewSelectedFileState extends State<ViewSelectedFile> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<MyResultsState>();
    return Scaffold(
      backgroundColor: const Color(0xFF242424),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    CupertinoButton(
                      onPressed: () {
                        state.removeFile();
                      },
                      minSize: 0.0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 14
                      ),
                      child: SvgPicture.asset(
                        Svgs.close,
                        color: Colors.white,
                        width: 32,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: state.selectFile != null ? Image.file(
                      state.selectFile!,
                      width: SizerUtil.width,
                      fit: BoxFit.cover,
                    ) : Container(),
                  ),
                ),
                AppButton(
                    title: "Add result",
                    onPressed: () {
                      state.addResult();
                    }
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
          if(state.isLoadingAdd) ...[
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              bottom: 0,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: const Color(0xFF242424).withOpacity(.8),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CupertinoActivityIndicator(color: Color(0xFFFFC700), radius: 30,),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Please, wait!\nThe result is loading...",
                        style: TextStyles.s14w600.copyWith(
                            color: Colors.white
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
            )
          ]
        ],
      ),
    );
  }
}

