import 'package:app_moviles3/Screens/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final _formKey = GlobalKey<FormState>();
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/login.png", height: 300),
                Text(
                  "Login/Acceso", 
                  style: TextStyle(
                    fontSize: 28, 
                    fontWeight: FontWeight.bold, 
                    color: ThemeManager.textColor 
                  )
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _emailController,
                  style: TextStyle(color: ThemeManager.textColor), 
                  keyboardType: TextInputType.emailAddress, 
                  decoration: InputDecoration(
                    labelText: "Correo electronico", 
                    labelStyle: TextStyle(color: ThemeManager.iconAndLabelColor), 
                    prefixIcon: Icon(Icons.email_outlined, color: ThemeManager.iconAndLabelColor), 
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ThemeManager.borderColor), 
                      borderRadius: const BorderRadius.all(Radius.circular(12))
                    ), 
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ThemeManager.accentColor, width: 2), 
                      borderRadius: const BorderRadius.all(Radius.circular(12))
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.redAccent),
                      borderRadius: BorderRadius.all(Radius.circular(12))
                    ),
                    focusedErrorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.redAccent, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(12))
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Por favor ingresa tu correo';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true, 
                  style: TextStyle(color: ThemeManager.textColor), 
                  decoration: InputDecoration(
                    labelText: "Contrasenia", 
                    labelStyle: TextStyle(color: ThemeManager.iconAndLabelColor), 
                    prefixIcon: Icon(Icons.lock_outline, color: ThemeManager.iconAndLabelColor), 
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ThemeManager.borderColor), 
                      borderRadius: const BorderRadius.all(Radius.circular(12))
                    ), 
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ThemeManager.accentColor, width: 2), 
                      borderRadius: const BorderRadius.all(Radius.circular(12))
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.redAccent),
                      borderRadius: BorderRadius.all(Radius.circular(12))
                    ),
                    focusedErrorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.redAccent, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(12))
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Por favor ingresa tu contrasenia';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity, 
                  height: 50, 
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeManager.accentColor, 
                      foregroundColor: Colors.black, 
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                    ), 
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                        );
                        if (context.mounted) {
                          Navigator.pushReplacementNamed(context, "/pagina3"); 
                        } 
                      } on FirebaseAuthException {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Usuario y/o contrasenia incorrectos"), 
                              backgroundColor: Colors.red
                            ),
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Error de conexion, intenta nuevamente"), 
                              backgroundColor: Colors.red
                            ),
                          );
                        }
                      }
                    }, 
                    child: const Text("Iniciar Sesion", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
                  )
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center, 
                  children: [
                    Text("¿No tienes una cuenta?", style: TextStyle(color: ThemeManager.iconAndLabelColor)), 
                    TextButton(
                      onPressed: () { 
                        Navigator.pushNamed(context, "/pagina2"); 
                      }, 
                      child: Text("Registrate", style: TextStyle(color: ThemeManager.accentColor, fontWeight: FontWeight.bold)) 
                    )
                  ]
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
