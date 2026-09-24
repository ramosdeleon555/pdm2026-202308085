import 'package:flutter/material.dart';

void main() {
  runApp(const MarcadorApp());
}

class MarcadorApp extends StatelessWidget {
  const MarcadorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marcador Deportivo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        useMaterial3: true,
      ),
      home: const MarcadorScreen(),
    );
  }
}

class MarcadorScreen extends StatefulWidget {
  const MarcadorScreen({super.key});

  @override
  State<MarcadorScreen> createState() => _MarcadorScreenState();
}

class _MarcadorScreenState extends State<MarcadorScreen> {
  // Nombres de los equipos
  final String nombreEquipoA = 'Equipo A';
  final String nombreEquipoB = 'Equipo B';

  // Puntuaciones iniciales
  int puntosA = 0;
  int puntosB = 0;

  // Colores neutros y de victoria
  final Color colorNeutro = Colors.grey.shade200;
  final Color colorGanador = Colors.green.shade300;

  // --- Lógica de puntuación ---

  void sumarPuntoA() {
    setState(() {
      puntosA++;
    });
  }

  void restarPuntoA() {
    setState(() {
      if (puntosA > 0) {
        puntosA--;
      }
    });
  }

  void sumarPuntoB() {
    setState(() {
      puntosB++;
    });
  }

  void restarPuntoB() {
    setState(() {
      if (puntosB > 0) {
        puntosB--;
      }
    });
  }

  void reiniciar() {
    setState(() {
      puntosA = 0;
      puntosB = 0;
    });
  }

  // --- Lógica del mensaje de resultado ---

  String get mensajeResultado {
    if (puntosA == puntosB) {
      return 'Empate';
    } else if (puntosA > puntosB) {
      return 'Va ganando $nombreEquipoA';
    } else {
      return 'Va ganando $nombreEquipoB';
    }
  }

  // --- Lógica del color dinámico ---

  Color get colorTarjetaA {
    if (puntosA > puntosB) return colorGanador;
    return colorNeutro;
  }

  Color get colorTarjetaB {
    if (puntosB > puntosA) return colorGanador;
    return colorNeutro;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Marcador Deportivo'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Mensaje de resultado (Empate / Va ganando ...)
              Text(
                mensajeResultado,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Fila con las dos tarjetas de equipo
              Row(
                children: [
                  Expanded(
                    child: _tarjetaEquipo(
                      nombre: nombreEquipoA,
                      puntos: puntosA,
                      color: colorTarjetaA,
                      onSumar: sumarPuntoA,
                      onRestar: restarPuntoA,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _tarjetaEquipo(
                      nombre: nombreEquipoB,
                      puntos: puntosB,
                      color: colorTarjetaB,
                      onSumar: sumarPuntoB,
                      onRestar: restarPuntoB,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Botón Reiniciar
              ElevatedButton.icon(
                onPressed: reiniciar,
                icon: const Icon(Icons.refresh),
                label: const Text('Reiniciar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget reutilizable para la tarjeta de cada equipo
  Widget _tarjetaEquipo({
    required String nombre,
    required int puntos,
    required Color color,
    required VoidCallback onSumar,
    required VoidCallback onRestar,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black26),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            nombre,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            '$puntos',
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton.filled(
                onPressed: onRestar,
                icon: const Icon(Icons.remove),
                tooltip: 'Restar punto',
              ),
              const SizedBox(width: 12),
              IconButton.filled(
                onPressed: onSumar,
                icon: const Icon(Icons.add),
                tooltip: 'Sumar punto',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
