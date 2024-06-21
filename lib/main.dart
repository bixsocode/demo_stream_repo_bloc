import 'package:demo_stream_repo_bloc/pages/post/ui/post_screen.dart';
import 'package:demo_stream_repo_bloc/routes/route_generate.dart';
import 'package:demo_stream_repo_bloc/routes/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: false,
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: routes(),
      initialRoute: RouterName.initScreen,
      navigatorObservers: [MyNavigatorObserver()],
      home: PostScreen(),
    );
  }
}

class MyNavigatorObserver extends NavigatorObserver {
  @override
  void didPop(Route route, Route? previousRoute) {
    RouteGenerate.setSaveRouterName(
        routerName: previousRoute?.settings.name ?? '');
    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    RouteGenerate.setSaveRouterName(routerName: route.settings.name);
    super.didPush(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    RouteGenerate.setSaveRouterName(routerName: newRoute?.settings.name);
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }
}
