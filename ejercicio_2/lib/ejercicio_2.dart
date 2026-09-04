import 'models.dart';
import 'consultas.dart';


// Generado por Claude para cubrir los casos de consultas
void main() {
  final laptop = Producto(nombre: 'Laptop', precio: 800, categoria: Categoria.electronica);
  final mouse = Producto(nombre: 'Mouse', precio: 20, categoria: Categoria.electronica);
  final silla = Producto(nombre: 'Silla', precio: 150, categoria: Categoria.hogar);

  final pedido1 = Pedido(
    lineas: [
      LineaPedido(producto: laptop, cantidad: 1),
      LineaPedido(producto: mouse, cantidad: 5),
    ],
    fecha: DateTime(2026, 1, 1),
    estado: Estado.pendiente,
  );

  final pedido2 = Pedido(
    lineas: [
      LineaPedido(producto: laptop, cantidad: 1),
      LineaPedido(producto: silla, cantidad: 1),
    ],
    fecha: DateTime(2026, 6, 1),
    estado: Estado.entregado,
  );

  final pedidos = [pedido1, pedido2];

  // --- totalGeneral ---
  final total = totalGeneral(pedidos);
  print('totalGeneral: $total');
  assert(total == 1850, 'Esperado 1850, fue $total'); // (800+100) + (800+150)

  // --- pedidosPorEstado ---
  final entregados = pedidosPorEstado(pedidos, Estado.entregado);
  print('pedidosPorEstado(entregado): ${entregados.length} pedido(s)');
  assert(entregados.length == 1);

  // --- productoMasPedido ---
  final masPedido = productoMasPedido(pedidos);
  print('productoMasPedido: ${masPedido?.nombre}');
  assert(masPedido == laptop, 'Esperado laptop (aparece en 2 líneas)');

  // --- pedidoMasReciente ---
  final reciente = pedidoMasReciente(pedidos);
  print('pedidoMasReciente: ${reciente?.fecha}');
  assert(reciente == pedido2);

  // --- categoriasDisponibles ---
  final categorias = categoriasDisponibles(pedidos);
  print('categoriasDisponibles: $categorias');
  assert(categorias.contains(Categoria.electronica));
  assert(categorias.contains(Categoria.hogar));

  // --- totalPorCategoria ---
  final porCategoria = totalPorCategoria(pedidos);
  print('totalPorCategoria: $porCategoria');
  assert(porCategoria[Categoria.electronica] == 1700, 'Esperado 1700, fue ${porCategoria[Categoria.electronica]}'); // 800+100+800
  assert(porCategoria[Categoria.hogar] == 150);

  // --- casos borde: lista vacía ---
  assert(totalGeneral([]) == 0);
  assert(pedidosPorEstado([], Estado.pendiente).isEmpty);
  assert(productoMasPedido([]) == null);
  assert(pedidoMasReciente([]) == null);
  assert(categoriasDisponibles([]).isEmpty);
  assert(totalPorCategoria([]).isEmpty);

  print('\nTodas las pruebas pasaron');
}