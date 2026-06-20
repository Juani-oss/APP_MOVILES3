import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  void irLogin(BuildContext context) {
    Navigator.pushNamed(context, "/LoginScreen");
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/home.png", height: 300),
              SizedBox(height: 60),
              SizedBox(width: 220, height: 50, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), onPressed: () { Navigator.pushNamed(context, "/pagina1"); }, child: Text("Ingresar", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))))],
          ),
        ),
      );
    }
  }