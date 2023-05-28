import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();

  final void Function(String, double) onSubmit;

  TransactionForm({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Título',
              ),
            ),
            TextField(
              controller: _valueController,
              decoration: const InputDecoration(
                labelText: 'Valor (R\$)',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  style:
                      TextButton.styleFrom(foregroundColor: Colors.purple[800]),
                  onPressed: () {
                    final amount =
                        double.tryParse(_valueController.text) ?? 0.0;

                    onSubmit(_titleController.text, amount);
                  },
                  child: const Text('Inserir'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
