import 'package:flutter/material.dart';

class ThemeManager {
  static final ValueNotifier<ThemeMode> themeMode = ValueNotifier<ThemeMode>(ThemeMode.dark);

  static void toggleTheme() {
    themeMode.value = themeMode.value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  }

  static bool get isDarkMode => themeMode.value == ThemeMode.dark;

  // VARIABLES GLOBALES DE COLORES
  
  // Textos principales (Títulos, textos de inputs)
  static Color get textColor => isDarkMode ? Colors.white : Colors.black87;
  
  // Textos secundarios (Subtítulos, íconos, labels)
  static Color get iconAndLabelColor => isDarkMode ? Colors.white70 : Colors.black54;
  
  // Bordes de los campos de texto
  static Color get borderColor => isDarkMode ? Colors.white38 : Colors.black26;

  // Fondo con gradiente (Para el Home)
  static List<Color> get backgroundGradient => isDarkMode 
      ? [Colors.black, const Color(0xFF1A1A1A)] 
      : [Colors.white, Colors.grey.shade200];

  // Color de acento de la app (Este no cambia con el tema, siempre es ámbar)
  static Color get accentColor => Colors.amber;
}