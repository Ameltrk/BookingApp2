import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class BookingManager {
  BookingManager._privateConstructor();
  static final BookingManager instance = BookingManager._privateConstructor();

  final List<Map<String, dynamic>> _bookings = [];

  List<Map<String, dynamic>> get bookings => _bookings;

  /// Load bookings from shared preferences
  Future<void> loadBookings() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString('bookings');
    if (jsonString != null) {
      final List decoded = json.decode(jsonString);
      _bookings.clear();
      _bookings.addAll(decoded.map((b) {
        final map = Map<String, dynamic>.from(b);
        // Convert date strings back to DateTime
        map["CheckIn"] = map["CheckIn"] != null ? DateTime.parse(map["CheckIn"]) : null;
        map["CheckOut"] = map["CheckOut"] != null ? DateTime.parse(map["CheckOut"]) : null;
        return map;
      }));
    }
  }

  /// Save current bookings to shared preferences
  Future<void> saveBookings() async {
    final prefs = await SharedPreferences.getInstance();

    // Convert DateTime to string for JSON encoding
    final List<Map<String, dynamic>> encodableBookings = _bookings.map((b) {
      return {
        ...b,
        "CheckIn": b["CheckIn"]?.toIso8601String(),
        "CheckOut": b["CheckOut"]?.toIso8601String(),
      };
    }).toList();

    await prefs.setString('bookings', json.encode(encodableBookings));
  }

  /// Add a new booking and save persistently
  Future<void> addBooking(Map<String, dynamic> booking) async {
    _bookings.add(booking);
    await saveBookings(); // Save immediately
  }

  /// Clear all bookings (optional)
  Future<void> clearBookings() async {
    _bookings.clear();
    await saveBookings();
  }
}
