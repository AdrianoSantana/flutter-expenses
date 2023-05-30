import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart({super.key, required this.recentTransactions});

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;

      for (var index = 0; index < recentTransactions.length; index++) {
        Transaction actual = recentTransactions[index];
        if (DateUtils.isSameDay(weekDay, actual.date)) {
          totalSum += actual.value;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay)[0],
        'value': totalSum,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20.0),
      child: Row(
        children: groupedTransactions.map((tr) {
          return Column(
            children: [
              Text('${tr['day']}'),
              Text('R\$ ${tr['value']}'),
            ],
          );
        }).toList(),
      ),
    );
  }
}
