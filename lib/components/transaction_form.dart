import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();

  final void Function(String, double) onSubmit;

  TransactionForm({super.key, required this.onSubmit});

  _submitForm() {
    final amount = double.tryParse(_valueController.text) ?? 0.0;

    if (_titleController.text.isEmpty || amount <= 0.0) {
      return;
    }

    onSubmit(_titleController.text, amount);
  }

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
              onSubmitted: (_) => _submitForm(),
            ),
            TextField(
              controller: _valueController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Valor (R\$)',
              ),
              onSubmitted: (_) => _submitForm(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  style:
                      TextButton.styleFrom(foregroundColor: Colors.purple[800]),
                  onPressed: _submitForm,
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
