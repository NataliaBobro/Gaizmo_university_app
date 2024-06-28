import 'package:european_university_app/app/domain/states/news/news_state.dart';
import 'package:european_university_app/app/domain/states/school/school_schedule_state.dart';
import 'package:european_university_app/app/domain/states/school/school_staff_state.dart';
import 'package:european_university_app/app/domain/states/student/student_schedule_state.dart';
import 'package:european_university_app/app/domain/states/teacher/teacher_schedule_state.dart';
import 'package:european_university_app/app/ui/screens/auth/auth_sign_in.dart';
import 'package:european_university_app/app/ui/screens/auth/widgets/auth_select_login_type.dart';
import 'package:european_university_app/app/ui/screens/chats/chats_screen.dart';
import 'package:european_university_app/app/ui/screens/news/news_screen.dart';
import 'package:european_university_app/app/ui/screens/school/profile/school_profile_screen.dart';
import 'package:european_university_app/app/ui/screens/school/schedule/school_schedule_screen.dart';
import 'package:european_university_app/app/ui/screens/school/service/school_service_screen.dart';
import 'package:european_university_app/app/ui/screens/school/staff/staff_screen.dart';
import 'package:european_university_app/app/ui/screens/students/schedule/student_schedule_screen.dart';
import 'package:european_university_app/app/ui/screens/teacher/profile/teacher_profile_scroll_page.dart';
import 'package:european_university_app/app/ui/screens/teacher/service/school_service_screen.dart';
import 'package:european_university_app/app/ui/utils/get_constant.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart' as routemaster;
import '../../../resources/resources.dart';
import '../../domain/states/auth_state.dart';
import '../../domain/states/school/school_profile_state.dart';
import '../../domain/states/school/school_shop_state.dart';
import '../../domain/states/services_state.dart';
import '../../domain/states/my_results_state.dart';
import '../../domain/states/student/favorite_state.dart';
import '../../domain/states/student/student_groups_state.dart';
import '../../domain/states/student/student_home_state.dart';
import '../../domain/states/teacher/teacher_home_state.dart';
import '../screens/school/shop/school_shop_screen.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/students/favorite/favorite_screen.dart';
import '../screens/students/groups/student_groups_list.dart';
import '../screens/students/profile/student_profile_scroll_page.dart';
import '../screens/tabbar/tabbar_screen.dart';
import '../screens/teacher/schedule/teacher_schedule_screen.dart';
import '../widgets/results/my_results_screen.dart';
import 'transition_page.dart';

const _splash = '/';
const _logo = '/';
const _tabbar = '/';
const _login = '/login';
const _register = '/register';
const _auth = '/auth';
const _home = '/home';
const _studentGroup = '/student-group';
const _services = '/services';
const _servicesTeacher = '/services-teacher';
const _schedule = '/schedule';
const _studentSchedule = '/student-schedule';
const _teacherSchedule = '/teacher-schedule';
const _staff = '/staff';
const _myResults = '/my-results';
const _studentFavorite = '/student-favorite';
const _chats = '/chats';
const _news = '/news';
const _schoolShop = '/school-shop';

abstract class AppRoutes {
  static String get tabbar => _tabbar;
  static String get logo => _logo;
  static String get login => _login;
  static String get auth => _auth;
  static String get register => _register;
  static String get home => _home;
  static String get news => _news;
  static String get services => _services;
  static String get schedule => _schedule;
  static String get staff => _staff;
  static String get studentGroup => _studentGroup;
  static String get studentSchedule => _studentSchedule;
  static String get teacherSchedule => _teacherSchedule;
  static String get myResults => _myResults;
  static String get servicesTeacher => _servicesTeacher;
  static String get studentFavorite => _studentFavorite;
  static String get chats => _chats;
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
    _auth: (_) => TransitionPage(
      child: ChangeNotifierProvider(
        create: (context) => AuthState(context),
        child: const AuthSelectLoginType(),
      ),
      popTransition: PageTransition.fadeUpwards,
    ),
    _login: (_) => TransitionPage(
      child: ChangeNotifierProvider(
        create: (context) => AuthState(context),
        child: const AuthSignIn(),
      ),
      popTransition: PageTransition.fadeUpwards,
    )
  },
);

final loggedSchoolInMap = routemaster.RouteMap(
  onUnknownRoute: (_) => const routemaster.Redirect(_tabbar),
  routes: {
    _tabbar: (info) => routemaster.TabPage(
      paths: const [_home, _services, _schedule, _staff, _news, _schoolShop],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => SchoolProfileState(context),
          ),
        ],
        child: TabBarScreen(
            icons: [
              {'icon': Svgs.homeIcon, 'name': getConstant('Profile')},
              {'icon': Svgs.service, 'name': getConstant('Services')},
              {'icon': Svgs.schedule, 'name': getConstant('Schedule')},
              {'icon': Svgs.profile, 'name': getConstant('Staff')},
              {'icon': Svgs.statistics, 'name': getConstant('News')},
              {'icon': Svgs.shop, 'name': getConstant('Shop')},
            ]
        ),
      ),
    ),
    _home: (_) => TransitionPage(
      child: ChangeNotifierProvider(
        create: (context) => SchoolProfileState(context),
        child: const SchoolProfileScreen(),
      ),
    ),
    _services: (_) => TransitionPage(
      child: ChangeNotifierProvider(
        create: (context) => ServicesState(context),
        child: const SchoolServicesScreen(),
      ),
    ),
    _schedule: (_) => TransitionPage(
      child: ChangeNotifierProvider(
        create: (context) => SchoolScheduleState(context),
        child: const SchoolScheduleScreen(),
      ),
    ),
    _staff: (_) => TransitionPage(
      child: ChangeNotifierProvider(
        create: (context) => SchoolStaffState(context),
        child: const StaffScreen(),
      ),
    ),
    _news: (_) => TransitionPage(
      child: ChangeNotifierProvider(
        create: (context) => NewsState(context),
        child: const NewsScreen(),
      ),
    ),
    _schoolShop: (_) => TransitionPage(
      child: ChangeNotifierProvider(
        create: (context) => SchoolShopState(context),
        child: const SchoolShopScreen(),
      ),
    ),
  },
);



final loggedTeacherInMap = routemaster.RouteMap(
  onUnknownRoute: (_) => const routemaster.Redirect(_tabbar),
  routes: {
    _tabbar: (info) => routemaster.TabPage(
          paths: const [_home, _teacherSchedule, _servicesTeacher, _myResults],
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => TeacherHomeState(context),
              ),
            ],
            child: TabBarScreen(
              icons: [
                {'icon': Svgs.profile, 'name': getConstant('Profile')},
                {'icon': Svgs.schedule, 'name': getConstant('Schedule')},
                {'icon': Svgs.service, 'name': getConstant('Services')},
                {'icon': Svgs.myRes, 'name': getConstant('Results')},
              ]
            ),
          ),
        ),
    _home: (_) => const TransitionPage(
      child: TeacherProfileScrollPage(),
    ),
    _teacherSchedule: (_) => TransitionPage(
      child: ChangeNotifierProvider(
        create: (context) => TeacherScheduleState(context),
        child: const TeacherScheduleScreen(),
      ),
    ),
    _servicesTeacher: (_) => TransitionPage(
      child: ChangeNotifierProvider(
        create: (context) => ServicesState(context),
        child: const TeacherServicesScreen(),
      ),
    ),
    _myResults: (_) => TransitionPage(
      child: ChangeNotifierProvider(
        create: (context) => MyResultsState(context, true),
        child: const MyResultsScreen(),
      ),
    ),
  },
);

final loggedStudentInMap = routemaster.RouteMap(
  onUnknownRoute: (_) => const routemaster.Redirect(_tabbar),
  routes: {
    _tabbar: (info) => routemaster.TabPage(
          paths: const [_home, _studentSchedule, _studentGroup, _myResults, _news, _chats],
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => StudentHomeState(context),
              ),
            ],
            child: TabBarScreen(
              icons: [
                {'icon': Svgs.profile, 'name': getConstant('Profile')},
                {'icon': Svgs.schedule, 'name': getConstant('Schedule')},
                {'icon': Svgs.school, 'name': getConstant('Groups')},
                {'icon': Svgs.myRes, 'name': getConstant('My_results')},
                {'icon': Svgs.statistics, 'name': getConstant('News')},
                {'icon': Svgs.chats, 'name': getConstant('Chats')},
              ]
            ),
          ),
        ),
    _home: (_) => const TransitionPage(
      child: StudentProfileScrollPage(),
    ),
    _studentSchedule: (_) => TransitionPage(
      child: ChangeNotifierProvider(
        create: (context) => StudentScheduleState(context),
        child: const StudentScheduleScreen(),
      ),
    ),
    _studentGroup: (_) => TransitionPage(
      child: ChangeNotifierProvider(
        create: (context) => StudentGroupsState(context),
        child: const StudentGroupsList(),
      ),
    ),
    _myResults: (_) => TransitionPage(
      child: ChangeNotifierProvider(
        create: (context) => MyResultsState(context, false),
        child: const MyResultsScreen(),
      ),
    ),
    _studentFavorite: (_) => TransitionPage(
      child: ChangeNotifierProvider(
        create: (context) => FavoriteState(context),
        child: const FavoriteScreen(),
      ),
    ),
    _chats: (_) => const TransitionPage(
      child: ChatsScreen(),
    ),
    _news: (_) => TransitionPage(
      child: ChangeNotifierProvider(
        create: (context) => NewsState(context),
        child: const NewsScreen(),
      ),
    ),
  },
);
