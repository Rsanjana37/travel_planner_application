import 'package:flutter/material.dart';
import '../models/trip.dart';

class AddTripScreen extends StatefulWidget {
  @override
  _AddTripScreenState createState() => _AddTripScreenState();
}

class _AddTripScreenState extends State<AddTripScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(Duration(days: 1));
  String _imageUrl = '';

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _startDate : _endDate,
      firstDate: isStartDate ? DateTime.now() : _startDate,
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
          if (_endDate.isBefore(_startDate)) {
            _endDate = _startDate.add(Duration(days: 1));
          }
        } else {
          _endDate = picked;
        }
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newTrip = Trip(
        name: _name,
        startDate: _startDate,
        endDate: _endDate,
        imageUrl: _imageUrl,
      );
      Navigator.pop(context, newTrip);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Trip'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Trip Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a trip name';
                }
                return null;
              },
              onSaved: (value) => _name = value!,
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: Text(
                      'Start Date: ${_startDate.toLocal().toString().split(' ')[0]}'),
                ),
                TextButton(
                  onPressed: () => _selectDate(context, true),
                  child: Text('Select'),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: Text(
                      'End Date: ${_endDate.toLocal().toString().split(' ')[0]}'),
                ),
                TextButton(
                  onPressed: () => _selectDate(context, false),
                  child: Text('Select'),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'Image URL'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an image URL';
                }
                return null;
              },
              onSaved: (value) => _imageUrl = value!,
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Add Trip'),
            ),
          ],
        ),
      ),
    );
  }
}
