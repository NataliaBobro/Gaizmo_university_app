import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonLoader extends StatefulWidget {
  const SkeletonLoader({super.key});

  @override
  State<SkeletonLoader> createState() => _SkeletonLoaderState();
}

class _SkeletonLoaderState extends State<SkeletonLoader> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(
            3,
                (index) => Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 16,
              ).copyWith(
                  bottom: 8
              ),
              padding: const EdgeInsets.all(8.0),
              decoration: const BoxDecoration(color: Colors.white),
              child: SkeletonItem(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const SkeletonAvatar(
                            style: SkeletonAvatarStyle(
                              shape: BoxShape.rectangle,
                              width: 150,
                              height: 110,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              children: [
                                SkeletonParagraph(
                                  style: SkeletonParagraphStyle(
                                      lines: 2,
                                      spacing: 6,
                                      lineStyle: SkeletonLineStyle(
                                        randomLength: true,
                                        height: 10,
                                        borderRadius: BorderRadius.circular(8),
                                        minLength: MediaQuery.of(context).size.width / 6,
                                        maxLength: MediaQuery.of(context).size.width / 3,
                                      )),
                                ),
                                SkeletonParagraph(
                                  style: SkeletonParagraphStyle(
                                      lines: 2,
                                      spacing: 6,
                                      lineStyle: SkeletonLineStyle(
                                        randomLength: true,
                                        height: 10,
                                        borderRadius: BorderRadius.circular(8),
                                        minLength: MediaQuery.of(context).size.width / 2,
                                      )),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  )),
            )
        )
      ],
    );
  }
}
