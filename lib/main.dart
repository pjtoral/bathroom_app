// main.dart
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../UserLoginOrRegister/splash_page.dart';
import 'UserLoginOrRegister/forgot_password.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bathroom_app/backend/env.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(url: Env.url, anonKey: Env.anonKey);

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ForgotPasswordData())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // Use SplashPage as the home
      home: SplashPage(),
    );
  }
}
