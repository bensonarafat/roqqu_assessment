import 'package:flutter/material.dart';
import 'package:roqqu_assessment/config/router/router.dart';
import 'package:roqqu_assessment/config/theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.lightTheme(),
      themeMode: ThemeMode.system,
      darkTheme: AppTheme.darkTheme(),
      title: "Roqqu Assessment",
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
  }
}
