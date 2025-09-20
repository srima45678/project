import 'package:flutter/material.dart';
import 'package:project/screens/home_screen.dart';
import 'package:project/screens/search_screen.dart';
import 'package:project/screens/booking_screen.dart';
import 'package:project/Authentication/login.dart';
import 'package:project/screens/drawer.dart';
import 'package:project/screens/welcome_page.dart'
    show WelcomePage;
import 'package:project/screens/venue_page.dart';
import 'package:project/screens/event_planner_page.dart';
import 'package:project/screens/contact_us_page.dart';
import 'package:project/screens/about_us_page.dart';    
import 'package:project/screens/logo.dart' show EventifyScreen;
import 'package:project/screens/favourite_screen.dart';
import 'package:project/screens/profile_page.dart';
import 'package:project/screens/bookvenue.dart';
// import 'package:project/screens/venue_details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      // home: EventifyHome(),
      // Named routes for navigation
      routes: {
        '/home': (context) => const HomeScreen(),
        '/search': (context) => const SearchScreen(),
        '/booking': (context) => const BookingPage(),
        '/login': (context) => const LoginPage(),
        'drawer': (context) => const AppDrawer(),
        '/welcome': (context) => const WelcomePage(),
        '/venue': (context) => const VenuePage(),
        '/event_planner': (context) => const EventPlannerPage(),
        '/contact_us': (context) => const ContactUsPage(),
        '/about_us': (context) => const AboutUsPage(),
        '/favourites': (context) => const FavouritesPage(),
        '/profile': (context) => const ProfilePage(),
        '/bookvenue': (context) => const VenueBookingPage(),
        // '/venue_details': (context) => const VenueDetailsPage(),
        // '/logo': (context) => const EventifyScreen(),
      },
       home: const SplashToWelcome(),
    );
  }
}
// Add this widget to handle splash -> welcome navigation
class SplashToWelcome extends StatefulWidget {
  const SplashToWelcome({super.key});

  @override
  State<SplashToWelcome> createState() => _SplashToWelcomeState();
}

class _SplashToWelcomeState extends State<SplashToWelcome> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/welcome');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const EventifyScreen(); // Show logo.dart splash screen
  }
}