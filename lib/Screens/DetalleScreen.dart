import 'package:flutter/material.dart';

class DetalleScreen extends StatelessWidget {
  const DetalleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final peli = ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(peli["titulo"]!, style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 280,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(peli["imagen"]!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    peli["titulo"]!,
                    style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text(peli["puntuacion"]!, style: const TextStyle(color: Colors.amber, fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 20),
                      const Icon(Icons.calendar_today, color: Colors.white54, size: 16),
                      const SizedBox(width: 4),
                      Text(peli["anio"]!, style: const TextStyle(color: Colors.white54, fontSize: 15)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.amber.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.amber, width: 1),
                    ),
                    child: Text(peli["genero"]!, style: const TextStyle(color: Colors.amber, fontSize: 13)),
                  ),
                  const SizedBox(height: 20),
                  const Text("Sinopsis", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(peli["descripcion"]!, style: const TextStyle(color: Colors.white70, fontSize: 15, height: 1.6)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
