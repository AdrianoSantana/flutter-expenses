import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import 'transaction.dart';
import 'transaction_form.dart';

class TransactionUser extends StatefulWidget {
  const TransactionUser({super.key});

  @override
  State<TransactionUser> createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
  List<Transaction> transactions = [
    Transaction(id: 't1', title: 'Açafrão', value: 12.50, date: DateTime.now()),
    Transaction(id: 't2', title: 'Headset', value: 133.49, date: DateTime.now())
  ];

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
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionsList(transactions: transactions),
        TransactionForm(
          onSubmit: _addTransaction,
        )
      ],
    );
  }
}
