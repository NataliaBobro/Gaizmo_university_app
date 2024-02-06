import 'package:etm_crm/app/domain/states/school/school_schedule_state.dart';
import 'package:etm_crm/app/domain/states/school/school_services_state.dart';
import 'package:etm_crm/app/domain/states/school/school_staff_state.dart';
import 'package:etm_crm/app/domain/states/student/student_schedule_state.dart';
import 'package:etm_crm/app/ui/screens/auth/auth_sign_in.dart';
import 'package:etm_crm/app/ui/screens/auth/widgets/auth_select_login_type.dart';
import 'package:etm_crm/app/ui/screens/school/profile/school_profile_screen.dart';
import 'package:etm_crm/app/ui/screens/school/schedule/school_schedule_screen.dart';
import 'package:etm_crm/app/ui/screens/school/service/school_service_screen.dart';
import 'package:etm_crm/app/ui/screens/school/staff/staff_screen.dart';
import 'package:etm_crm/app/ui/screens/students/results/my_results_screen.dart';
import 'package:etm_crm/app/ui/screens/students/schedule/student_schedule_screen.dart';
import 'package:etm_crm/app/ui/screens/students/schools/school_list.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart' as routemaster;
import '../../../resources/resources.dart';
import '../../domain/states/auth_state.dart';
import '../../domain/states/school/school_profile_state.dart';
import '../../domain/states/student/my_results_state.dart';
import '../../domain/states/student/student_school_state.dart';
import '../../domain/states/student/student_home_state.dart';
import '../../domain/states/teacher/teacher_home_state.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/students/profile/student_profile_scroll_page.dart';
import '../screens/tabbar/tabbar_screen.dart';
import '../screens/teacher/teacher_profile_screen.dart';
import 'transition_page.dart';

const _splash = '/';
const _logo = '/';
const _tabbar = '/';
const _login = '/login';
const _register = '/register';
const _auth = '/auth';
const _home = '/home';
const _studentSchool = '/student-school';
const _services = '/services';
const _schedule = '/schedule';
const _studentSchedule = '/student-schedule';
const _staff = '/staff';
const _myResults = '/my-results';

abstract class AppRoutes {
  static String get tabbar => _tabbar;
  static String get logo => _logo;
  static String get login => _login;
  static String get auth => _auth;
  static String get register => _register;
  static String get home => _home;
  static String get services => _services;
  static String get schedule => _schedule;
  static String get staff => _staff;
  static String get studentSchool => _studentSchool;
  static String get studentSchedule => _studentSchedule;
  static String get myResults => _myResults;
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
      paths: const [_home, _services, _schedule, _staff, _home],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => SchoolProfileState(context),
          ),
        ],
        child: const TabBarScreen(
            icons: [
              {'icon': Svgs.homeIcon, 'name': 'Profile'},
              {'icon': Svgs.service, 'name': 'Services'},
              {'icon': Svgs.schedule, 'name': 'Schedule'},
              {'icon': Svgs.profile, 'name': 'Staff'},
              {'icon': Svgs.statistics, 'name': 'Statistics'},
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
        create: (context) => SchoolServicesState(context),
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
  },
);



final loggedTeacherInMap = routemaster.RouteMap(
  onUnknownRoute: (_) => const routemaster.Redirect(_tabbar),
  routes: {
    _tabbar: (info) => routemaster.TabPage(
          paths: const [_home, _home, _home, _home],
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => TeacherHomeState(context),
              ),
            ],
            child: const TabBarScreen(
              icons: [
                {'icon': Svgs.profile, 'name': 'Profile'},
                {'icon': Svgs.schedule, 'name': 'Schedule'},
                {'icon': Svgs.school, 'name': 'Schools'},
                {'icon': Svgs.myRes, 'name': 'Results'},
              ]
            ),
          ),
        ),
    _home: (_) => TransitionPage(
      child: ChangeNotifierProvider(
        create: (context) => TeacherHomeState(context),
        child: const TeacherProfileScreen(),
      ),
    ),
  },
);

final loggedStudentInMap = routemaster.RouteMap(
  onUnknownRoute: (_) => const routemaster.Redirect(_tabbar),
  routes: {
    _tabbar: (info) => routemaster.TabPage(
          paths: const [_home, _studentSchedule, _studentSchool, _myResults],
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => StudentHomeState(context),
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
    _home: (_) => const TransitionPage(
      child: StudentProfileScrollPage(),
    ),
    _studentSchedule: (_) => TransitionPage(
      child: ChangeNotifierProvider(
        create: (context) => StudentScheduleState(context),
        child: const StudentScheduleScreen(),
      ),
    ),
    _studentSchool: (_) => TransitionPage(
      child: ChangeNotifierProvider(
        create: (context) => StudentSchoolState(context),
        child: const SchoolList(),
      ),
    ),
    _myResults: (_) => TransitionPage(
      child: ChangeNotifierProvider(
        create: (context) => MyResultsState(context),
        child: const MyResultsScreen(),
      ),
    ),
  },
);
