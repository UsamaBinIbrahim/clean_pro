import 'package:clean_pro/widgets/booking_form_widget.dart';
import 'package:flutter/material.dart';

class BookingFormScreen extends StatefulWidget {
  final String serviceId;
  const BookingFormScreen({super.key, required this.serviceId});

  @override
  State<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  final formKey = GlobalKey<FormState>();
  Map<String, dynamic>? serviceData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book Service')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: BookingFormWidget(
            serviceId: widget.serviceId,
            formKey: formKey,
          ),
        ),
      ),
    );
  }

  // Future<void> getServiceById(String serviceId) async {
  //   final serviceDocument = await FirebaseFirestore.instance
  //       .collection('services')
  //       .doc(widget.serviceId)
  //       .get();

  //   setState(() {
  //     serviceData = serviceDocument.data();
  //   });
  // }
}
