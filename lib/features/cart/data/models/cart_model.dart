import 'package:ecommerce/features/cart/domain/entites/cart.dart';

class CartModel extends Cart {

  CartModel({
    required super.name, required super.productId, required super.quantity, required super.price, required super.id, required super.imageUrl
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'productId': productId,
    'quantity': quantity,
    'price': price,
    'imageUrl': imageUrl,
  };

  factory CartModel.fromMap(Map<String, dynamic> map) => CartModel(
    id: map['id'],
    name: map['name'],
    productId: map['productId'],
    quantity: map['quantity'],
    price: (map['price'] as num).toDouble(),
    imageUrl: map['imageUrl'],
  );
  
  factory CartModel.fromEntity(Cart cart) {
  return CartModel(
    id: cart.id,
    name: cart.name,
    productId: cart.productId,
    quantity: cart.quantity,
    price: cart.price,
    imageUrl: cart.imageUrl,
  );
}


}