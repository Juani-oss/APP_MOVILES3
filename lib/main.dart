import 'package:app_moviles3/Screens/CarteleraScreen.dart';
import 'package:app_moviles3/Screens/DetalleScreen.dart';
import 'package:app_moviles3/Screens/HomeScreen.dart';
import 'package:app_moviles3/Screens/LoginScreen.dart';
import 'package:app_moviles3/Screens/RegistroScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const NavegacionRutas());
}

class NavegacionRutas extends StatelessWidget {
  const NavegacionRutas({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 

      initialRoute: "/pagina3",

      routes: {
        "/": (context) => const Home(),
        "/pagina1": (context) => const Loginscreen(),
        "/pagina2": (context) => const Registroscreen(),
        "/pagina3": (context) => const CarteleraScreen(),
        "/detalle":(context) => const DetalleScreen()
      },
    );
  }
}