import 'package:flutter/material.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/login.png", height: 300),
                Text("Login/Acceso", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
                SizedBox(height: 40),
                TextField(style: TextStyle(color: Colors.white), keyboardType: TextInputType.emailAddress, decoration: InputDecoration(labelText: "Correo electrónico", labelStyle: TextStyle(color: Colors.white70), prefixIcon: Icon(Icons.email_outlined, color: Colors.white70), enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white38), borderRadius: BorderRadius.circular(12)), focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.amber, width: 2), borderRadius: BorderRadius.circular(12)))),
                SizedBox(height: 20),
                TextField(obscureText: true, style: TextStyle(color: Colors.white), decoration: InputDecoration(labelText: "Contraseña", labelStyle: TextStyle(color: Colors.white70), prefixIcon: Icon(Icons.lock_outline, color: Colors.white70), enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white38), borderRadius: BorderRadius.circular(12)), focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.amber, width: 2), borderRadius: BorderRadius.circular(12)))),
                SizedBox(height: 40),
                SizedBox(width: double.infinity, height: 50, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), onPressed: () { print("Intentando iniciar sesión..."); }, child: Text("Iniciar Sesión", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))),
                SizedBox(height: 20),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text("¿No tienes una cuenta?", style: TextStyle(color: Colors.white70)), TextButton(onPressed: () { Navigator.pushNamed(context, "/pagina2"); }, child: Text("Regístrate", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)))])
              ],
            ),
          ),
        ),
      );
    }
  }