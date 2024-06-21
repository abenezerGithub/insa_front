import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insa_report/screens/home_screen.dart';
import 'package:insa_report/screens/login_screen.dart';
import 'package:insa_report/screens/report_detail_screen.dart';
import 'package:insa_report/screens/signup_screen.dart';
import 'package:insa_report/screens/welcome_screen.dart';
import 'package:insa_report/screens/report_screen.dart';
import 'package:insa_report/services/securestore.dart';
import 'package:insa_report/theme/light_theme.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  String initialRoute = "/welcome";
  try {
    final user = await SecureStore.getUser();
    if (user == null) {
      initialRoute = "/welcome";
    } else {
      initialRoute = "/reports";
    }
  } catch (e) {
    initialRoute = "/welcome";
  } finally {
    FlutterNativeSplash.remove();
  }

  runApp(ProviderScope(
    child: MyApp(
      initialRoute: initialRoute,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightThemeData,
      initialRoute: initialRoute,
      // Define routes
      routes: {
        '/home': (context) => const HomeScreen(),
        '/report-screen': (context) => const ReportScreen(),
        '/report-detail': (context) =>  ReportDetailScreen(),
        '/reports': (context) => const HomeScreen(),
        "/login": (context) => const LoginScreen(),
        "/signup": (context) => const SignUpScreen(),
        "/welcome": (context) => const WelcomeScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
