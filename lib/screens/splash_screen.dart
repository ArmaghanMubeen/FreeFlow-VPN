import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_rx/src/rx_workers/rx_workers.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:after_layout/after_layout.dart';
import 'package:vpn_basic_project/controllers/location_controller.dart';
import 'package:vpn_basic_project/helpers/pref.dart';
import 'package:vpn_basic_project/screens/home_screen.dart';
import 'package:vpn_basic_project/screens/loading_screen.dart';
import '../helpers/ad_helper.dart';
import '../main.dart';
import 'onboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with AfterLayoutMixin<SplashScreen> {
  final _controller = LocationController();
  Future<void> checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seen = (prefs.getBool('seen') ?? false);

    if (seen) {
      _navigateToHome();
    } else {
      await prefs.setBool('seen', true);
      _navigateToOnBoarding();
    }
  }

  void _navigateToHome() {
    Future.delayed(Duration(seconds: _controller.vpnList.isEmpty ? 0 : 2), () {
      // Exit full-screen
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

      AdHelper.precacheInterstitialAd();
      AdHelper.precacheNativeAd();

      if (Pref.hasVpn==false) {
        _controller.getVpnData();
        Get.off(() => LoadingScreen());

        // Listen for changes in the loading state
        ever(_controller.isLoading, (isLoading) {
          if (!isLoading) {
            var vpnList = _controller.vpnList;
            var vpn = vpnList.firstWhere(
                (vpn) => vpn.countryLong == "United States",
                orElse: () => vpnList[0]);

            Pref.vpn = vpn;
            Get.off(() => HomeScreen());
          }
        });
      } else {
        
        Get.off(() => HomeScreen());
      }
    });
  }

  void _navigateToOnBoarding() {
    Future.delayed(Duration(seconds: _controller.vpnList.isEmpty ? 0 : 2), () {
      // Exit full-screen
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

      AdHelper.precacheInterstitialAd();
      AdHelper.precacheNativeAd();

      if (Pref.hasVpn==false) {
        _controller.getVpnData();
        Get.off(() => LoadingScreen());

        // Listen for changes in the loading state
        ever(_controller.isLoading, (isLoading) {
          if (!isLoading) {
            // Data has been fetched
            var vpnList = _controller.vpnList;
            var vpn = vpnList.firstWhere(
                (vpn) => vpn.countryLong == "United States",
                orElse: () => vpnList[0]);

            Pref.vpn = vpn;
            Get.off(() => OnBoarding());
          }
        });
      } else {
       
        Get.off(() => OnBoarding());
      }
    });
  }

  @override
  void initState() {
    super.initState();
    checkFirstSeen();
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

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
