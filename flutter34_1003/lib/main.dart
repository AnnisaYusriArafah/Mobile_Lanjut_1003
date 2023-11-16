import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class Item {
  final String name;
  final int quantity;

  Item(this.name, this.quantity);
}

class Cart {
  final List<Item> items;

  Cart(this.items);
}

class Store {
  final Cart cart;
  final String location;

  Store(this.cart, this.location);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Store(
        Cart([Item('Item A', 1), Item('Item B', 2)]),
        'Main Street Store',
      ),
      child: MaterialApp(
        title: 'Nested Provider Example',
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nested Provider Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StoreInfo(),
            CartInfo(),
          ],
        ),
      ),
    );
  }
}

class StoreInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<Store>(context);

    return Column(
      children: [
        Text('Store Location: ${store.location}'),
        Text('Total Items in Cart: ${store.cart.items.length}'),
      ],
    );
  }
}

class CartInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart =
        context.read<Cart>(); // Menggunakan context.read untuk mengakses Cart

    return Column(
      children: cart.items.map((item) {
        return ListTile(
          title: Text(item.name),
          subtitle: Text('Quantity: ${item.quantity}'),
        );
      }).toList(),
    );
  }
}
