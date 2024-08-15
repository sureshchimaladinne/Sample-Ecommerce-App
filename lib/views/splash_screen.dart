import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:sample_ecommerce_app/controllers/auth_controller.dart';
import 'package:sample_ecommerce_app/views/dashboard.dart';
import 'package:sample_ecommerce_app/views/product_screen.dart';
import 'package:sample_ecommerce_app/views/profile_page.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red, // Set the background color to red
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "E-commerce",
              style: TextStyle(
                fontSize: 30, // Set font size
                color: Colors.white, // Set text color to white
                fontWeight: FontWeight.bold, // Make the text bold
              ),
            ),
            SizedBox(
                height:
                    20), // Add some spacing between text and the loading indicator
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.white), // Set the loading indicator color to white
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final authController =
          Provider.of<AuthController>(context, listen: false);
      await Future.delayed(Duration(seconds: 2)); // Splash delay
      if (authController.isAuthenticated) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => DashboardScreen()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    });
  }
}
