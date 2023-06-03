import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  const TransactionForm({super.key, required this.onSubmit});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final amount = double.tryParse(_valueController.text) ?? 0.0;

    if (_titleController.text.isEmpty || amount <= 0.0) {
      return;
    }

    widget.onSubmit(_titleController.text, amount, _selectedDate);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value != null) {
        setState(() {
          _selectedDate = value;
        });
      }
      return;
    });
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                        'Data selecionada: ${DateFormat('d MMM y').format(_selectedDate)}'),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).primaryColor,
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: _showDatePicker,
                    child: const Text('Selecionar data'),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  onPressed: _submitForm,
                  child: const Text(
                    'Inserir',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
