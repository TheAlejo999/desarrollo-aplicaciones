enum Categoria {
  electronica, hogar, ropa, alimentos, otros
}

enum Estado {
  pendiente, enviado, entregado, cancelado
}

class Producto {
  final String nombre;
  final double precio;
  final Categoria categoria;

  Producto({
    required this.nombre,
    required this.precio,
    required this.categoria,
  }) : assert(precio >= 0, 'El precio no puede ser negativo');
}

class LineaPedido {
  final Producto producto;
  final int cantidad;

  LineaPedido({
    required this.producto,
    required this.cantidad,
  }) : assert(cantidad > 0, 'La cantidad debe ser un número positivo');

  double get subtotal => producto.precio * cantidad;
}

class Pedido {
  final List<LineaPedido> lineas;
  final DateTime fecha;
  final Estado estado;

  Pedido({
    required this.lineas,
    required this.fecha,
    required this.estado,
  }) : assert(lineas.isNotEmpty, 'El pedido debe contener al menos una línea de pedido');

  double get total => lineas.fold(0, (sum, linea) => sum + linea.subtotal);
}