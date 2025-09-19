import 'package:flutter/material.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    // Retrieve arguments passed during navigation
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    // If no argument provided, assume user is NOT a guest.
    final bool isGuest = args?['isGuest'] ?? true;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Page'),
        centerTitle: true,
      ),
      body: Center(
        child: isGuest
            ? _buildGuestView(context)
            : _buildUserView(),
      ),
    );
  }

  /// View shown when a **logged-in / normal user** is detected
  Widget _buildUserView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.event_available, size: 80, color: Colors.green),
        SizedBox(height: 16),
        Text(
          'Welcome Back!\nHere are your bookings:',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 12),
        // TODO: Replace with a real list of user bookings
        Text(
          '• Birthday Party – Confirmed\n• Wedding – Pending',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  /// View shown when a **guest** visits the booking page
  Widget _buildGuestView(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.lock_outline, size: 80, color: Colors.orange),
        const SizedBox(height: 16),
        const Text(
          'Guest Mode\nLimited booking access only.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: () {
            // Navigate to the login page so the guest can sign in
            Navigator.pushNamed(context, '/login');
          },
          icon: const Icon(Icons.login),
          label: const Text('Sign In to Unlock Full Access'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
