import 'package:flutter/material.dart';
import '../models/trip.dart';
import 'package:uuid/uuid.dart';

class BudgetScreen extends StatefulWidget {
  final Trip trip;

  BudgetScreen({required this.trip});

  @override
  _BudgetScreenState createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  final _budgetController = TextEditingController();
  String _selectedCategory = 'Food';

  final List<String> _categories = [
    'Food',
    'Transportation',
    'Accommodation',
    'Activities',
    'Shopping',
    'Other'
  ];

  @override
  void initState() {
    super.initState();
    _budgetController.text = widget.trip.budget.toStringAsFixed(2);
  }

  void _addExpense() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        widget.trip.addExpense(Expense(
          id: Uuid().v4(),
          category: _selectedCategory,
          description: _descriptionController.text,
          amount: double.parse(_amountController.text),
          date: DateTime.now(),
        ));
      });
      _descriptionController.clear();
      _amountController.clear();
      Navigator.pop(context);
    }
  }

  void _showAddExpenseDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Expense'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  items: _categories.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategory = newValue!;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Category'),
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _amountController,
                  decoration: InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an amount';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showSetBudgetDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Set Budget'),
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: _budgetController,
              decoration: InputDecoration(labelText: 'Total Budget'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a budget';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    widget.trip.setBudget(double.parse(_budgetController.text));
                  });
                  Navigator.pop(context);
                }
              },
              child: Text('Set'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Budget'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(16),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Budget Summary',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: _showSetBudgetDialog,
                          tooltip: 'Edit Budget',
                        ),
                      ]),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Budget:'),
                      Text('\$${widget.trip.budget.toStringAsFixed(2)}'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Expenses:'),
                      Text(
                          '\$${widget.trip.getTotalExpenses().toStringAsFixed(2)}'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Remaining:'),
                      Text(
                        '\$${widget.trip.getRemainingBudget().toStringAsFixed(2)}',
                        style: TextStyle(
                          color: widget.trip.getRemainingBudget() >= 0
                              ? Colors.green
                              : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.trip.expenses.length,
              itemBuilder: (context, index) {
                final expense = widget.trip.expenses[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(expense.category[0]),
                  ),
                  title: Text(expense.description),
                  subtitle: Text(
                      '${expense.date.toString().substring(0, 10)} - ${expense.category}'),
                  trailing: Text('\$${expense.amount.toStringAsFixed(2)}'),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddExpenseDialog,
        child: Icon(Icons.add),
        tooltip: 'Add Expense',
      ),
    );
  }
}
