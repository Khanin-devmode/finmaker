import 'package:finmaker/features/auth/presentation/login_page.dart';
import 'package:finmaker/features/clients/data/client_form_cubit.dart';
import 'package:finmaker/features/clients/data/client_cubit.dart';
import 'package:finmaker/features/clients/presentation/client_detail_page.dart';
import 'package:finmaker/features/clients/presentation/clients_page.dart';
import 'package:finmaker/features/policies/data/policy_cubit.dart';
import 'package:finmaker/features/policies/data/policy_form_cubit.dart';
import 'package:finmaker/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'features/auth/data/auth_cubit.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  usePathUrlStrategy();
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()..checkAuthStatus()),
        BlocProvider(create: (context) => ClientFormCubit()),
        BlocProvider(create: (context) => ClientCubit()),
        BlocProvider(create: (context) => PolicyFormCubit()),
        BlocProvider(create: (context) => PolicyCubit()),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
        ),
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
        return const LoginPage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'clients',
          builder: (BuildContext context, GoRouterState state) {
            return const ClientsPage();
          },
        ),
        GoRoute(
          path: 'client-detail/:id',
          builder: (BuildContext context, GoRouterState state) {
            final id = state.pathParameters['id'];

            return ClientDetailPage(
              clientId: id!,
            );
          },
        ),
      ],
    ),
  ],
);
