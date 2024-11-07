import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:prueba/config/error_state.dart';
import 'package:prueba/modules/home.dart';
import 'package:prueba/modules/login_screen.dart';
import 'package:prueba/navigation/navigation.dart';
import 'firebase_options.dart';
import 'package:prueba/modules/register_screen.dart';
import 'package:prueba/modules/registrar_gasto.dart';

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
    return ChangeNotifierProvider(
      create: (context) => ErrorState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginScreen(),
          '/home': (context) => const Home(),
          '/register':(context) => const RegisterScreen(),
          '/navigation': (context) => const Navigation(),
          '/registrar-gasto': (context)=> const RegistrarGasto()
        },
      ),
    );
  }
}
