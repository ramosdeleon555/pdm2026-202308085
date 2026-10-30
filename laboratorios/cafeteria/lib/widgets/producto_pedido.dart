import 'package:flutter/material.dart';

class ProductoPedido extends StatelessWidget {
  const ProductoPedido({
    super.key,
    required this.nombre,
    required this.precio,
    required this.cantidad,
    required this.onRestar,
    required this.onSumar,
  });

  final String nombre;
  final double precio;
  final int cantidad;
  final VoidCallback onRestar;
  final VoidCallback onSumar;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(nombre, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: Text('Q${precio.toStringAsFixed(2)}')),
                IconButton(
                  tooltip: 'Restar $nombre',
                  onPressed: cantidad == 0 ? null : onRestar,
                  icon: const Icon(Icons.remove),
                ),
                SizedBox(
                  width: 36,
                  child: Text(
                    '$cantidad',
                    textAlign: TextAlign.center,
                    semanticsLabel: '$cantidad unidades de $nombre',
                  ),
                ),
                IconButton(
                  tooltip: 'Agregar $nombre',
                  onPressed: onSumar,
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
