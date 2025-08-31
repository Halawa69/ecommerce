import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

import 'package:ecommerce/core/reuseable/productSearchDelegate.dart';
import 'package:ecommerce/features/auth/presentation/provider/userProvider.dart';
import 'package:ecommerce/features/cart/presentation/provider/cart_provider.dart';
import 'package:ecommerce/features/home/domain/entities/product.dart';
import 'package:ecommerce/features/home/presentation/provider/product_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
@override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    final productProvider = context.read<ProductProvider>();
    productProvider.fetchProducts();
    productProvider.fetchCategories();
  });
}

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final productProvider = context.watch<ProductProvider>();
    final cartProvider = context.watch<CartProvider>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildBody(userProvider, productProvider, cartProvider),
        ),
      ),
    );
  }

  Widget _buildBody(
    UserProvider userProvider,
    ProductProvider productProvider,
    CartProvider cartProvider,
  ) {
    if (productProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (productProvider.errorMessage != null) {
      return Center(child: Text('Error: ${productProvider.errorMessage}'));
    }

    if (productProvider.products.isEmpty) {
      return const Center(child: Text("No products found"));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(userProvider, cartProvider),
        const SizedBox(height: 10),
        _buildSearchBar(productProvider),
        const SizedBox(height: 20),
        _buildSectionHeader(productProvider),
        const SizedBox(height: 15),
        Expanded(child: _buildProductsGrid(productProvider, cartProvider)),
      ],
    );
  }

  Widget _buildHeader(UserProvider userProvider, CartProvider cartProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Text(
              'Hello ',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            // Prepare username and displayName before widget tree
            Text(
              '${userProvider.username?.isNotEmpty == true ? userProvider.username![0].toUpperCase() + userProvider.username!.substring(1) : 'Guest'}',
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6200EE),
              ),
            ),
          ],
        ),
        Stack(
          alignment: Alignment.topRight,
          children: [
            IconButton(
              onPressed: () {
                context.push('/cart');
              },
              icon: const Icon(
                Icons.shopping_cart,
                size: 30,
                color: Color(0xFF6200EE),
              ),
            ),
            if (cartProvider.items.isNotEmpty)
              CircleAvatar(
                radius: 10,
                backgroundColor: Colors.red,
                child: Text(
                  '${cartProvider.items.length}',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchBar(ProductProvider productProvider) {
    return InkWell(
      onTap: () async {
        await showSearch<Product?>(
          context: context,
          delegate: ProductSearchDelegate(productProvider),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          children: const [
            Icon(Icons.search, size: 20, color: Colors.black),
            SizedBox(width: 8),
            Text("Search", style: TextStyle(fontSize: 18, color: Colors.black)),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(ProductProvider productProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Our Products',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6200EE),
          ),
        ),
        IconButton(
          onPressed: () => _showCategoryDialog(productProvider),
          icon: const Icon(
            Icons.filter_alt,
            size: 30,
            color: Color(0xFF6200EE),
          ),
        ),
      ],
    );
  }

  void _showCategoryDialog(ProductProvider productProvider) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Filter by Category'),
          content: SizedBox(
            width: double.maxFinite,
            height: 300,
            child: Column(
              children: [
                ListTile(
                  title: const Text("All"),
                  onTap: () {
                    Navigator.pop(context);
                    productProvider.fetchProducts();
                  },
                ),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: productProvider.categories.length,
                    itemBuilder: (context, index) {
                      final category = productProvider.categories[index];
                      return ListTile(
                        title: Text(category),
                        onTap: () {
                          Navigator.pop(context);
                          productProvider.fetchProductsByCategory(category);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProductsGrid(
    ProductProvider productProvider,
    CartProvider cartProvider,
  ) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        childAspectRatio: 0.7,
      ),
      itemCount: productProvider.products.length,
      itemBuilder: (context, index) {
        final product = productProvider.products[index];
        final cartItem = cartProvider.items.firstWhereOrNull(
          (item) => item.productId == product.id,
        );

        return ProductItemWidget(product: product, cartItem: cartItem);
      },
    );
  }
}

class ProductItemWidget extends StatelessWidget {
  final Product product;
  final dynamic cartItem;

  const ProductItemWidget({super.key, required this.product, this.cartItem});

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.read<CartProvider>();

    return InkWell(
      onTap: () {
        // Navigate to product page
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              product.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\$${product.price}'),
                if (cartItem == null)
                  IconButton(
                    onPressed: () {
                      cartProvider.addToCartFromProduct(product);
                    },
                    icon: const Icon(
                      Icons.add_shopping_cart,
                      color: Color(0xFF6200EE),
                    ),
                  )
                else
                  Row(
                    children: [
                      IconButton(
                        onPressed: cartItem.quantity > 1
                            ? () => cartProvider.decreaseQuantity(
                                cartItem.productId,
                              )
                            : () => cartProvider.removeItem(cartItem.productId),
                        icon: const Icon(Icons.remove, color: Colors.red),
                      ),
                      Text('${cartItem.quantity}'),
                      IconButton(
                        onPressed: () =>
                            cartProvider.increaseQuantity(cartItem.productId),
                        icon: const Icon(Icons.add, color: Colors.green),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
