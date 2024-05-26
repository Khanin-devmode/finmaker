import 'package:finmaker/features/auth/presentation/login_page.dart';
import 'package:finmaker/features/clients/presentation/clients_page.dart';
import 'package:finmaker/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'features/auth/data/auth_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit()..checkAuthStatus(),
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
        ),
        // home: BlocProvider(
        //   create: (context) => AuthCubit()..checkAuthStatus(),
        //   child: const LoginPage(),
        // ),
        routerConfig: _router,
      ),
    );
  }
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return LoginPage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'clients',
          builder: (BuildContext context, GoRouterState state) {
            return const ClientsPage();
          },
        ),
      ],
    ),
  ],
);
