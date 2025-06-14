import 'package:flutter/material.dart';
import 'package:clean_pro/widgets/booking_card_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clean_pro/models/booking_model.dart';
import 'package:clean_pro/models/service_model.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        initialIndex: 0,

        child: Column(
          children: [
            Container(
              color: Colors.lightBlue.shade50,
              child: TabBar(
                tabs: [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _selectedIndex == 0
                              ? Icons.access_time_filled
                              : Icons.access_time,
                        ),
                        SizedBox(width: 8),
                        Text('Pending'),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _selectedIndex == 1
                              ? Icons.check_circle
                              : Icons.check_circle_outline,
                        ),
                        SizedBox(width: 8),
                        Text('Past'),
                      ],
                    ),
                  ),
                ],
                onTap: (index) => setState(() {
                  _selectedIndex = index;
                }),
                labelColor: Colors.indigo.shade500,
                labelStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                indicatorColor: Colors.indigo.shade500,
                unselectedLabelStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  FutureBuilder(
                    future: fetchBookingsAndServices(),
                    builder: (context, asyncSnapshot) {
                      if (asyncSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (asyncSnapshot.hasError) {
                        return const Center(
                          child: Text('Error loading bookings'),
                        );
                      }

                      final bookings =
                          asyncSnapshot.data!['bookings'] as List<Booking>;
                      final services =
                          asyncSnapshot.data!['services']
                              as Map<String, Service>;

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemCount: bookings.length,
                          itemBuilder: (context, index) {
                            final booking = bookings[index];
                            if (booking.status == 'pending') {
                              final service = services[booking.serviceId];
                              return BookingCardWidget(
                                booking: booking,
                                service: service!,
                              );
                            }
                            return null;
                          },
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> fetchBookingsAndServices() async {
    final bookingsSnap = await FirebaseFirestore.instance
        .collection('bookings')
        .get();
    final servicesSnap = await FirebaseFirestore.instance
        .collection('services')
        .get();
    final bookings = bookingsSnap.docs
        .map((doc) => Booking.fromFirestore(doc.data(), doc.id))
        .toList();
    final services = {
      for (var doc in servicesSnap.docs)
        doc.id: Service.fromFirestore(doc.data(), doc.id),
    };

    return {'bookings': bookings, 'services': services};
  }
}
