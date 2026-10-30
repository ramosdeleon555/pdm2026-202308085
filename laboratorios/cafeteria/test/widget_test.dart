import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cafeteria/main.dart';
import 'package:cafeteria/widgets/producto_pedido.dart';

void main() {
  testWidgets('Cumple los cinco casos obligatorios del pedido', (tester) async {
    tester.view.physicalSize = const Size(400, 850);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const MyApp());

    void verificarCantidades(List<int> cantidades) {
      expect(
        tester
            .widgetList<ProductoPedido>(find.byType(ProductoPedido))
            .map((producto) => producto.cantidad),
        cantidades,
      );
    }

    // 1. Inicio: tres productos visibles, cantidades y total en cero.
    expect(find.text('Mi pedido'), findsOneWidget);
    expect(find.byType(ProductoPedido), findsNWidgets(3));
    expect(find.text('Q10.00'), findsOneWidget);
    expect(find.text('Q25.00'), findsOneWidget);
    expect(find.text('Q12.00'), findsOneWidget);
    verificarCantidades([0, 0, 0]);
    expect(find.text('Q0.00'), findsOneWidget);

    // 2. Dos cafés, un sándwich y un jugo: Q57.00.
    for (final nombre in ['Café', 'Café', 'Sándwich', 'Jugo']) {
      await tester.tap(find.byTooltip('Agregar $nombre'));
      await tester.pump();
    }
    verificarCantidades([2, 1, 1]);
    expect(find.text('Q57.00'), findsOneWidget);

    // 3. Quitar un café: Q47.00.
    await tester.tap(find.byTooltip('Restar Café'));
    await tester.pump();
    verificarCantidades([1, 1, 1]);
    expect(find.text('Q47.00'), findsOneWidget);

    // 4. Restar en cero no cambia la cantidad ni el total.
    await tester.tap(find.byTooltip('Restar Café'));
    await tester.pump();
    await tester.tap(find.byTooltip('Restar Café'));
    await tester.pump();
    verificarCantidades([0, 1, 1]);
    expect(find.text('Q37.00'), findsOneWidget);
    expect(
      tester
          .widget<IconButton>(
            find.byWidgetPredicate(
              (widget) =>
                  widget is IconButton && widget.tooltip == 'Restar Café',
            ),
          )
          .onPressed,
      isNull,
    );
    // También se comprueba la protección en la acción del estado.
    tester
        .widgetList<ProductoPedido>(find.byType(ProductoPedido))
        .first
        .onRestar();
    await tester.pump();
    verificarCantidades([0, 1, 1]);
    expect(find.text('Q37.00'), findsOneWidget);

    // 5. Vaciar conserva los productos visibles y restablece el pedido.
    await tester.tap(find.text('Vaciar pedido'));
    await tester.pump();
    verificarCantidades([0, 0, 0]);
    expect(find.text('Q0.00'), findsOneWidget);
    expect(find.byType(ProductoPedido), findsNWidgets(3));
  });
}
