import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:vpn_basic_project/screens/home_screen.dart';

class OnBoarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff151a3c),
      body: SafeArea(
        child: OnBoardingSlider(
          finishButtonText: 'Let\'s Go',
          finishButtonStyle: FinishButtonStyle(
            backgroundColor: Color(0xff394075),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(250),
            ),
          ),
          centerBackground: true,
          onFinish: () {
            Navigator.pushReplacement(
              context,
              CupertinoPageRoute(
                builder: (context) => HomeScreen(),
              ),
            );
          },
          skipTextButton: Text(
            'Skip',
            style: GoogleFonts.roboto(
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: Container(
            color: Color(0xff151a3c),
          ),
          controllerColor: Colors.white,
          totalPage: 3,
          headerBackgroundColor: Color(0xff151a3c),
          pageBackgroundColor: Color(0xff151a3c),
          background: [
            Column(
              children: [
                SizedBox(height: 50),
                Image.asset(
                  'assets/images/slide_1.png',
                  width: 300,
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Image.asset(
                  'assets/images/slide_2.png',
                  width: 300,
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Image.asset(
                  'assets/images/slide_3.png',
                  width: 300,
                ),
              ],
            ),
          ],
          speed: 1.8,
          pageBodies: [
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 420,
                  ),
                  Text(
                    'Secure Connection',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Protect your online privacy & Enjoy a secure and encrypted connection.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: Color(0xff9ba1c6),
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 420,
                  ),
                  Text(
                    'Unlimited Access',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Unlimited data, browse, stream, and download without any restrictions.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: Color(0xff9ba1c6),
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 420,
                  ),
                  Text(
                    'Completely Free',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'No hidden fees, no subscriptions—just pure, unrestricted internet access.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: Color(0xff9ba1c6),
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
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
