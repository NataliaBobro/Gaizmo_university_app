import 'package:cached_network_image/cached_network_image.dart';
import 'package:etm_crm/app/domain/models/services.dart';
import 'package:etm_crm/app/domain/models/user.dart';
import 'package:etm_crm/app/domain/services/schedule_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../resources/resources.dart';
import '../../../../theme/text_styles.dart';
import '../../../../utils/url_launch.dart';
import '../../../../widgets/center_header.dart';

class PreviewListStudent extends StatelessWidget {
  const PreviewListStudent({
    Key? key,
    required this.users,
    required this.serviceId
  }) : super(key: key);

  final List<PayUsers>? users;
  final int? serviceId;

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
                    serviceId: serviceId
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
                      child: users![index].user.avatar != null ?
                      CachedNetworkImage(
                        imageUrl: '${users![index].user.avatar}',
                        width: 24,
                        errorWidget: (context, error, stackTrace) =>
                        const SizedBox.shrink(),
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
    required this.serviceId
  }) : super(key: key);

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
      final result = await ScheduleService.fetchPayedUser(context, widget.serviceId);
      if(result != null){
        _listUserData = result;
      }
    }catch(e){
      print(e);
    }finally{
      setState(() {});
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
                const CenterHeader(
                    title: 'Students'
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
                                    user: _listUserData?.users[index].user
                                  )
                              )
                            ],
                          ),
                        ),
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

class PayUserItem extends StatelessWidget {
  const PayUserItem({
    Key? key,
    required this.user
  }) : super(key: key);

  final UserData? user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: user?.avatar != null ?
                CachedNetworkImage(
                  imageUrl: '${user?.avatar}',
                  width: 40,
                  errorWidget: (context, error, stackTrace) =>
                  const SizedBox.shrink(),
                  fit: BoxFit.cover,
                ) : Container(
                  width: 40,
                  height: 40,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Text(
                '${user?.firstName} ${user?.lastName}',
                style: TextStyles.s14w400.copyWith(
                    color: const Color(0xFF242424)
                ),
              )
            ],
          ),
          Container(
            constraints: const BoxConstraints(
              maxWidth: 110
            ),
            width: 110,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                        Svgs.etmPlus
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${user?.balanceEtm} ETM',
                      style: TextStyles.s10w600.copyWith(
                          color: const Color(0xFF242424)
                      ),
                    )
                  ],
                ),
                if(user?.socialAccounts?.instagram != null) ...[
                  CupertinoButton(
                      padding: EdgeInsets.zero,
                      minSize: 0.0,
                      child: Image.asset(
                        Images.inst,
                        width: 16,
                      ),
                      onPressed: () {
                        launchUrlParse(user?.socialAccounts?.instagram);
                      }
                  )
                ]
              ],
            ),
          )
        ],
      ),
    );
  }
}


