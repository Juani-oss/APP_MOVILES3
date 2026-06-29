import 'package:app_moviles3/Screens/CarteleraScreen.dart';
import 'package:app_moviles3/Screens/HomeScreen.dart';
import 'package:app_moviles3/Screens/LoginScreen.dart';
import 'package:app_moviles3/Screens/RegistroScreen.dart';
import 'package:app_moviles3/Screens/theme_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const NavegacionRutas());
}

class NavegacionRutas extends StatelessWidget {
  const NavegacionRutas({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeManager.themeMode,
      builder: (context, modoActual, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          
          theme: ThemeData.light(), 
          darkTheme: ThemeData.dark(), 
          themeMode: modoActual,
          
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator(color: Colors.amber)),
                );
              }
              if (snapshot.hasData) {
                return const CarteleraScreen();
              }
              return const Home(); 
            },
          ),
          routes: {
            "/pagina1": (context) => const Loginscreen(),
            "/pagina2": (context) => const Registroscreen(),
            "/pagina3": (context) => const CarteleraScreen(),
          },
        );
      },
    );
  }
}