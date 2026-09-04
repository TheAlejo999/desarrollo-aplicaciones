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

}

class Pedido {

}