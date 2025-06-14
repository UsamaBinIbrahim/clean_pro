class Booking {
  String id;
  String customerName;
  String serviceId;
  String date;
  String time;
  String address;
  String phone;
  String status;
  String? assignedCleanerId;

  Booking({
    required this.id,
    required this.customerName,
    required this.serviceId,
    required this.date,
    required this.time,
    required this.address,
    required this.phone,
    required this.status,
    this.assignedCleanerId,
  });

  factory Booking.fromFirestore(Map<String, dynamic> data, String docId) {
    return Booking(
      id: docId,
      customerName: data['customerName'] ?? '',
      serviceId: data['serviceId'] ?? '',
      date: data['date'] ?? '',
      time: data['time'] ?? '',
      address: data['address'] ?? '',
      phone: data['phone'] ?? '',
      status: data['status'],
      assignedCleanerId: data['assignedCleanerId'],
    );
  }
}
