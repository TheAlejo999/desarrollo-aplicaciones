# Ejercicio 2 - 4/09/2026

**Participantes: Diego Orellana 20245281 y Roberto Milan 20245436**

## Revisión del modelo

### `models.dart`

- `Categoria` y `Estado` están definidos como `enum`, por lo que los campos `categoria` y `estado` solo pueden recibir valores validos del dominio.
- `Producto` usa campos de `final` y valida con `assert` para que el precio no sea negativo.
- `LineaPedido` mantiene una referencia a `Producto`, usa una cantidad entera y valida que sea positiva.
- `subtotal` es un valor derivado: se calcula a partir del precio del producto y la cantidad, sin almacenarse como un campo adicional.
- `Pedido` contiene sus líneas, la fecha y el estado. La lista debe tener al menos una línea mediante `assert(lineas.isNotEmpty)`.
- `total` se calcula a partir de los subtotales con `fold`, por lo que no se puede desincronizar de las líneas del pedido.
- Los nombres de las clases y propiedades representan conceptos del dominio y no detalles de implementación.

### Observaciones de la revisión

- Las precondiciones están ubicadas en los constructores, cerca de los datos que validan.
- Se evita usar `dynamic` porque los tipos de entrada y salida son conocidos.
- No se encontraron campos derivados almacenados innecesariamente.
- La comparación `lineas.length >= 0` no era valida como precondición, porque la longitud de una lista nunca es negativa; se reemplazó por `lineas.isNotEmpty`.

## Revisión de las consultas

### `consultas.dart`

- `totalGeneral` suma los totales de todos los pedidos mediante `fold` y devuelve `0` cuando la lista está vacía.
- `pedidosPorEstado` filtra la lista por el estado recibido y conserva la firma solicitada.
- `productoMasPedido` cuenta las apariciones de cada producto en las líneas de todos los pedidos y devuelve `null` si no hay líneas para contar.
- `pedidoMasReciente` devuelve `null` para una lista vacía y, en cualquier caso, obtiene el pedido con la fecha más reciente mediante `reduce`, sin modificar la lista original.
- `categoriasDisponibles` combina las categorías de todas las líneas y usa `toSet()` para eliminar duplicados. Para una lista vacía devuelve un conjunto vacío.
- `totalPorCategoria` agrupa los subtotales por categoría y devuelve un mapa vacío cuando no hay pedidos.
- Las consultas usan métodos de colección como `fold`, `where`, `expand`, `map`, `toSet` y `reduce`; no se usan bucles con índice.

### Observaciones de la revisión de consultas

- En el caso de que las funciones no obtenga un resultado estas declaran un tipo nullable (`Producto?` y `Pedido?`).
- Se considera explícitamente las listas vacías antes de usar `reduce`.
- `productoMasPedido` cuenta líneas de pedido, no unidades de cantidad, porque la orden pide el producto que aparece en más líneas.
- `pedidoMasReciente` compara fechas sin ordenar ni mutar la lista recibida.
- `totalPorCategoria` suma `linea.subtotal`, respetando la responsabilidad del modelo para calcular los valores derivados.

## Errores corregidos durante la sesión

1. `assert(lineas.length >= 0)`: la comparación siempre era verdadera, porque la longitud de una lista siempre es mayor o igual que cero. Se eliminó y se reemplazó por la validación `lineas.isNotEmpty`.
2. `filtrarPedidosPorEstado`: se renombró a `pedidosPorEstado` para coincidir con la firma exacta solicitada.
3. `productoMasPedido`: sumaba cantidades en lugar de contar líneas. Se corrigió para contar las apariciones de cada producto.
4. `pedidoMasReciente`: ordenaba la lista original con `sort()`. Se corrigió usando `reduce()` para obtener el pedido más reciente sin efectos secundarios.
