import 'models.dart';

double totalGeneral(List<Pedido> pedidos) {
  return pedidos.fold(0, (sum, pedido) => sum + pedido.total);
}
 
List<Pedido> pedidosPorEstado(List<Pedido> pedidos, Estado estado) {
  return pedidos.where((pedido) => pedido.estado == estado).toList();
}

Producto? productoMasPedido(List<Pedido> pedidos) {
  final conteo = <Producto, int>{};

  for (final pedido in pedidos) {
    for (final linea in pedido.lineas) {
      conteo[linea.producto] = (conteo[linea.producto] ?? 0) + 1;
    }
  }

  if (conteo.isEmpty) return null;

  return conteo.keys.reduce(
    (max, producto) => conteo[producto]! > conteo[max]! ? producto : max,
  );
}

Pedido? pedidoMasReciente(List<Pedido> pedidos) {
  if (pedidos.isEmpty) return null;
  return pedidos.reduce((a, b) => a.fecha.isAfter(b.fecha) ? a : b);
}

Set<Categoria> categoriasDisponibles(List<Pedido> pedidos) {
  return pedidos.expand((pedido) => pedido.lineas.map((linea) => linea.producto.categoria)).toSet();
}

Map<Categoria, double> totalPorCategoria(List<Pedido> pedidos) {
  final totals = <Categoria, double>{};

  for (final pedido in pedidos) {
    for (final linea in pedido.lineas) {
      totals[linea.producto.categoria] = (totals[linea.producto.categoria] ?? 0) + linea.subtotal;
    }
  }

  return totals;
}