import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:european_university_app/app/domain/models/news.dart';
import 'package:european_university_app/app/domain/states/news/news_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';

import '../../../../resources/resources.dart';
import '../../theme/text_styles.dart';
import '../../utils/get_constant.dart';
import '../../widgets/center_header.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<NewsState>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ColoredBox(
            color: const Color(0xFFF0F3F6),
            child: Column(
              children: [
                CenterHeaderWithAction(
                    title: getConstant('News')
                ),
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: !state.isLoading ? ListView(
                            padding: const EdgeInsets.symmetric(
                                vertical: 24
                            ),
                            physics: const ClampingScrollPhysics(),
                            children: List.generate(
                                state.newsList?.data?.length ?? 0,
                                (index) => NewsItem(
                                  item: state.newsList?.data?[index]
                                )
                            ),
                          ) : const SkeletonLoader(),
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

class NewsItem extends StatefulWidget {
  const NewsItem({
    super.key,
    required this.item
  });

  final News? item;

  @override
  State<NewsItem> createState() => _NewsItemState();
}

class _NewsItemState extends State<NewsItem> {
  @override
  Widget build(BuildContext context) {
    return OpenContainer(
        closedColor: const Color(0xFFF0F3F6),
        closedShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero
        ),
        closedElevation: 0.0,
        closedBuilder: (BuildContext context, VoidCallback openContainer) {
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ).copyWith(
              bottom: 16
            ),
            height: 140,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 16
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8)
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: widget.item?.image != null ? CachedNetworkImage(
                        imageUrl: '${widget.item?.image}',
                        width: 150,
                        height: 110,
                        errorWidget: (context, error, stackTrace) =>
                        const SizedBox.shrink(),
                        fit: BoxFit.cover,
                        progressIndicatorBuilder: (context, error, stackTrace) =>
                        const CupertinoActivityIndicator()
                    ) : const SizedBox(
                      width: 150,
                      height: 110,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.item?.title != null ?'${widget.item?.title}' : '',
                          style: TextStyles.s14w500.copyWith(
                              color: Colors.black,
                              overflow: TextOverflow.ellipsis
                          ),
                          maxLines: 2,
                        ),
                        const Spacer(),
                        Text(
                          widget.item?.content != null ?'${widget.item?.content}' : '',
                          style: TextStyles.s12w400.copyWith(
                              color: Colors.black,
                              overflow: TextOverflow.ellipsis
                          ),
                          maxLines: 2,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
        openBuilder: (BuildContext context, VoidCallback _) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
                child: ColoredBox(
                  color: const Color(0xFFF0F3F6),
                  child: Column(
                    children: [
                      Header(
                          title: '${widget.item?.title}'
                      ),
                      Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: ListView(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8
                                  ),
                                  physics: const ClampingScrollPhysics(),
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: widget.item?.image != null ? CachedNetworkImage(
                                          imageUrl: '${widget.item?.image}',
                                          width: double.infinity,
                                          errorWidget: (context, error, stackTrace) =>
                                          const SizedBox.shrink(),
                                          fit: BoxFit.cover,
                                          progressIndicatorBuilder: (context, error, stackTrace) =>
                                          const CupertinoActivityIndicator()
                                      ) : const SizedBox(
                                        width: double.infinity,
                                        height: 0,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24
                                      ),
                                      child: Text(
                                          widget.item?.content ?? '',
                                        style: TextStyles.s14w400,
                                      ),
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
          );;
        }
    );
  }
}


class Header extends StatefulWidget {
  const Header({
    super.key,
    required this.title
  });

  final String title;

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          bottom: 8
      ),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)
          )
      ),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(
                left: 40
            ),
            alignment: Alignment.center,
            child: Text(
              widget.title,
              style: TextStyles.s18w600.copyWith(
                  color: const Color(0xFF242424)
              ),
            ),
          ),
          Positioned(
              left: 0,
              top: 0,
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                child: SvgPicture.asset(
                  Svgs.close,
                  width: 32,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
          ),
        ],
      ),
    );
  }
}


class SkeletonLoader extends StatefulWidget {
  const SkeletonLoader({super.key});

  @override
  State<SkeletonLoader> createState() => _SkeletonLoaderState();
}

class _SkeletonLoaderState extends State<SkeletonLoader> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
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
        ),
      ),
    );
  }
}

