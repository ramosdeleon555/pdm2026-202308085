import 'package:flutter/material.dart';

void main() {
  runApp(const MusikApp());
}

class MusikApp extends StatelessWidget {
  const MusikApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Musik',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF0F0F0F),
      ),
      home: const PantallaReproductor(),
    );
  }
}

class PantallaReproductor extends StatefulWidget {
  const PantallaReproductor({super.key});

  @override
  State<PantallaReproductor> createState() => _PantallaReproductorState();
}

class _PantallaReproductorState extends State<PantallaReproductor> {
  // Estado para la barra de progreso de la canción
  double _progresoActual = 78.0; // Corresponde al 1:18 de 3:07
  final double _duracionTotal = 187.0; // 3 min 7 seg en segundos
  bool _esMeGusta = true;

  final String urlMicrofono = 'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=600';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Column(
            children: [
              // 1. Barra Superior con Botón Atrás y Corazón de Favorito
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      _esMeGusta ? Icons.favorite : Icons.favorite_border,
                      color: _esMeGusta ? const Color(0xFFFFB703) : Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _esMeGusta = !_esMeGusta;
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // 2. Imagen del Álbum / Portada
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    image: DecorationImage(
                      image: NetworkImage(urlMicrofono),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // 3. Título de la canción, Artista e Ícono de Confirmación
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Slow Burn',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Theo Vance · Amber Hours',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  // Botón verde de 'Agregado a la biblioteca'
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Color(0xFF1E3A29), // Verde oscuro de fondo
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Color(0xFF2EC4B6), // Verde claro para el check
                      size: 20,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // 4. Barra de Progreso (Slider)
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 3,
                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0), // Oculta el círculo del slider
                  overlayShape: const RoundSliderOverlayShape(overlayRadius: 0),
                  activeTrackColor: const Color(0xFFFFB703),
                  inactiveTrackColor: Colors.grey[800],
                ),
                child: Slider(
                  value: _progresoActual,
                  max: _duracionTotal,
                  onChanged: (val) {
                    setState(() {
                      _progresoActual = val;
                    });
                  },
                ),
              ),

              const SizedBox(height: 8),

              // Tiempos (1:18 y 3:07)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '1:18',
                    style: TextStyle(color: Colors.grey[500], fontSize: 13),
                  ),
                  Text(
                    '3:07',
                    style: TextStyle(color: Colors.grey[500], fontSize: 13),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // 5. Controles del Reproductor (Aleatorio, Anterior, Play, Siguiente, Repetir)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.shuffle, color: Colors.grey, size: 26),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.skip_previous_rounded, color: Colors.white, size: 36),
                    onPressed: () {},
                  ),
                  // Botón Play Gigante
                  Container(
                    width: 68,
                    height: 68,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFB703),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.black,
                      size: 40,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.skip_next_rounded, color: Colors.white, size: 36),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.repeat, color: Colors.grey, size: 26),
                    onPressed: () {},
                  ),
                ],
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}