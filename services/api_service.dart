import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/login_response.dart';
import '../models/booking.dart';

class ApiService {
  static const String baseUrl =
      "http://103.123.8.171:8023/api/login?email=developer@nelsistech.com&password=12345678";

  Future<LoginResponse?> login(String email, String password) async {
    final url = Uri.parse("${baseUrl}login");
    final response = await http.http.post(url, body: {
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      return LoginResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Login failed');
    }
  }

  Future<List<Booking>> getPendingBookings() async {
    final url = Uri.parse("${baseUrl}booking/pending");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List bookingsJson = jsonDecode(response.body);
      return bookingsJson.map((e) => Booking.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load bookings');
    }
  }

  Future<void> confirmBooking(int id) async {
    final url = Uri.parse("${baseUrl}booking/confirm?id=$id");
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to confirm booking');
    }
  }

  Future<void> cancelBooking(int id) async {
    final url = Uri.parse("${baseUrl}booking/cancel?id=$id");
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to cancel booking');
    }
  }
}
