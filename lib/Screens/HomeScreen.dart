import 'package:app_moviles3/Screens/theme_manager.dart';
import 'package:flutter/material.dart';

// !!!! NOTA PARA EL EQUIPO: Para usar los colores dinamicos y que la app 
// no se quede en negro, importen el archivo ThemeManager global arriba.

class Home extends StatelessWidget {
  // !!!! Mantengan sus constructores limpios. 
  // Ya NO pasamos variables por aqui para evitar conflictos de codigo en Git.
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // !!!! Ya no calculamos colores manuales aqui adentro. Todo viene del ThemeManager.

    return Scaffold(
      // !!!! Eviten poner 'backgroundColor: Colors.black' directo en el Scaffold.
      // El fondo se adaptara solo usando ThemeManager o ScaffoldBackgroundColor.
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            // !!!! Usamos la variable global de gradiente que creamos
            colors: ThemeManager.backgroundGradient,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 10,
                right: 20,
                child: IconButton(
                  // !!!! El icono revisa automaticamente si esta en modo oscuro
                  icon: Icon(
                    ThemeManager.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                    color: ThemeManager.isDarkMode ? ThemeManager.accentColor : Colors.indigo,
                    size: 28,
                  ),
                  onPressed: () {
                    // !!!! Para cambiar el tema desde cualquier boton, solo pongan esta linea:
                    ThemeManager.toggleTheme();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/home.png", height: 250),
                    const SizedBox(height: 30),
                    Text(
                      "Bienvenido a Cine Star",
                      style: TextStyle(
                        fontSize: 32, 
                        fontWeight: FontWeight.bold, 
                        // !!!! Reemplacen Colors.white fijo por textColor para titulos
                        color: ThemeManager.textColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Tu experiencia de cine favorita, en la palma de tu mano.",
                      textAlign: TextAlign.center,
                      // !!!! Reemplacen grises fijos por iconAndLabelColor para subtitulos
                      style: TextStyle(fontSize: 16, color: ThemeManager.iconAndLabelColor),
                    ),
                    const SizedBox(height: 60),
                    SizedBox(
                      width: double.infinity, 
                      height: 55, 
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          // !!!! Para botones o detalles importantes usen el accentColor
                          backgroundColor: ThemeManager.accentColor,
                          foregroundColor: Colors.black, 
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                        ), 
                        onPressed: () => Navigator.pushNamed(context, "/pagina1"), 
                        child: const Text(
                          "Ingresar", 
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                        )
                      )
                    ),
                    const SizedBox(height: 15),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, "/pagina2"),
                      child: Text(
                        "¿Nuevo aqui? Registrate", 
                        // !!!! Usamos textColor para textos secundarios clickeables
                        style: TextStyle(color: ThemeManager.textColor, fontSize: 16) 
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}