import 'package:flutter/material.dart';
import 'package:clean_pro/models/booking_model.dart';
import 'package:clean_pro/models/service_model.dart';

class BookingCardWidget extends StatelessWidget {
  final Booking booking;
  final Service service;
  const BookingCardWidget({
    super.key,
    required this.booking,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.lightBlue.shade50,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 8,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      width: double.infinity,
      height: 80,
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.name,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                Text('${booking.date} ${booking.time}'),
                Text(
                  '${service.price}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            TextButton.icon(
              icon: Icon(Icons.cancel_outlined, color: Colors.red.shade400),
              label: Text(
                booking.status == 'pending'
                    ? 'Cancel'
                    : (booking.status == 'completed' ? 'Delete' : ''),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.red.shade400,
                ),
              ),
              onPressed: () {},
              style: TextButton.styleFrom(
                iconSize: 28,
                minimumSize: Size(24, 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
