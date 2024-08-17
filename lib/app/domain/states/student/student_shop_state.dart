import 'package:european_university_app/app/app.dart';
import 'package:european_university_app/app/domain/models/user.dart';
import 'package:european_university_app/app/domain/services/shop_servcie.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:european_university_app/app/ui/widgets/center_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:liqpay/liqpay.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../ui/utils/show_message.dart';
import '../../models/meta.dart';
import '../../models/shop.dart';

class StudentShopState with ChangeNotifier {
  BuildContext context;
  bool _isLoading = true;
  ListProducts? _listProducts;
  ListUserData? _schoolList;
  Map<String, dynamic>? _filterSchool;

  StudentShopState(this.context){
    Future.microtask(() {
      fetchListProduct();
      fetchMeta();
    });
  }

  bool get isLoading => _isLoading;
  ListProducts? get listProducts => _listProducts;
  ListUserData? get schoolList => _schoolList;
  Map<String, dynamic>? get filterSchool => _filterSchool;


  void changeFilter(value)
  {
    _filterSchool = value;
    notifyListeners();
    fetchListProduct();
  }

  Future<void> fetchMeta() async{
    _isLoading = true;
    notifyListeners();
    try{
      final result = await ShopService.fetchMeta(
          context
      );
      if(result != null){
        _schoolList = result;
      }

    }catch (e){
      print(e);
    }finally{
      _isLoading = false;
      if(context.mounted){
        notifyListeners();
      }
    }
  }


  Future<void> fetchListProduct() async{
    _isLoading = true;
    notifyListeners();
    try{
      final result = await ShopService.fetchListProduct(
          context,
          _filterSchool?['id']
      );
      if(result != null){
        _listProducts = result;
      }
    }catch (e){
      print(e);
    }finally{
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> payProduct(int? productId, String? paymentType) async {
    _isLoading = true;
    notifyListeners();
    try{
      if(paymentType == 'money'){
        final result = await ShopService.fetchLiqPayCred(context, productId);
        if(result != null){
          if(result.cred == null){
            showMessage(
                getConstant('Payment_not_possible._Please_contact_your_school_administrator_to_set_up_payment_details.'),
                color: const Color(0xFFFFC700)
            );
          }else{
            openPayWeb(result.cred, result.orderReference, result.product);
          }
        }
      }else{
        final result = await ShopService.payProductEtm(
            context,
            productId
        );
        if(result != null && result == true){
          openPayed();
        }else{
          showMessage(getConstant('Error_etm_balance'));
        }
      }
    }catch(e){
      print(e);
    }finally{
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> openPayWeb(LiqPayCred? cred, orderReference,  Products products) async {
    final order = LiqPayOrder(
        orderReference,
        products.priceMoney?.toDouble() ?? 1,
        '${products.name}',
        serverUrl: 'https://european-university.etmcrm.com.ua/api/callback/liqpay',
        currency: LiqPayCurrency.uah,
        language: LiqPayLanguage.uk);
    final url = await LiqPay(
        '${cred?.public}',
        '${cred?.secret}'
    ).checkout(order);
    if (context.mounted) {
      Navigator.of(context).push(
          MaterialPageRoute(
              maintainState: true,
              fullscreenDialog: true,
              builder: (context) => Scaffold(
                body: SafeArea(
                  child:  Column(
                    children: [
                      CenterHeader(title: getConstant('Shop')),
                      Expanded(
                        child: WebView(
                          initialUrl: url,
                          javascriptMode: JavascriptMode.unrestricted,
                          onWebViewCreated: (WebViewController webViewController) {

                          },
                          navigationDelegate: (NavigationRequest request) {
                            return NavigationDecision.navigate;
                          },
                        ),
                      )
                    ],
                  ),
                ),
              )
          )
      ).whenComplete(() async {
        openPayed();
      });
    }
  }

  void openPayed(){
    Navigator.pop(context);
  }

  void back(){
    Navigator.pop(context);
  }

  void updateUser(){
    context.read<AppState>().getUser();
  }

}