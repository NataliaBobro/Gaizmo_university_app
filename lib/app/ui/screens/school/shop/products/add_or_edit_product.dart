import 'package:european_university_app/app/domain/states/school/school_shop_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../utils/get_constant.dart';
import '../../../../widgets/app_field.dart';
import '../../../../widgets/auth_button.dart';
import '../../../../widgets/center_header.dart';
import '../../../../widgets/dropzone.dart';

class AddOrEditProduct extends StatefulWidget {
  const AddOrEditProduct({
    super.key
  });

  @override
  State<AddOrEditProduct> createState() => _AddOrEditProductState();
}

class _AddOrEditProductState extends State<AddOrEditProduct> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<SchoolShopState>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ColoredBox(
            color: const Color(0xFFF0F3F6),
            child: Column(
              children: [
                CenterHeader(
                    title: getConstant('Product')
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
                            AppField(
                                label: getConstant('Product_name'),
                                controller: state.productName,
                                error: state.validateError?.errors.name?.first,
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            AppField(
                                label: getConstant('Product_description'),
                                controller: state.productDescription,
                              error: state.validateError?.errors.desc?.first,
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: AppField(
                                      label: getConstant('Price_etm'),
                                      controller: state.priceEtm
                                  ),
                                ),
                                const SizedBox(
                                  width: 50,
                                ),
                               Expanded(
                                 child:  AppField(
                                     label: getConstant('price_money'),
                                     controller: state.priceMoney
                                 ),
                               ),
                              ],
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Dropzone(
                              uploadedImage: state.imageUrl,
                              selectImage: (image){
                                state.selectImage(image);
                              },
                              file: state.uploadsFile,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: AppButton(
                      title: getConstant('SAVE_CHANGES'),
                      onPressed: () {
                        state.saveProduct();
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
