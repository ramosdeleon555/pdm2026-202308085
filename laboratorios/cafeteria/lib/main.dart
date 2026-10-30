import 'package:flutter/material.dart';

import 'widgets/producto_pedido.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi pedido de cafetería',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF795548)),
        scaffoldBackgroundColor: const Color(0xFFFFF8F2),
        useMaterial3: true,
      ),
      home: const PedidoPantalla(),
    );
  }
}

class PedidoPantalla extends StatefulWidget {
  const PedidoPantalla({super.key});

  @override
  State<PedidoPantalla> createState() => _PedidoPantallaState();
}

class _PedidoPantallaState extends State<PedidoPantalla> {
  static const _productos = [
    (nombre: 'Café', precio: 10.0),
    (nombre: 'Sándwich', precio: 25.0),
    (nombre: 'Jugo', precio: 12.0),
  ];

  final List<int> _cantidades = [0, 0, 0];

  double get _total {
    double total = 0;
    for (var i = 0; i < _productos.length; i++) {
      total += _productos[i].precio * _cantidades[i];
    }
    return total;
  }

  void _cambiarCantidad(int indice, int cambio) {
    final nuevaCantidad = _cantidades[indice] + cambio;
    if (nuevaCantidad < 0) return;

    setState(() {
      _cantidades[indice] = nuevaCantidad;
    });
  }

  void _vaciarPedido() {
    setState(() {
      _cantidades.fillRange(0, _cantidades.length, 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Mi pedido'), centerTitle: true),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    Icon(
                      Icons.local_cafe,
                      size: 48,
                      color: tema.colorScheme.primary,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '¿Qué se te antoja hoy?',
                      textAlign: TextAlign.center,
                      style: tema.textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Elige las cantidades de tu pedido',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    for (var i = 0; i < _productos.length; i++)
                      ProductoPedido(
                        nombre: _productos[i].nombre,
                        precio: _productos[i].precio,
                        cantidad: _cantidades[i],
                        onRestar: () => _cambiarCantidad(i, -1),
                        onSumar: () => _cambiarCantidad(i, 1),
                      ),
                  ],
                ),
              ),
              const Divider(height: 1),
              SafeArea(
                top: false,
                minimum: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total', style: tema.textTheme.titleLarge),
                        Flexible(
                          child: Text(
                            'Q${_total.toStringAsFixed(2)}',
                            key: const Key('total'),
                            style: tema.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: tema.colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    FilledButton.icon(
                      onPressed: _vaciarPedido,
                      icon: const Icon(Icons.delete_outline),
                      label: const Text('Vaciar pedido'),
                    ),
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
