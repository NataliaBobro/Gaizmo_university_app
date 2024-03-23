import 'package:dio/dio.dart';
import 'package:etm_crm/app/domain/models/meta.dart';
import 'package:etm_crm/app/domain/services/user_service.dart';
import 'package:etm_crm/app/ui/utils/get_constant.dart';
import 'package:etm_crm/app/ui/widgets/app_field.dart';
import 'package:flutter/material.dart';
import '../utils/show_message.dart';
import 'auth_button.dart';
import 'center_header.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({
    Key? key,
    required this.userId
  }) : super(key: key);

  final int? userId;

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  ValidateError? validateError;

  Future<void> changePassword() async{
    try{
      final result = await UserService.changePassword(
        context,
        widget.userId,
        oldPassword.text,
        newPassword.text,
        confirmPassword.text,
      );

      if(result == true){
        close();
      }
    } on DioError catch (e) {
      if(e.response?.statusCode == 422){
        final data = e.response?.data as Map<String, dynamic>;
        print(data);
        validateError = ValidateError.fromJson(data);
        showMessage('${validateError?.message}', color: const Color(0xFFFFC700));
      }else{
        showMessage(e.message.isEmpty ? e.toString() : e.message);
      }
    }catch(e){
      print(e);
    } finally{
      setState(() {});
    }
  }

  void close() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    oldPassword.dispose();
    newPassword.dispose();
    confirmPassword.dispose();
    super.dispose();
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
                CenterHeaderWithAction(
                    title: getConstant('Settings')
                ),
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ListView(
                              physics: const ClampingScrollPhysics(),
                              children: [
                                const SizedBox(
                                  height: 24,
                                ),
                                AppField(
                                  label: getConstant('Old_password'),
                                  controller: oldPassword,
                                  isPass: true,
                                  error: validateError?.errors.oldPassword?.first,
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                AppField(
                                  label: getConstant('New_password'),
                                  controller: newPassword,
                                  isPass: true,
                                  error: validateError?.errors.newPassword?.first,
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                AppField(
                                  label: getConstant('Confirm_password'),
                                  controller: confirmPassword,
                                  isPass: true,
                                  error: validateError?.errors.confirmPassword?.first,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: AppButton(
                      title: getConstant('SAVE_CHANGES'),
                      onPressed: () {
                        changePassword();
                      }
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
