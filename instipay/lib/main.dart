import 'package:flutter/material.dart';
import 'package:instipay/screens/main/home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';
import 'screens/login/signup.dart';
import 'screens/login/login.dart';
import 'screens/login/signin.dart';
import 'screens/main/pay.dart';
import 'services/auth.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://jnlcmfdnnrsexuszwzph.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpubGNtZmRubnJzZXh1c3p3enBoIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzE0ODMzMjIsImV4cCI6MTk4NzA1OTMyMn0.R63wWUOvhhwvMY_pPge_9zA1kPrejGkClxw4Jys6mu0',
  );

  runApp(MyApp());
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return Home();
      },
      redirect: (BuildContext context, GoRouterState state) {
        if (AuthService().redirectLogin()) {
          return '/login';
        } else {
          return null;
        }
      },
    ),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return  Login();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'signup',
          builder: (BuildContext context, GoRouterState state) {
            return SignUp();
          },
        ),
        GoRoute(
          path: 'signin',
          builder: (BuildContext context, GoRouterState state) {
            return SignIn();
          },
        ),
      ],
    ),
    GoRoute(
      path: '/pay',
      builder: (BuildContext context, GoRouterState state) {
        return Pay();
      },
    ),

  ],
);


class MyApp extends StatelessWidget {
  /// Constructs a [MyApp]
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}




