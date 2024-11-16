import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    // Initializing media query (for getting device screen size)
    mq = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xff151a3c),
      body: Stack(
        children: [
          // Centering the app logo
          Center(
            child: Image.asset("assets/images/logo.png", width: mq.width * 0.7),
          ),
          Positioned(
              bottom: mq.height * .13,
              width: mq.width,
              child: Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                      child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              )))),
          // Label at the bottom
          Positioned(
            bottom: mq.height * 0.05,
            width: mq.width,
            child: Text(
              'Free, Unlimited & Secure VPN Proxy',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontSize: 12,
                color: Colors.white,
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
