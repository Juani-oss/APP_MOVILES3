import 'package:flutter/material.dart';

class Registroscreen extends StatelessWidget {
  const Registroscreen({super.key});

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
                Image.asset("assets/home.png", height: 300),
                SizedBox(height: 30),
                TextField(style: TextStyle(color: Colors.white), decoration: InputDecoration(labelText: "Nombre completo", labelStyle: TextStyle(color: Colors.white70), prefixIcon: Icon(Icons.person_outline, color: Colors.white70), enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white38), borderRadius: BorderRadius.circular(12)), focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.amber, width: 2), borderRadius: BorderRadius.circular(12)))),
                SizedBox(height: 15),
                TextField(style: TextStyle(color: Colors.white), keyboardType: TextInputType.emailAddress, decoration: InputDecoration(labelText: "Correo electrónico", labelStyle: TextStyle(color: Colors.white70), prefixIcon: Icon(Icons.email_outlined, color: Colors.white70), enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white38), borderRadius: BorderRadius.circular(12)), focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.amber, width: 2), borderRadius: BorderRadius.circular(12)))),
                SizedBox(height: 15),
                TextField(obscureText: true, style: TextStyle(color: Colors.white), decoration: InputDecoration(labelText: "Contraseña", labelStyle: TextStyle(color: Colors.white70), prefixIcon: Icon(Icons.lock_outline, color: Colors.white70), enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white38), borderRadius: BorderRadius.circular(12)), focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.amber, width: 2), borderRadius: BorderRadius.circular(12)))),
                SizedBox(height: 30),
                SizedBox(width: double.infinity, height: 50, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), onPressed: () { print("Cuenta creada..."); }, child: Text("Registrarse", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))),
                SizedBox(height: 20),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text("¿Ya tienes cuenta?", style: TextStyle(color: Colors.white70)), TextButton(onPressed: () { Navigator.pushNamed(context, "/pagina1"); }, child: Text("Inicia sesión", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)))])
              ],
            ),
          ),
        ),
      );
    }
  }