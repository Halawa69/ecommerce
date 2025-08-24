class Cart {
  final int? id; // Local DB id
  final String name; // Product name
  final int productId; // Link to products table
  final int quantity;
  final double price; // Store price at time of adding to cart
  final String? imageUrl;

  Cart({
    required this.id,
    required this.name,
    required this.productId,
    required this.quantity,
    required this.price,
    required this.imageUrl,
  });

  
}