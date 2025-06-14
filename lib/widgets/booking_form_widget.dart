import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingFormWidget extends StatefulWidget {
  final String serviceId;
  final GlobalKey<FormState> formKey;
  const BookingFormWidget({
    super.key,
    required this.serviceId,
    required this.formKey,
  });

  @override
  State<BookingFormWidget> createState() => _BookingFormWidgetState();
}

class _BookingFormWidgetState extends State<BookingFormWidget> {
  final _customerNameController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _customerNameController,
          decoration: InputDecoration(labelText: 'Enter your name'),
          validator: (value) =>
              value == null || value.isEmpty ? 'Name field is required' : null,
        ),

        TextFormField(
          controller: _dateController,
          readOnly: true,
          decoration: InputDecoration(labelText: 'Select date'),
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(Duration(days: 365 * 100)),
            );
            if (pickedDate != null) {
              setState(() {
                _dateController.text =
                    '${pickedDate.year}-${pickedDate.month}-${pickedDate.day}';
              });
            }
          },
          validator: (value) =>
              value == null || value.isEmpty ? 'Date field is required' : null,
        ),

        TextFormField(
          controller: _timeController,
          readOnly: true,
          decoration: InputDecoration(labelText: 'Select time'),
          onTap: () async {
            TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (pickedTime != null) {
              _timeController.text =
                  '${pickedTime.hourOfPeriod}:${pickedTime.minute} ${pickedTime.period == DayPeriod.am ? 'AM' : 'PM'}';
            }
          },
          validator: (value) =>
              value == null || value.isEmpty ? 'Time field is required' : null,
        ),

        TextFormField(
          controller: _addressController,
          decoration: InputDecoration(labelText: 'Address'),
          validator: (value) => value == null || value.isEmpty
              ? 'Address field is required'
              : null,
        ),

        TextFormField(
          controller: _phoneController,
          decoration: InputDecoration(labelText: 'Phone number (##-######)'),
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Phone number is required';
            } else if (!RegExp(r'^\d{2}-\d{6}$').hasMatch(value)) {
              return 'Enter a valid phone number';
            }
            return null;
          },
        ),

        SizedBox(height: 24),
        ElevatedButton(
          onPressed: () async {
            final bool isSubmitted = await _submitForm();
            if (!context.mounted) return;
            if (isSubmitted) Navigator.pop(context);
          },
          child: Text('Submit Booking'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _customerNameController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<bool> _submitForm() async {
    if (widget.formKey.currentState!.validate()) {
      await FirebaseFirestore.instance.collection('bookings').add({
        'customerName': _customerNameController.text,
        'serviceId': widget.serviceId,
        'date': _dateController.text,
        'time': _timeController.text,
        'address': _addressController.text,
        'phone': _phoneController.text,
        'status': 'pending',
        'assignedCleaner': null,
      });
      log('success');
      return true;
    } else {
      log('error');
      return false;
    }
  }
}
