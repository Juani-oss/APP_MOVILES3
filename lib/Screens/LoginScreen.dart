import 'package:flutter/material.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  // *** CREDENCIALES QUEMADAS ***
  static const String _usuarioValido = "admin@cine.com";
  static const String _passwordValida = "1234";

  void _iniciarSesion() {
    if (_emailController.text == _usuarioValido &&
        _passController.text == _passwordValida) {
      Navigator.pushNamed(context, "/pagina3");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Usuario o contraseña incorrectos")),
      );
    }
  }

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
              TextField(controller: _emailController, style: TextStyle(color: Colors.white), keyboardType: TextInputType.emailAddress, decoration: InputDecoration(labelText: "Correo electrónico", labelStyle: TextStyle(color: Colors.white70), prefixIcon: Icon(Icons.email_outlined, color: Colors.white70), enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white38), borderRadius: BorderRadius.circular(12)), focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.amber, width: 2), borderRadius: BorderRadius.circular(12)))),
              SizedBox(height: 20),
              TextField(controller: _passController, obscureText: true, style: TextStyle(color: Colors.white), decoration: InputDecoration(labelText: "Contraseña", labelStyle: TextStyle(color: Colors.white70), prefixIcon: Icon(Icons.lock_outline, color: Colors.white70), enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white38), borderRadius: BorderRadius.circular(12)), focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.amber, width: 2), borderRadius: BorderRadius.circular(12)))),
              SizedBox(height: 40),
              SizedBox(width: double.infinity, height: 50, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), onPressed: _iniciarSesion, child: Text("Iniciar Sesión", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))),
              SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text("¿No tienes una cuenta?", style: TextStyle(color: Colors.white70)), TextButton(onPressed: () { Navigator.pushNamed(context, "/pagina2"); }, child: Text("Regístrate", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)))])
            ],
          ),
        ),
      ),
    );
  }
}
