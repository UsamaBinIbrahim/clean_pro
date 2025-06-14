import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clean_pro/widgets/service_card_widget.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('services').get(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            final services = asyncSnapshot.data!.docs;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 3 / 4,
              ),
              itemCount: services.length,
              itemBuilder: (context, index) {
                final serviceData = services[index].data();
                final serviceId = services[index].id;
                return Material(
                  child: InkWell(
                    onTap: () => Navigator.pushNamed(
                      context,
                      '/services/$serviceId/booking/create',
                    ),
                    child: ServiceCardWidget(
                      name: serviceData['name'],
                      imageName: serviceData['image'],
                      price: serviceData['price'],
                    ),
                  ),
                );
              },
              padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
            );
          }
        },
      ),
    );
  }

  // void _addService(
  //   String name,
  //   String description,
  //   double price,
  //   String imageUrl,
  //   bool isAvailable,
  // ) async {
  //   await FirebaseFirestore.instance.collection('services').add({
  //     'name': name,
  //     'description': description,
  //     'price': price,
  //     'imageUrl': imageUrl,
  //     'isAvailable': isAvailable,
  //   });
  // }

  // Widget _buildServiceCard2(String name, String imageUrl) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: Colors.lightBlue.shade50,
  //       borderRadius: BorderRadius.all(Radius.circular(8)),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.blueGrey.shade400,
  //           blurRadius: 8,
  //           blurStyle: BlurStyle.outer,
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         Expanded(
  //           child: ClipRRect(
  //             borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(8),
  //               topRight: Radius.circular(8),
  //             ),
  //             child: Image.asset(imageUrl, fit: BoxFit.cover),
  //           ),
  //         ),
  //         Padding(
  //           padding: EdgeInsetsGeometry.fromLTRB(16, 8, 16, 8),
  //           child: Text(
  //             name,
  //             style: TextStyle(
  //               fontSize: 20,
  //               fontWeight: FontWeight.w600,
  //               color: Colors.indigo.shade500,
  //             ),
  //             textAlign: TextAlign.start,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
