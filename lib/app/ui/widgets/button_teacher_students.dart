import 'package:cached_network_image/cached_network_image.dart';
import 'package:european_university_app/app/domain/models/user.dart';
import 'package:european_university_app/app/ui/theme/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../resources/resources.dart';

class ButtonTeacher extends StatelessWidget {
  const ButtonTeacher({
    Key? key,
    required this.teacher
  }) : super(key: key);

  final UserData? teacher;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Teacher",
          style: TextStyles.s14w400.copyWith(
            color: const Color(0xFF242424)
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: teacher?.avatar != null ?
              CachedNetworkImage(
                imageUrl: '${teacher?.avatar}',
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
              width: 18,
            ),
            Text(
              "${teacher?.firstName} ${teacher?.lastName}",
              style: TextStyles.s14w400.copyWith(
                color: const Color(0xFF242424)
              ),
            )
          ],
        ),
      ],
    );
  }
}


class ButtonStudents extends StatelessWidget {
  const ButtonStudents({
    Key? key,
    required this.students
  }) : super(key: key);

  final List<UserData?>? students;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minSize: 0.0,
      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Students",
          style: TextStyles.s14w400.copyWith(
              color: const Color(0xFF242424)
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                const SizedBox(
                  height: 40,
                  width: 130,
                ),
                ...List.generate(
                    students?.length ?? 0,
                        (index) => Positioned(
                      left: index * 30,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: students![index]?.avatar != null ?
                        CachedNetworkImage(
                          imageUrl: '${students![index]?.avatar}',
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
                    )
                ).take(4),
              ],
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              "+${students?.length}",
              style: TextStyles.s14w400.copyWith(
                  color: const Color(0xFF242424)
              ),
            ),
            SvgPicture.asset(
              Svgs.next
            )
          ],
        ),
      ],
    ),
      onPressed: () {

      }
    );
  }
}
