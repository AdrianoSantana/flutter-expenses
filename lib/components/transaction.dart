import 'package:intl/intl.dart';

import '../models/transaction.dart';
import 'package:flutter/material.dart';

import 'empty-screen.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onDelete;
  const TransactionsList(
      {super.key, required this.transactions, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? const EmptyScreen(
            message: 'Nenhuma transação cadastrada',
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final tr = transactions[index];
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 5.0,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 79, 118, 122),
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FittedBox(
                        child: Text(
                          'R\$ ${tr.value}',
                          style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).textScaleFactor * 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    tr.title,
                    style: const TextStyle(
                      color: Colors.green,
                      fontFamily: 'Pangolin',
                      fontSize: 24,
                    ),
                  ),
                  subtitle: Text(
                    DateFormat('d MMM y').format(tr.date),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    color: Theme.of(context).colorScheme.error,
                    onPressed: () => onDelete(tr.id),
                  ),
                ),
              );
            },
          );
  }
}
