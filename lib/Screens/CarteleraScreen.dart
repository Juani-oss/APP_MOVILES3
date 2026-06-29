import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CarteleraScreen extends StatelessWidget {
  const CarteleraScreen({super.key});

  // Funcion para leer la API de peliculas
  Future<List> leerUrl(String url) async {
    try {
      final respuesta = await http.get(Uri.parse(url));
      if (respuesta.statusCode == 200) {
        return json.decode(respuesta.body);
      } else {
        throw Exception("Error al cargar películas");
      }
    } catch (e) {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {

    const String urlApi = "https://devsapihub.com/api-movies";

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0,
        title: const Text("CINE STAR",
          style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},  
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.amber),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),

      body: FutureBuilder(future: leerUrl(urlApi), builder: (context, snapshot) {
          // Mientras carga mostramos el circulo de progreso
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.amber),
            );
          }

          // Si hay error o no hay datos, mostramos un mensaje
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No se pudo cargar la informacion.",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            );
          }

          final peliculasApi = snapshot.data!;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  
    //Pelicula destacada
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
                      image: DecorationImage(
                        image: NetworkImage(peliculasApi[0]['image_url']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),

    // Cartelera
                  const Text(
                    "En Cartelera",
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  
                  // El GridView ahora usa los datos de la API
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: peliculasApi.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Dos columnas
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.6, // Proporción del póster
                    ),
                    itemBuilder: (context, index) {
                      final peli = peliculasApi[index];

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
                                    image: NetworkImage(peli["image_url"]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            peli["title"] ?? "Sin título",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14,),),

                          Text("${peli["year"]} • ⭐ ${peli["stars"]}",
                            style: const TextStyle(color: Colors.white70, fontSize: 12,)),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}