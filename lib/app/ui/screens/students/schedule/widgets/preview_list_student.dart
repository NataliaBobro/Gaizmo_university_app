import 'package:cached_network_image/cached_network_image.dart';
import 'package:european_university_app/app/app.dart';
import 'package:european_university_app/app/domain/models/services.dart';
import 'package:european_university_app/app/domain/models/user.dart';
import 'package:european_university_app/app/domain/services/schedule_service.dart';
import 'package:european_university_app/app/ui/theme/app_colors.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:european_university_app/app/ui/widgets/auth_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../theme/text_styles.dart';
import '../../../../widgets/center_header.dart';

class PreviewListStudent extends StatelessWidget {
  const PreviewListStudent({
    Key? key,
    required this.users,
    required this.serviceId,
    required this.lessonId
  }) : super(key: key);

  final List<PayUsers>? users;
  final int? serviceId;
  final int? lessonId;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minSize: 0.0,
      onPressed: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => ListStudents(
                    lessonId: lessonId,
                    serviceId: serviceId,
                )
            )
        );
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            children: [
              const SizedBox(
                height: 24,
                width: 80,
              ),
              ...List.generate(
                  users?.length ?? 0,
                      (index) => Positioned(
                    left: index * 20,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: users![index].user?.avatar != null ?
                      CachedNetworkImage(
                        imageUrl: '${users![index].user?.avatar}',
                        width: 24,
                        errorWidget: (context, error, stackTrace) =>
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.white
                            ),
                          ),
                        fit: BoxFit.cover,
                      ) : Container(
                        width: 24,
                        height: 24,
                        color: Colors.white,
                      ),
                    ),
                  )
              ).take(4),
            ],
          ),
          if((users?.length ?? 0) > 4) ...[
            const SizedBox(
              width: 8,
            ),
            Text(
              "+${users?.length}",
              style: TextStyles.s14w400.copyWith(
                  color: const Color(0xFF242424)
              ),
            )
          ]
        ],
      ),
    );
  }
}

class ListStudents extends StatefulWidget {
  const ListStudents({
    Key? key,
    required this.lessonId,
    required this.serviceId
  }) : super(key: key);

  final int? lessonId;
  final int? serviceId;

  @override
  State<ListStudents> createState() => _ListStudentsState();
}

class _ListStudentsState extends State<ListStudents> {
  ListPayUsers? _listUserData;

  @override
  void initState() {
    fetchUsers();
    super.initState();
  }

  Future<void> fetchUsers() async {
    try{
      final result = await ScheduleService.fetchPayedUser(
          context,
          widget.serviceId,
          widget.lessonId
      );
      if(result != null){
        _listUserData = result;
      }
    }catch(e){
      print(e);
    }finally{
      setState(() {});
    }
  }

  Future<void> onCheckStudents() async {
    List<int?> checkUsers = [];
    for(var a = 0; a < (_listUserData?.users.length ?? 0); a++){
      if((_listUserData?.users[a].user?.isVisitsCount ?? 0) >= 1){
        checkUsers.add(
            _listUserData?.users[a].user?.id
        );
      }
    }
    DateTime now = DateTime.now();

    try{
      final result = await ScheduleService.onCheckStudents(
          context,
          widget.lessonId,
          checkUsers,
          now
      );
      if(result != null){
        updateUser();
        close();
      }
    }catch(e){
      print(e);
    }finally{
      setState(() {});
    }
  }

  void updateUser() {
    context.read<AppState>().getUser();
  }

  void close(){
    Navigator.pop(context);
  }

  void selectAll(){
    for(var a = 0; a < (_listUserData?.users.length  ?? 0); a++){
      _listUserData?.users[a].user?.isVisitsCount = 1;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ColoredBox(
            color: const Color(0xFFF0F3F6),
            child: Column(
              children: [
                CenterHeader(
                  title: getConstant('Students'),
                  action: appState.userData?.type == 2 ? CupertinoButton(
                    onPressed: () {
                      selectAll();
                    },
                    minSize: 0.0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16
                    ),
                    child: Text(
                      getConstant('Select all'),
                      style: TextStyles.s14w600.copyWith(
                          color: Colors.black
                      ),
                    ),
                  ) : null,
                ),
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ListView(
                            physics: const ClampingScrollPhysics(),
                            children: [
                              const SizedBox(
                                height: 22,
                              ),
                              ...List.generate(
                                  _listUserData?.users.length ?? 0,
                                      (index) => PayUserItem(
                                      key: ValueKey('${_listUserData?.users[index].user?.lastName}''${_listUserData?.users[index].user?.isVisitsCount}'),
                                      user: _listUserData?.users[index].user,
                                      isTeacher: appState.userData?.type == 2,
                                      checkUser: (value) {
                                        setState(() {
                                          _listUserData?.users[index].user?.isVisitsCount = value ? 1 : 0;
                                        });
                                      }
                                  )
                              )
                            ],
                          ),
                        ),

                        if(appState.userData?.type == 2) ...[
                          AppButton(
                              title: getConstant('check_all_student'),
                              onPressed: () {
                                onCheckStudents();
                              }
                          )
                        ],
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    )
                ),
              ],
            ),
          )
      ),
    );
  }
}

class PayUserItem extends StatefulWidget {
  const PayUserItem({
    Key? key,
    required this.user,
    required this.isTeacher,
    required this.checkUser
  }) : super(key: key);

  final UserData? user;
  final bool isTeacher;
  final Function checkUser;

  @override
  State<PayUserItem> createState() => _PayUserItemState();
}

class _PayUserItemState extends State<PayUserItem> {
  bool check = false;

  @override
  void initState() {
    if((widget.user?.isVisitsCount ?? 0) >= 1){
      check = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 16
      ).copyWith(
        bottom: 8
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16)
      ),
      child: CupertinoButton(
        minSize: 0.0,
        padding: EdgeInsets.zero,
        onPressed: () {
          widget.checkUser(!check);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: widget.user?.avatar != null ?
                  CachedNetworkImage(
                    imageUrl: '${widget.user?.avatar}',
                    width: 40,
                    height: 40,
                    errorWidget: (context, error, stackTrace) =>
                        Container(
                            width: 40,
                            height: 40,
                            color: Colors.grey
                        ),
                    fit: BoxFit.cover,
                  ) : Container(
                    width: 40,
                    height: 40,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  '${widget.user?.firstName} ${widget.user?.lastName}',
                  style: TextStyles.s14w400.copyWith(
                      color: const Color(0xFF242424)
                  ),
                )
              ],
            ),
            if(widget.isTeacher) ...[
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                    color: check ? AppColors.appButton : null,
                    border: Border.all(
                        width: 2,
                        color: AppColors.appButton
                    ),
                    borderRadius: BorderRadius.circular(4)
                ),
                child: const Center(
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 16,
                    weight: 700,
                  ),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}


