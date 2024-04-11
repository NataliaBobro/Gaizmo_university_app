import 'package:dio/dio.dart';
import 'package:european_university_app/app/domain/services/user_service.dart';
import 'package:european_university_app/app/ui/utils/show_message.dart';
import 'package:european_university_app/app/ui/widgets/snackbars.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
import 'domain/services/auth_service.dart';
import 'domain/services/meta_service.dart';
import 'ui/navigation/route_observer.dart';
import 'ui/navigation/routes.dart';
import 'ui/theme/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
  ConstantsList? _constantsList;

  AppState(this.context) {
    _isLoggedIn = token != null && token != '';
    Future.microtask(() async {
      if(_isLoggedIn){
        if(_userData == null){
          await getUser();
          await initFirebase();
        }else{
          onChangeRoute();
        }
      }else{
        fetchConstant(languageId: 1);
      }
    });
  }

  bool get isLoggedIn => _isLoggedIn;
  RouteMap get currentRoute => _currentRoute;
  MetaAppData? get metaAppData => _metaAppData;
  UserData? get userData => _userData;
  ConstantsList? get constantsList => _constantsList;
  FirebaseMessaging messaging = FirebaseMessaging.instance;

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
          fetchConstant(languageId: result.languageId ?? 1).then((value) {
            onChangeRoute();
          });
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

  Future<void> fetchConstant({int languageId = 1}) async {
    try {
      final result = await MetaService.fetchConstant(languageId);
      if(result != null){
        _constantsList = result;
        await Hive.box('constants').clear();
        for(var a = 0; a < (_constantsList?.data.length ?? 0); a++){
          final constant = _constantsList?.data[a];
          await Hive.box('constants').put(constant?.constant, constant?.value);
        }
      }
    } on DioError catch (e) {
      showMessage(e.message.isEmpty ? e.toString() : e.message);
      onLogout();
    } catch (e) {
      print(e);
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
    fetchConstant(languageId: id);

    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setString('languageCode', locale.languageCode);
    notifyListeners();
  }

  void initWhiteTheme(){
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
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


  Future<void> getRequestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  Future<void> initFirebase() async {
    await getRequestPermission().then((value) {
      messaging.getToken().then((token) async {
        if(token != null){
          await saveDeviceToken(token);
          debugPrint("Save Device Token: $token");
        }
      });
    });
  }

  Future<void> saveDeviceToken(String? token) async {
    try {
      await AuthService.saveFcmToken(context, token);
    } on DioError catch (e) {
      showMessage(e.message.isEmpty ? e.toString() : e.message);
    } catch (e) {
      showErrorSnackBar(title: 'Ошибка повторите попытку позже!');
    }
  }

  void pressHome() {
    routemaster.pop('close');
  }

  void onLogout() async {
    notifyListeners();
    fetchConstant(languageId: 1);
    await Hive.box('settings').delete('token');
    changeLogInState(false);
  }

  void deleteAccount({int? userId}) async {
    final id = userId ?? userData?.id;
    try {
      final result = await UserService.deleteAccount(context, id);
      if(result == true){
        notifyListeners();
        if(userId == null){
          await Hive.box('settings').delete('token');
          changeLogInState(false);
        }
      }
    } on DioError catch (e) {
      showMessage(e.message.isEmpty ? e.toString() : e.message);
    } catch (e) {
      showErrorSnackBar(title: 'Ошибка повторите попытку позже!');
    }
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
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('uk', 'UA'),
            ],
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
