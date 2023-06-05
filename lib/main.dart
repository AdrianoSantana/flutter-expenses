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
    Transaction(id: '123', title: 'any_1', value: 3321, date: DateTime.now()),
    Transaction(id: '123', title: 'any_2', value: 3321, date: DateTime.now()),
    Transaction(id: '123', title: 'any_3', value: 3321, date: DateTime.now()),
    Transaction(id: '123', title: 'any_4', value: 3321, date: DateTime.now()),
    Transaction(id: '123', title: 'any_5', value: 3321, date: DateTime.now()),
    Transaction(id: '123', title: 'any_6', value: 3321, date: DateTime.now()),
    Transaction(id: '123', title: 'any_7', value: 3321, date: DateTime.now()),
    Transaction(id: '123', title: 'any_8', value: 3321, date: DateTime.now()),
    Transaction(id: '123', title: 'any_9', value: 3321, date: DateTime.now()),
    Transaction(id: '123', title: 'any_10', value: 3321, date: DateTime.now()),
    Transaction(id: '123', title: 'any_11', value: 3321, date: DateTime.now()),
    Transaction(id: '123', title: 'any_12', value: 3321, date: DateTime.now()),
  ];

  List<Transaction> get _recentTransactions {
    DateTime lastSeventhDay = DateTime.now().subtract(const Duration(days: 7));

    List<Transaction> recents =
        transactions.where((tr) => tr.date.isAfter(lastSeventhDay)).toList();

    return recents;
  }

  _addTransaction(String title, double value, DateTime selectedDate) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: selectedDate,
    );

    setState(() {
      transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((tr) => tr.id == id);
    });
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
    final appBar = AppBar(
      centerTitle: true,
      backgroundColor: Theme.of(context).primaryColor,
      title: Text(
        'Despesas pessoais',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20 * MediaQuery.of(context).textScaleFactor,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => _openTransactionFormModal(context),
          icon: const Icon(Icons.add),
        ),
      ],
    );
    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: availableHeight * 0.3,
              child: Chart(recentTransactions: _recentTransactions),
            ),
            SizedBox(
              height: availableHeight * 0.7,
              child: TransactionsList(
                transactions: transactions,
                onDelete: _deleteTransaction,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => _openTransactionFormModal(context),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
