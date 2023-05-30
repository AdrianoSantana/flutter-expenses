import 'dart:math';

import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:flutter/material.dart';
import 'components/transaction.dart';
import 'models/transaction.dart';

main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
        primaryColor: Colors.green[400],
        fontFamily: 'Pangolin',
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Transaction> transactions = [
    Transaction(
        id: 't1',
        title: 'Açafrão',
        value: 10.0,
        date: DateTime.now().subtract(const Duration(days: 2))),
    Transaction(
        id: 't2',
        title: 'Headset',
        value: 10.0,
        date: DateTime.now().subtract(const Duration(days: 2))),
    Transaction(id: 't2', title: 'Headset', value: 20.0, date: DateTime.now()),
    Transaction(id: 't2', title: 'Headset', value: 20.0, date: DateTime.now()),
    Transaction(
        id: 't2',
        title: 'Headset',
        value: 1000.0,
        date: DateTime.now().subtract(const Duration(days: 33))),
  ];

  List<Transaction> get _recentTransactions {
    DateTime lastSeventhDay = DateTime.now().subtract(const Duration(days: 7));

    List<Transaction> recents =
        transactions.where((tr) => tr.date.isAfter(lastSeventhDay)).toList();

    return recents;
  }

  _addTransaction(String title, double value) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: DateTime.now(),
    );

    setState(() {
      transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(onSubmit: _addTransaction);
      },
      useSafeArea: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'Despesas pessoais',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () => _openTransactionFormModal(context),
            icon: Icon(Icons.add),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(recentTransactions: _recentTransactions),
            Column(
              children: [
                TransactionsList(transactions: transactions),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTransactionFormModal(context),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
