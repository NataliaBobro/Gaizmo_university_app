import 'package:dio/dio.dart';
import 'package:etm_crm/app/domain/services/user_service.dart';
import 'package:etm_crm/app/ui/utils/show_message.dart';
import 'package:etm_crm/app/ui/widgets/snackbars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sizer/sizer.dart';
import 'domain/models/meta.dart';
import 'domain/models/user.dart';
import 'domain/services/meta_service.dart';
import 'ui/navigation/route_observer.dart';
import 'ui/navigation/routes.dart';
import 'ui/theme/app_theme.dart';

final routemaster = RoutemasterDelegate(
  observers: [MyRouteObserver()],
  routesBuilder: (context) {
    final appState = context.watch<AppState>();
    return appState.currentRoute;
  },
);

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class AppState extends ChangeNotifier {
  final token = Hive.box('settings').get('token', defaultValue: null);

  late bool _isLoggedIn;
  MetaAppData? _metaAppData;
  RouteMap _currentRoute = splashMap;
  UserData? _userData;
  BuildContext context;

  AppState(this.context) {
    _isLoggedIn = token != null && token != '';
    Future.microtask(() async {
      if(_isLoggedIn){
        if(_userData == null){
         await getUser();
        }
        onChangeRoute();
      }
    });
  }

  bool get isLoggedIn => _isLoggedIn;
  RouteMap get currentRoute => _currentRoute;
  MetaAppData? get metaAppData => _metaAppData;
  UserData? get userData => _userData;

  Future<void> changeLogInState(bool value) async {
    _isLoggedIn = value;
    if(value == true){
      getUser();
    }
    onChangeRoute();
    notifyListeners();
  }

  Future<void> setUser(UserData user) async {
    _userData = user;
    notifyListeners();
  }

  Future<void> getUser() async {
    try {
      final result = await UserService.getUser(context);
      if(result != null){
        _userData = result;
        if(metaAppData == null){
          getMeta(result.languageId);
        }
      }
    } on DioError catch (e) {
      showMessage(e.message.isEmpty ? e.toString() : e.message);
      onLogout();
    } catch (e) {
      showErrorSnackBar(title: 'App request error');
    } finally {
      notifyListeners();
    }
  }

  Future<void> getMeta(langId) async {
    try {
      final result = await MetaService.fetchMeta();
      if(result != null){
        _metaAppData = result;
      }
    } on DioError catch (e) {
      showMessage(e.message.isEmpty ? e.toString() : e.message);
    } catch (e) {
      print(e);
      showErrorSnackBar(title: 'App request error');
    } finally {
      notifyListeners();
    }
  }


  void onChangeRoute({RouteMap? route}) {
    if (route == null) {
      if(_isLoggedIn){
        initWhiteTheme();
        if(_userData?.type == 1){
          _currentRoute = loggedSchoolInMap;
        }else if(_userData?.type == 2){
          _currentRoute = loggedTeacherInMap;
        }else if(_userData?.type == 3){
          _currentRoute = loggedStudentInMap;
        }
      }else{
        _currentRoute = loggedOutMap;
      }
    } else {
      _currentRoute = route;
    }
    notifyListeners();
  }

  void changeLanguage(id) {
    _userData?.languageId = id;
    notifyListeners();
  }

  void initWhiteTheme(){
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ));
  }

  Future<void> openPage(BuildContext context, Widget page) async {
    await Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => ChangeNotifierProvider.value(
              value: this,
              child: page,
            )
        )
    );
  }

  void onLogout() async {
    notifyListeners();
    await Hive.box('settings').delete('token');
    changeLogInState(false);
  }

  @override
  Future<void> dispose() async {
    super.dispose();
  }
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(context),
      child: Sizer(
        builder: (context, orientaition, child) => OverlaySupport.global(
          child: MaterialApp.router(
            routerDelegate: routemaster,
            routeInformationParser: const RoutemasterParser(),
            debugShowCheckedModeBanner: false,
            scaffoldMessengerKey: scaffoldMessengerKey,
            theme: AppTheme.appTheme,

            /// to disable the system text scale.
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: child!,
              );
            },
          ),
        ),
      ),
    );
  }
}
