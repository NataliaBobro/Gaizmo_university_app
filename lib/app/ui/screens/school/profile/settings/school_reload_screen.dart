import 'package:dio/dio.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:european_university_app/app/ui/widgets/auth_button.dart';
import 'package:flutter/material.dart';

import '../../../../../domain/services/reload_service.dart';
import '../../../../utils/show_message.dart';
import '../../../../widgets/center_header.dart';
import '../../../../widgets/snackbars.dart';

class SchoolReloadScreen extends StatefulWidget {
  const SchoolReloadScreen({
    Key? key
  }) : super(key: key);

  @override
  State<SchoolReloadScreen> createState() => _SchoolReloadScreenState();
}

class _SchoolReloadScreenState extends State<SchoolReloadScreen> {
  bool hasReloadBalance = true;
  bool hasReloadTimesheet = true;
  bool hasReloadLessonLink = true;
  bool hasReloadService = true;

  Future<void> reloadBalance() async {
    hasReloadBalance = false;
    setState(() {});
    try {
      await ReloadService.reloadBalance(
          context
      );
    } on DioError catch (e) {
      showMessage(e.message.isEmpty ? e.toString() : e.message);
    } catch (e) {
      showErrorSnackBar(title: 'App request error');
    }
  }

  Future<void> reloadTimesheet() async {
    hasReloadTimesheet = false;
    setState(() {});
    try {
      await ReloadService.reloadTimesheet(
          context
      );
    } on DioError catch (e) {
      showMessage(e.message.isEmpty ? e.toString() : e.message);
    } catch (e) {
      showErrorSnackBar(title: 'App request error');
    }
  }

  Future<void> reloadLessonLink() async {
    hasReloadLessonLink = false;
    setState(() {});
    try {
      await ReloadService.reloadLessonLink(
          context
      );
    } on DioError catch (e) {
      showMessage(e.message.isEmpty ? e.toString() : e.message);
    } catch (e) {
      showErrorSnackBar(title: 'App request error');
    }
  }


  Future<void> reloadService() async {
    hasReloadService = false;
    setState(() {});
    try {
      await ReloadService.reloadService(
          context
      );
    } on DioError catch (e) {
      showMessage(e.message.isEmpty ? e.toString() : e.message);
    } catch (e) {
      showErrorSnackBar(title: 'App request error');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ColoredBox(
            color: const Color(0xFFF0F3F6),
            child: Column(
              children: [
                CenterHeader(
                    title: getConstant('reload')
                ),
                Expanded(
                  child: ListView(
                    physics: const ClampingScrollPhysics(),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 24,
                            ),
                            AppButton(
                              horizontalPadding: 0,
                              title: getConstant('Reload balance'),
                              onPressed: () {
                                reloadBalance();
                              },
                              disabled: !hasReloadBalance,
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            AppButton(
                              horizontalPadding: 0,
                              title: getConstant('Reload timesheet'),
                              onPressed: () {
                                reloadTimesheet();
                              },
                              disabled: !hasReloadTimesheet,
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            AppButton(
                              horizontalPadding: 0,
                              title: getConstant('Reload lesson link'),
                              onPressed: () {
                                reloadLessonLink();
                              },
                              disabled: !hasReloadLessonLink,
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            AppButton(
                              horizontalPadding: 0,
                              title: getConstant('Reload service'),
                              onPressed: () {
                                reloadService();
                              },
                              disabled: !hasReloadService,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
      ),
    );
  }

  void close() {
    Navigator.pop(context);
  }
}
