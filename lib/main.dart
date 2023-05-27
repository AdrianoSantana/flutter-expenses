import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<Transaction> _transactions = [
    Transaction(id: 't1', title: 'Açafrão', value: 12.50, date: DateTime.now()),
    Transaction(id: 't2', title: 'Headset', value: 133.49, date: DateTime.now())
  ];

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Despesas pessoais'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Card(
            elevation: 5,
            child: Text('Gráfico de despesas'),
          ),
          Column(
              children: _transactions
                  .map((tr) => Card(
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 15.0,
                                vertical: 10.0,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                              ),
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                tr.value.toString(),
                              ),
                            ),
                            Column(
                              children: [
                                Text(tr.title),
                                Text(tr.date.toLocal().toString())
                              ],
                            ),
                          ],
                        ),
                      ))
                  .toList()),
        ],
      ),
    );
  }
}
