import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/App/Router/app_router.dart';
import 'package:frontend/Features/Admin/presentation/Bloc/admin_bloc.dart';
import 'package:frontend/Features/Admin/presentation/Screen/add_map.dart';
import 'package:frontend/Features/Authentication/Presentation/Bloc/auth_bloc.dart';
import 'package:frontend/Features/Home/Presentation/Bloc/home_bloc.dart';
import 'package:frontend/Features/Home/Presentation/Page/Home.dart';
import 'package:frontend/Features/Travel_Route/Presentation/bloc/navigation_bloc.dart';
import 'App/Dependency_Injection/dependency_injection.dart' as di;

void main() async {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<AuthBloc>()),
        BlocProvider(
          create: (context) => di.sl<HomeBloc>(),
          child: const Home(),
        ),
        BlocProvider(
          create: (context) => di.sl<AdminBloc>(),
          child: const AddMap(),
        ),
        BlocProvider(
          create: (context) => di.sl<NavigationBloc>(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        navigatorKey: AppRouter.navigatorKey,
        initialRoute: "onboarding_screen",
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
