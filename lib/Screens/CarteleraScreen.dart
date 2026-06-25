import 'package:flutter/material.dart';

class CarteleraScreen extends StatelessWidget {
  const CarteleraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista simulada de películas (puedes cambiar los nombres y assets/urls después)
    final List<Map<String, String>> peliculas = [
      {
        "titulo": "Batman",
        "imagen": "https://via.placeholder.com/150x220/000000/FFFFFF?text=Batman",
        "descripcion": "Bruce Wayne se convierte en el vigilante nocturno de Gotham para enfrentarse al Joker y proteger a su ciudad de la corrupción y el caos.",
        "anio": "2022",
        "puntuacion": "7.8",
        "genero": "Acción / Crimen",
      },
      {
        "titulo": "Inception",
        "imagen": "https://via.placeholder.com/150x220/000000/FFFFFF?text=Inception",
        "descripcion": "Un ladrón experto en robar secretos del subconsciente recibe la misión inversa: plantar una idea en la mente de alguien.",
        "anio": "2010",
        "puntuacion": "8.8",
        "genero": "Ciencia ficción / Thriller",
      },
      {
        "titulo": "Interstellar",
        "imagen": "https://via.placeholder.com/150x220/000000/FFFFFF?text=Interstellar",
        "descripcion": "Un grupo de exploradores viaja a través de un agujero de gusano en busca de un nuevo hogar para la humanidad mientras la Tierra agoniza.",
        "anio": "2014",
        "puntuacion": "8.6",
        "genero": "Ciencia ficción / Drama",
      },
      {
        "titulo": "Dune",
        "imagen": "https://via.placeholder.com/150x220/000000/FFFFFF?text=Dune",
        "descripcion": "Paul Atreides lidera a su pueblo en la batalla por el planeta desértico más importante del universo, fuente de la especia más valiosa.",
        "anio": "2021",
        "puntuacion": "8.0",
        "genero": "Ciencia ficción / Aventura",
      },
      {
        "titulo": "Avatar",
        "imagen": "https://via.placeholder.com/150x220/000000/FFFFFF?text=Avatar",
        "descripcion": "Un marine parapléjico viaja al planeta Pandora donde se ve atrapado en un conflicto entre colonizadores humanos y los Na'vi, los habitantes nativos.",
        "anio": "2009",
        "puntuacion": "7.9",
        "genero": "Ciencia ficción / Aventura",
      },
      {
        "titulo": "Avengers",
        "imagen": "https://via.placeholder.com/150x220/000000/FFFFFF?text=Avengers",
        "descripcion": "Los héroes más poderosos de la Tierra se unen para detener a Thanos, quien busca reunir las Gemas del Infinito para borrar la mitad del universo.",
        "anio": "2018",
        "puntuacion": "8.4",
        "genero": "Acción / Superhéroes",
      },
    ];

    return Scaffold(
      backgroundColor: Colors.black, // Mantenemos el fondo oscuro de tu app
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "CINE STAR", 
          style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              // --- SECCIÓN: PELÍCULA DESTACADA (BANNER) ---
              const Text(
                "Destacada de la semana",
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(12),
                  // Nota: Cuando tengas una imagen real en tus assets, usa AssetImage o NetworkImage
                  image: const DecorationImage(
                    image: NetworkImage("https://via.placeholder.com/400x180/222222/FFFFFF?text=Banner+Película"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 25),

              // --- SECCIÓN: EN CARTELERA (GRID) ---
              const Text(
                "En Cartelera",
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true, // Permite que se use dentro de SingleChildScrollView
                physics: const NeverScrollableScrollPhysics(), // Evita conflictos de scroll
                itemCount: peliculas.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Dos columnas de películas
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.7, // Proporción ideal para pósters de cine
                ),
                itemBuilder: (context, index) {
                  final peli = peliculas[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "/detalle", arguments: peli);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white10,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.white12, width: 1),
                              image: DecorationImage(
                                image: NetworkImage(peli["imagen"]!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        peli["titulo"]!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}