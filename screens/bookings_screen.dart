import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/booking.dart';

class BookingsScreen extends StatelessWidget {
  final ApiService _apiService = ApiService();

  Future<List<Booking>> _fetchBookings() async {
    return await _apiService.getPendingBookings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bookings')),
      body: FutureBuilder<List<Booking>>(
        future: _fetchBookings(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No bookings available'));
          } else {
            final bookings = snapshot.data!;
            return ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final booking = bookings[index];
                return ListTile(
                  title: Text('Booking ID: ${booking.id}'),
                  subtitle: Text('Status: ${booking.status}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.check),
                        onPressed: () => _apiService.confirmBooking(booking.id),
                      ),
                      IconButton(
                        icon: Icon(Icons.cancel),
                        onPressed: () => _apiService.cancelBooking(booking.id),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
