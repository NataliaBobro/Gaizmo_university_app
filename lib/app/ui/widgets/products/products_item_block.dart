import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:european_university_app/app/domain/models/shop.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:european_university_app/app/ui/widgets/auth_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../resources/resources.dart';
import '../../theme/app_colors.dart';
import '../../theme/text_styles.dart';

class ProductItemBlock extends StatefulWidget {
  const ProductItemBlock({
    super.key,
    required this.item,
    this.hasEdit = false,
    this.hasPay = false,
    this.onEditProduct,
    this.onDeleteProduct,
    this.onUpdateStatus,
    this.onPayProduct,
    this.hasDeliveryStatus = false,
    this.hasChangeDeliveryStatus = false
  });

  final Products? item;
  final bool hasEdit;
  final bool hasPay;
  final bool hasChangeDeliveryStatus;
  final bool hasDeliveryStatus;
  final Function? onEditProduct;
  final Function? onDeleteProduct;
  final Function? onUpdateStatus;
  final Function? onPayProduct;

  @override
  State<ProductItemBlock> createState() => _ProductItemBlockState();
}

class _ProductItemBlockState extends State<ProductItemBlock> {
  @override
  Widget build(BuildContext context) {
    return OpenContainer(
        closedColor: const Color(0xFFF0F3F6),
        closedShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero
        ),
        closedElevation: 0.0,
        openElevation: 0.0,
        closedBuilder: (BuildContext context, VoidCallback openContainer) {
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ).copyWith(
                bottom: 16
            ),
            height: 185,
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
                        width: 135,
                        height: 135,
                        errorWidget: (context, error, stackTrace) =>
                        const SizedBox.shrink(),
                        fit: BoxFit.cover,
                        progressIndicatorBuilder: (context, error, stackTrace) =>
                        const CupertinoActivityIndicator()
                    ) : const SizedBox(
                      width: 135,
                      height: 135,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                widget.item?.name ??  '',
                                style: TextStyles.s14w500.copyWith(
                                    color: Colors.black,
                                    overflow: TextOverflow.ellipsis
                                ),
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          widget.item?.desc ?? '',
                          style: TextStyles.s12w400.copyWith(
                              color: AppColors.fNeutral800,
                              overflow: TextOverflow.ellipsis
                          ),
                          maxLines: 2,
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            SvgPicture.asset(
                              Svgs.cache,
                              width: 24,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              '${widget.item?.priceEtm ?? ''} EU / ${widget.item?.priceMoney ?? ''} UAH',
                              style: TextStyles.s12w400.copyWith(
                                  color: AppColors.fNeutral800,
                                  overflow: TextOverflow.ellipsis
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        CupertinoButton(
                            padding: EdgeInsets.zero,
                            minSize: 0.0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 8
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: AppColors.appButton
                              ),
                              child: Text(
                                getConstant('Order'),
                                style: TextStyles.s14w600.copyWith(
                                    color: Colors.white
                                ),
                              ),
                            ),
                            onPressed: () {
                              openContainer();
                            }
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
        openBuilder: (BuildContext context, VoidCallback _) {
          return OpenedProduct(
            item: widget.item,
            hasEdit: widget.hasEdit,
            hasPay: widget.hasPay,
            onEditProduct: widget.onEditProduct,
            onDeleteProduct: widget.onDeleteProduct,
            onUpdateStatus: widget.onUpdateStatus,
            onPayProduct: widget.onPayProduct,
            hasDeliveryStatus: widget.hasDeliveryStatus,
            hasChangeDeliveryStatus: widget.hasChangeDeliveryStatus,
          );
        }
    );
  }
}

class OpenedProduct extends StatefulWidget {
  const OpenedProduct({
    super.key,
    required this.item,
    required this.hasEdit,
    this.onEditProduct,
    this.onDeleteProduct,
    this.onUpdateStatus,
    this.onPayProduct,
    required this.hasPay,
    required this.hasDeliveryStatus,
    this.hasChangeDeliveryStatus = false,
  });

  final Products? item;
  final bool hasEdit;
  final bool hasPay;
  final bool hasChangeDeliveryStatus;
  final bool hasDeliveryStatus;
  final Function? onEditProduct;
  final Function? onDeleteProduct;
  final Function? onUpdateStatus;
  final Function? onPayProduct;

  @override
  State<OpenedProduct> createState() => _OpenedProductState();
}

class _OpenedProductState extends State<OpenedProduct> {
  String selectPaymentType = '';

  @override
  void initState() {
    if((widget.item?.priceMoney ?? 0) > 0){
      selectPaymentType = 'money';
    }else{
      selectPaymentType = 'etm';
    }
    super.initState();
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
                Header(
                    title: '${widget.item?.name}',
                    deliveryStatus: '${widget.item?.deliveryStatus}',
                    hasDeliveryStatus: widget.hasDeliveryStatus,
                    hasChangeDeliveryStatus: widget.hasChangeDeliveryStatus,
                    hasEdit: widget.hasEdit,
                    onEditProduct: () {
                      if(widget.hasEdit){
                        widget.onEditProduct!();
                      }
                    },
                    onDeleteProduct: () {
                      if(widget.hasEdit){
                        widget.onDeleteProduct!();
                      }
                    },
                    onUpdateStatus: () {
                      widget.onUpdateStatus!(widget.item);
                    }
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: widget.item?.image != null ? CachedNetworkImage(
                                        imageUrl: '${widget.item?.image}',
                                        width: SizerUtil.width - 100,
                                        errorWidget: (context, error, stackTrace) =>
                                        const SizedBox.shrink(),
                                        fit: BoxFit.contain,
                                        progressIndicatorBuilder: (context, error, stackTrace) =>
                                        const CupertinoActivityIndicator()
                                    ) : const SizedBox(
                                      width: double.infinity,
                                      height: 0,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    Svgs.cache,
                                    width: 24,
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    '${widget.item?.priceEtm ?? ''} EU / ${widget.item?.priceMoney ?? ''} UAH',
                                    style: TextStyles.s12w400.copyWith(
                                        color: AppColors.fNeutral800,
                                        overflow: TextOverflow.ellipsis
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24
                                ),
                                child: Text(
                                  widget.item?.desc ?? '',
                                  style: TextStyles.s14w400,
                                ),
                              ),
                            ],
                          ),
                        ),

                        if(widget.hasDeliveryStatus) ...[
                          Text(
                              '${widget.item?.createdAt}'
                          ),
                          const SizedBox(
                            height: 40,
                          )
                        ],

                        if(widget.hasPay)...[
                          AppButton(
                              title: getConstant('Pay'),
                              onPressed: () {
                                if(widget.onPayProduct != null){
                                  widget.onPayProduct!();
                                }
                              }
                          ),
                          const SizedBox(
                            height: 20,
                          )
                        ],
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


class Header extends StatefulWidget {
  Header({
    super.key,
    required this.title,
    required this.hasEdit,
    required this.onEditProduct,
    required this.onDeleteProduct,
    required this.onUpdateStatus,
    required this.deliveryStatus,
    required this.hasDeliveryStatus,
    this.hasChangeDeliveryStatus = false
  });

  final String title;
  final bool hasEdit;
  final bool hasDeliveryStatus;
  late String? deliveryStatus;
  final bool hasChangeDeliveryStatus;
  final Function onEditProduct;
  final Function onDeleteProduct;
  final Function onUpdateStatus;

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.only(
          bottom: 10
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
              left: 40,
              right: 90
            ),
            alignment: Alignment.center,
            child: Text(
              widget.title,
              style: TextStyles.s18w600.copyWith(
                color: const Color(0xFF242424),
                overflow: TextOverflow.ellipsis
              ),
              maxLines: 2,
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
          if(widget.hasEdit) ...[
            Positioned(
                right: 0,
                top: 0,
                child: Row(
                  children: [
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: SvgPicture.asset(
                        Svgs.edit,
                        height: 18,
                      ),
                      onPressed: () {
                        widget.onEditProduct();
                      },
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: SvgPicture.asset(
                        Svgs.remove,
                        height: 18,
                      ),
                      onPressed: () {
                        onDeleteProduct(
                        () {
                          Navigator.pop(context);
                          widget.onDeleteProduct();
                        });
                      },
                    )
                  ],
                )
            )
          ],
          if(widget.hasDeliveryStatus) ...[
            Positioned(
              right: 0,
              top: 0,
              child: CupertinoButton(
                onPressed: widget.hasChangeDeliveryStatus == true
                    && widget.deliveryStatus != 'SUCCESS' ? () {
                  showUpdateStatus();
                } : null,
                child: SvgPicture.asset(
                  Svgs.delivery,
                  width: 16,
                  color: widget.deliveryStatus == 'SUCCESS' ?
                  Colors.green : Colors.red,
                ),
              ),
            )
          ]
        ],
      ),
    );
  }

  Future<void> showUpdateStatus() async {
    await showPlatformDialog(
      context: context,
      builder: (context) => BasicDialogAlert(
        content: Text(
          '${getConstant('Change_delivery_status_to_successful')}?',
          style: TextStyles.s17w600,
        ),
        actions: <Widget>[
          BasicDialogAction(
            title: Text(getConstant('Yes')),
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                widget.deliveryStatus = 'SUCCESS';
              });
              widget.onUpdateStatus();
            },
          ),
          BasicDialogAction(
            title: Text(getConstant('No')),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Future<void> onDeleteProduct(onDelete) async {
    await showPlatformDialog(
      context: context,
      builder: (context) => BasicDialogAlert(
        content: Text(
          "${getConstant('Do_you_really_want_to_delete')} ${widget.title}?",
          style: TextStyles.s17w600,
        ),
        actions: <Widget>[
          BasicDialogAction(
            title: Text(getConstant('Yes')),
            onPressed: () {
              Navigator.pop(context);
              onDelete();
            },
          ),
          BasicDialogAction(
            title: Text(getConstant('No')),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
