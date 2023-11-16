import 'package:flutter/foundation.dart';

class Product {
  final String name;
  final String image;
  bool isLoved;
  int cartItems;

  Product(
      {required this.name,
      required this.image,
      this.isLoved = false,
      this.cartItems = 0});
}

class MyDataProvider extends ChangeNotifier {
  List<Product> _products = [
    Product(name: 'Product 1', image: 'image1.jpg'),
    Product(name: 'Product 2', image: 'image2.jpg'),
    Product(name: 'Product 3', image: 'image3.jpg'),
    // Tambahkan produk lainnya di sini
  ];

  List<Product> get products => _products;

  void toggleLove(int index) {
    _products[index].isLoved = !_products[index].isLoved;
    notifyListeners();
  }

  void addToCart(int index) {
    _products[index].cartItems++;
    notifyListeners();
  }
}
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Notifier Provider Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Products:',
              style: TextStyle(fontSize: 24),
            ),
            Consumer<MyDataProvider>(
              builder: (context, myData, child) {
                final products = myData.products;
                return Column(
                  children: products.asMap().entries.map((entry) {
                    final index = entry.key;
                    final product = entry.value;

                    return ListTile(
                      title: Text(product.name),
                      leading: Image.asset(product.image),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(product.isLoved
                                ? Icons.favorite
                                : Icons.favorite_border),
                            onPressed: () {
                              myData.toggleLove(index);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.shopping_cart),
                            onPressed: () {
                              myData.addToCart(index);
                            },
                          ),
                          Text('Cart: ${product.cartItems}'),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
