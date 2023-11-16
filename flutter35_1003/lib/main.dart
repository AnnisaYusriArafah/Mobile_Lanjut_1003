import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class CounterModel extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CounterModel(),
      child: MaterialApp(
        title: 'Consumer Provider Example',
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
        title: Text('Consumer Provider Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Counter Value:'),
            Consumer<CounterModel>(
              builder: (context, counter, child) {
                return Text(
                  '${counter.count}',
                  style: TextStyle(fontSize: 36),
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                context.read<CounterModel>().increment();
              },
              child: Text('Increment Counter'),
            ),
          ],
        ),
      ),
    );
  }
}
