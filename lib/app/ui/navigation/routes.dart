import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart' as routemaster;
import '../../../resources/resources.dart';
import '../../domain/states/auth_state.dart';
import '../../domain/states/home_state.dart';
import '../screens/auth/widgets/auth_select_language_screen.dart';
import '../screens/students/profile/profile_screen.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/students/tabbar/tabbar_screen.dart';
import 'transition_page.dart';

const _splash = '/';
const _logo = '/';
const _tabbar = '/';
const _login = '/login';
const _register = '/register';
const _auth = '/auth';
const _home = '/home';

abstract class AppRoutes {
  static String get tabbar => _tabbar;
  static String get logo => _logo;
  static String get login => _login;
  static String get auth => _auth;
  static String get register => _register;
  static String get home => _home;
}

final splashMap = routemaster.RouteMap(
  onUnknownRoute: (_) => const routemaster.Redirect(_splash),
  routes: {
    _splash: (_) => const TransitionPage(
          child: SplashScreen(),
          popTransition: PageTransition.none,
        ),
  },
);

final loggedOutMap = routemaster.RouteMap(
  onUnknownRoute: (_) => const routemaster.Redirect(_auth),
  routes: {
    // _login: (_) => TransitionPage(
    //   child: ChangeNotifierProvider(
    //     create: (context) => AuthState(context),
    //     child: const LoginScreen(),
    //   ),
    // ),
    _auth: (_) => TransitionPage(
      child: ChangeNotifierProvider(
        create: (context) => AuthState(context),
        child: const AuthSelectLanguageScreen(),
      ),
      popTransition: PageTransition.fadeUpwards,
    ),
    // _register: (_) => TransitionPage(
    //   child: ChangeNotifierProvider(
    //     create: (context) => AuthState(context),
    //     child: const RegisterScreen(),
    //   ),
    // ),
  },
);

final loggedSchoolInMap = routemaster.RouteMap(
  onUnknownRoute: (_) => const routemaster.Redirect(_tabbar),
  routes: {
    _tabbar: (info) => routemaster.TabPage(
      paths: const [_home, _home, _home, _home],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => HomeState(context),
          ),
        ],
        child: const TabBarScreen(
            icons: [
              {'icon': Svgs.profile, 'name': 'Profile'},
              {'icon': Svgs.schedule, 'name': 'Schedule'},
              {'icon': Svgs.school, 'name': 'Schools'},
              {'icon': Svgs.myRes, 'name': 'My results'},
            ]
        ),
      ),
    ),
    _home: (_) => TransitionPage(
      child: ChangeNotifierProvider(
        create: (context) => HomeState(context),
        child: const ProfileScreen(),
      ),
    ),
  },
);



final loggedStudentInMap = routemaster.RouteMap(
  onUnknownRoute: (_) => const routemaster.Redirect(_tabbar),
  routes: {
    _tabbar: (info) => routemaster.TabPage(
          paths: const [_home, _home, _home, _home],
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => HomeState(context),
              ),
            ],
            child: const TabBarScreen(
              icons: [
                {'icon': Svgs.profile, 'name': 'Profile'},
                {'icon': Svgs.schedule, 'name': 'Schedule'},
                {'icon': Svgs.school, 'name': 'Schools'},
                {'icon': Svgs.myRes, 'name': 'My results'},
              ]
            ),
          ),
        ),
    _home: (_) => TransitionPage(
      child: ChangeNotifierProvider(
        create: (context) => HomeState(context),
        child: const ProfileScreen(),
      ),
    ),
  },
);
