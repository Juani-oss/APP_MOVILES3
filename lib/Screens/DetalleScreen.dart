import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DetalleScreen extends StatefulWidget {
  const DetalleScreen({super.key});

  @override
  State<DetalleScreen> createState() => _DetalleScreenState();
}

class _DetalleScreenState extends State<DetalleScreen> {
  final _comentarioController = TextEditingController();

  @override
  void dispose() {
    _comentarioController.dispose();
    super.dispose();
  }

  Future<void> _publicarComentario(String movieId) async {
    final texto = _comentarioController.text.trim();
    if (texto.isEmpty) return;

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final ref = FirebaseDatabase.instance.ref("comentarios/$movieId");
    await ref.push().set({
      "texto": texto,
      "usuario": user.email ?? "Anónimo",
      "fecha": DateTime.now().toIso8601String(),
    });

    _comentarioController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final peli = (ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?) ?? {};
    final listaGeneros = peli["genre"] as List<dynamic>? ?? [];
    final movieId = peli["id"]?.toString() ?? peli["title"].toString().replaceAll(' ', '_');

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Póster
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  peli["image_url"] ?? '',
                  height: 340,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Título
            Text(
              peli["title"] ?? '',
              style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Rating y año
            Row(
              children: [
                const Icon(Icons.star_rounded, color: Colors.amber, size: 22),
                const SizedBox(width: 6),
                Text(
                  peli["stars"]?.toString() ?? '-',
                  style: const TextStyle(color: Colors.amber, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 20),
                const Icon(Icons.calendar_month_outlined, color: Colors.white38, size: 18),
                const SizedBox(width: 6),
                Text(
                  peli["year"]?.toString() ?? '-',
                  style: const TextStyle(color: Colors.white54, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Géneros
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: listaGeneros.map((g) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                decoration: BoxDecoration(
                  color: Colors.amber.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.amber.withValues(alpha: 0.6)),
                ),
                child: Text(g.toString(), style: const TextStyle(color: Colors.amber, fontSize: 13)),
              )).toList(),
            ),
            const SizedBox(height: 24),

            const Divider(color: Colors.white12),
            const SizedBox(height: 16),

            // Sinopsis
            const Text("Sinopsis", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(
              peli["description"] ?? 'Sin descripción disponible.',
              style: const TextStyle(color: Colors.white70, fontSize: 15, height: 1.7),
            ),
            const SizedBox(height: 32),

            const Divider(color: Colors.white12),
            const SizedBox(height: 16),

            // Sección comentarios
            const Text("Comentarios", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 14),

            // Campo para escribir comentario
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _comentarioController,
                    style: const TextStyle(color: Colors.white),
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: "Escribe tu comentario...",
                      hintStyle: const TextStyle(color: Colors.white38),
                      filled: true,
                      fillColor: Colors.white10,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: () => _publicarComentario(movieId),
                  icon: const Icon(Icons.send_rounded, color: Colors.amber, size: 28),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Lista de comentarios en tiempo real
            StreamBuilder<DatabaseEvent>(
              stream: FirebaseDatabase.instance.ref("comentarios/$movieId").onValue,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(color: Colors.amber));
                }

                final data = snapshot.data?.snapshot.value;
                if (data == null) {
                  return const Text("Sé el primero en comentar.", style: TextStyle(color: Colors.white38));
                }

                final comentarios = (data as Map<dynamic, dynamic>).values.toList()
                  ..sort((a, b) => (b["fecha"] ?? '').compareTo(a["fecha"] ?? ''));

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: comentarios.length,
                  separatorBuilder: (_, _) => const Divider(color: Colors.white10),
                  itemBuilder: (context, index) {
                    final c = comentarios[index] as Map<dynamic, dynamic>;
                    final fecha = DateTime.tryParse(c["fecha"] ?? '');
                    final fechaTexto = fecha != null
                        ? "${fecha.day}/${fecha.month}/${fecha.year}"
                        : '';

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                c["usuario"] ?? 'Anónimo',
                                style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                              Text(fechaTexto, style: const TextStyle(color: Colors.white38, fontSize: 12)),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            c["texto"] ?? '',
                            style: const TextStyle(color: Colors.white70, fontSize: 14, height: 1.5),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
