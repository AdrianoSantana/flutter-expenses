import 'package:expenses/components/chart_bar.dart';
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
        'day': DateFormat.E().format(weekDay),
        'value': totalSum,
      };
    });
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(0.0, (sum, tr) {
      double value = double.tryParse(tr['value'].toString()) ?? 0.0;
      return sum + value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupedTransactions.map((tr) {
            double valueDay = double.tryParse(tr['value'].toString()) ?? 0.0;
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: tr['day'].toString(),
                value: valueDay,
                percentage: valueDay / _weekTotalValue,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
