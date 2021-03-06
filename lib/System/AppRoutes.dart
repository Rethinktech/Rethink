// ignore_for_file: file_names

import 'package:qlevar_router/qlevar_router.dart';
import 'package:rethink/Screens/HomeScreen.dart';
import 'package:rethink/Screens/ItemInfoScreen.dart';
import 'package:rethink/Screens/SignInScreen.dart';
import 'package:rethink/Screens/UserManualScreen.dart';
import 'package:rethink/Screens/TraceabilityScreen.dart';
import 'package:rethink/Screens/UserProfileScreen.dart';



class AppRoutes {
  // 0555daf0-0f91-11ec-a929-09b6e71c5bab
  static String itemID = '';
  /* static const nested = 'Nested';
  static const nestedChild = 'Nested Child';
  static const nestedChild1 = 'Nested Child 1';
  static const nestedChild2 = 'Nested Child 2';
  static const nestedChild3 = 'Nested Child 3'; */

  ///
/*   static const app = 'App';
  static const home = 'Home';
  static const settings = 'Settings';
  static const login = 'Login'; */

  static String itemInformation = 'ItemInformation';
  static String userManual = 'UserManual';
  static String traceability = 'Traceability';
  static String eStore = 'Estore';
  static String signIn = 'SignIn';
  static String userProfile = 'UserProfile';

  List<QRoute> routes() => [
    //QRoute(path: '/', builder: () => const SplahScreen()),
    //QRoute(path: '/overlays', builder: () => OverlaysPage()),
    /* QRoute.declarative(
        path: '/declarative',
        declarativeBuilder: (k) => DeclarativePage(k)),
    ParentRoutes().route(), */
    QRoute(
        path: '/:id',
        pageType: const QFadePage(),
        builder: () => const HomeScreen()),
    QRoute(
        name: itemInformation ,
        path: '/ItemInformation',
        pageType: const QFadePage(),
        builder: () => const ItemInfoScreen()),
    QRoute(
        name: userManual ,
        path: '/UserManual',
        pageType: const QFadePage(),
        builder: () => const UserManual()),
    QRoute(
        name: traceability ,
        path: '/Traceability',
        pageType: const QFadePage(),
        builder: () => const TraceabilityScreen()),
    QRoute(
        name: eStore ,
        path: '/ + $eStore',
        pageType: const QFadePage(),
        builder: () => const ItemInfoScreen()),
    QRoute(
        name: signIn ,
        path: '/SignIn',
        pageType: const QFadePage(),
        builder: () => const SignInScreen()),
     QRoute(
        name: userProfile ,
        path: '/UserProfile',
        pageType: const QFadePage(),
        builder: () => const UserProfileScreen()),
    /* QRoute(
        path: '/:id',
        pageType: const QFadePage(),
        builder: () => TextPage('the id is ${QR.params['id']}')), */
    /* QRoute(
    path: '/params',
    builder: () => TextPage(
      // ignore: lines_longer_than_80_chars
      'params are: test is${QR.params['test']} and go is ${QR.params['go']}',
      extra: [
        TextButton(
            onPressed: () => QR.to(
                "/params?test=${Random().nextInt(1000)}&go=${Random().nextInt(1000)}"),
            child: Text('New param')),
        TextButton(
            onPressed: () =>
                QR.to(QR.currentPath, ignoreSamePath: false),
            child: Text('Refresh'))
      ],
    )), */
    /* QRoute.withChild(
    path: '/add-remove-routes',
    builderChild: (child) => AddRemoveRoutes(child),
    initRoute: '/child',
    children: [
      QRoute(path: '/child', builder: () => AddRemoveChild('Hi child')),
      QRoute(
          path: '/child-1',
          builder: () => AddRemoveChild('Hi child 1')),
      QRoute(
          path: '/child-2',
          builder: () => AddRemoveChild('Hi child 2')),
      QRoute(
          path: '/child-3',
          builder: () => AddRemoveChild('Hi child 3')),
    ]), */
/* QRoute.withChild(
    name: nested,
    path: '/nested',
    builderChild: (r) => NestedRoutePage(r),
    initRoute: '/child',
    children: [
      QRoute(
          name: nestedChild,
          path: '/child',
          builder: () => NestedChild('child')),
      QRoute(
          name: nestedChild1,
          path: '/child-1',
          builder: () => NestedChild('child 1'),
          pageType: QSlidePage()),
      QRoute(
          name: nestedChild2,
          path: '/child-2',
          builder: () => NestedChild('child 2')),
      QRoute(
          name: nestedChild3,
          path: '/child-3',
          builder: () => NestedChild('child 3')),
    ]), */
  ];
}