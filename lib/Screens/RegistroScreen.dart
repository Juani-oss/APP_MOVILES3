import 'package:app_moviles3/Screens/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class Registroscreen extends StatefulWidget {
  const Registroscreen({super.key});
  @override
  State<Registroscreen> createState() => _RegistroscreenState();
}

class _RegistroscreenState extends State<Registroscreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _cedulaController = TextEditingController();
  
  String _ciudadSeleccionada = 'Quito';
  DateTime? _fechaNacimiento;

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidoController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _telefonoController.dispose();
    _cedulaController.dispose();
    super.dispose();
  }

  Future<void> _registrarUsuario() async {
    if (!_formKey.currentState!.validate()) return;
    
    if (_fechaNacimiento == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Selecciona tu fecha de nacimiento"), backgroundColor: Colors.red),
      );
      return;
    }

    try {
      UserCredential cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      DatabaseReference ref = FirebaseDatabase.instance.ref("usuarios/${cred.user!.uid}");
      await ref.set({
        "nombre": _nombreController.text.trim(),
        "apellido": _apellidoController.text.trim(),
        "correo": _emailController.text.trim(),
        "telefono": _telefonoController.text.trim(),
        "cedula": _cedulaController.text.trim(),
        "ciudad": _ciudadSeleccionada,
        "fechaNacimiento": _fechaNacimiento!.toIso8601String(),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registro exitoso"), backgroundColor: Colors.green),
        );
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.message}"), backgroundColor: Colors.red),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error de conexión: $e"), backgroundColor: Colors.red),
      );
    }
  }

  // !!!! Metodo auxiliar con colores dinamicos del ThemeManager
  InputDecoration _buildDecoracionBasica(String etiqueta, IconData icono) {
    return InputDecoration(
      labelText: etiqueta,
      labelStyle: TextStyle(color: ThemeManager.iconAndLabelColor),
      prefixIcon: Icon(icono, color: ThemeManager.iconAndLabelColor),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ThemeManager.borderColor),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ThemeManager.accentColor, width: 2),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      errorStyle: const TextStyle(color: Colors.redAccent),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: ThemeManager.accentColor), 
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset("assets/login.png", height: 200),
              const SizedBox(height: 20),

              Text(
                "Crear Cuenta", 
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: ThemeManager.textColor)
              ),
              const SizedBox(height: 30),

              TextFormField(
                controller: _nombreController,
                style: TextStyle(color: ThemeManager.textColor),
                decoration: _buildDecoracionBasica("Nombre", Icons.person_outline),
                validator: (val) => (val?.trim().length ?? 0) < 3 ? "Mínimo 3 caracteres" : null,
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: _apellidoController,
                style: TextStyle(color: ThemeManager.textColor),
                decoration: _buildDecoracionBasica("Apellido", Icons.person_outline),
                validator: (val) => (val?.trim().length ?? 0) < 3 ? "Mínimo 3 caracteres" : null,
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: _cedulaController,
                style: TextStyle(color: ThemeManager.textColor),
                keyboardType: TextInputType.number,
                decoration: _buildDecoracionBasica("Cédula", Icons.badge_outlined),
                validator: (val) => (val?.trim().length ?? 0) < 10 ? "Mínimo 10 caracteres" : null,
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: _telefonoController,
                style: TextStyle(color: ThemeManager.textColor),
                keyboardType: TextInputType.phone,
                decoration: _buildDecoracionBasica("Teléfono", Icons.phone_android_outlined),
                validator: (val) => (val?.trim().length ?? 0) < 10 ? "Número inválido" : null,
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: _emailController,
                style: TextStyle(color: ThemeManager.textColor),
                keyboardType: TextInputType.emailAddress,
                decoration: _buildDecoracionBasica("Correo electrónico", Icons.email_outlined),
                validator: (val) => val == null || !val.contains('@') ? "Ingresa un correo válido" : null,
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: _passwordController,
                obscureText: true,
                style: TextStyle(color: ThemeManager.textColor),
                decoration: _buildDecoracionBasica("Contraseña", Icons.lock_outline),
                validator: (val) => (val?.length ?? 0) < 6 ? "La contraseña debe tener al menos 6 caracteres" : null,
              ),
              const SizedBox(height: 20),

              DropdownButtonFormField<String>(
                value: _ciudadSeleccionada,
                decoration: _buildDecoracionBasica("Ciudad", Icons.location_city_outlined),
                icon: Icon(Icons.arrow_drop_down, color: ThemeManager.accentColor),
                items: ['Quito', 'Cuenca', 'Guayaquil'].map((c) => 
                  DropdownMenuItem(value: c, child: Text(c, style: TextStyle(color: ThemeManager.textColor)))
                ).toList(),
                onChanged: (val) => setState(() => _ciudadSeleccionada = val!),
              ),
              const SizedBox(height: 20),

              InkWell(
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context, 
                    initialDate: DateTime(2000), 
                    firstDate: DateTime(1930), 
                    lastDate: DateTime.now(),
                    
                  );
                  
                  if (picked != null) {
                    DateTime hoy = DateTime.now();
                    int edad = hoy.year - picked.year;
                    if (hoy.month < picked.month || (hoy.month == picked.month && hoy.day < picked.day)) {
                      edad--;
                    }
                    
                    if (edad < 18) {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Debes ser mayor de edad para registrarte"), backgroundColor: Colors.red),
                        );
                      }
                    } else {
                      setState(() => _fechaNacimiento = picked);
                    }
                  }
                },
                child: InputDecorator(
                  decoration: _buildDecoracionBasica("Fecha de Nacimiento", Icons.calendar_today_outlined),
                  child: Text(
                    _fechaNacimiento == null 
                        ? "Seleccionar fecha" 
                        : "${_fechaNacimiento!.day.toString().padLeft(2, '0')}/${_fechaNacimiento!.month.toString().padLeft(2, '0')}/${_fechaNacimiento!.year}",
                    style: TextStyle(
                      color: _fechaNacimiento == null ? ThemeManager.iconAndLabelColor : ThemeManager.textColor, 
                      fontSize: 16
                    ),
                  ),
                ),
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
                  onPressed: _registrarUsuario, 
                  child: const Text("Registrarse", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
                )
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}