import 'package:flutter/material.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  int _selectedIndex = 0;
  Container _buildBookingCard() {
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
      height: 64,
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
                  'Deep Cleaning',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                Text('2-5-2025 10:00 am'),
              ],
            ),
            TextButton.icon(
              icon: Icon(Icons.cancel_outlined, color: Colors.red.shade400),
              label: Text(
                'Cancel',
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildBookingCard(),
                          _buildBookingCard(),
                          _buildBookingCard(),
                          _buildBookingCard(),
                          _buildBookingCard(),
                          _buildBookingCard(),
                          _buildBookingCard(),
                          _buildBookingCard(),
                          _buildBookingCard(),
                          _buildBookingCard(),
                          _buildBookingCard(),
                          _buildBookingCard(),
                          _buildBookingCard(),
                          _buildBookingCard(),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildBookingCard(),
                          _buildBookingCard(),
                          _buildBookingCard(),
                          _buildBookingCard(),
                          _buildBookingCard(),
                          _buildBookingCard(),
                          _buildBookingCard(),
                          _buildBookingCard(),
                          _buildBookingCard(),
                          _buildBookingCard(),
                          _buildBookingCard(),
                          _buildBookingCard(),
                          _buildBookingCard(),
                          _buildBookingCard(),
                        ],
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
}
