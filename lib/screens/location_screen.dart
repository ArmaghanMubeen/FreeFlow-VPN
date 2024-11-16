import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../controllers/location_controller.dart';
import '../controllers/native_ad_controller.dart';
import '../helpers/ad_helper.dart';
import '../main.dart';
import '../widgets/vpn_card.dart';

class LocationScreen extends StatelessWidget {
  LocationScreen({super.key});

  final _controller = LocationController();
  final _adController = NativeAdController();

  @override
  Widget build(BuildContext context) {
    if (_controller.vpnList.isEmpty) _controller.getVpnData();

    _adController.ad = AdHelper.loadNativeAd(adController: _adController);

    return Obx(
      () => Scaffold(
        //app bar
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Select Country',
            style: GoogleFonts.roboto(color: Colors.white),
          ),
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? Color(0xff151a3c)
              : Color(0xff4071ff),
        ),

        bottomNavigationBar:
            // Config.hideAds ? null:
            _adController.ad != null && _adController.adLoaded.isTrue
                ? SafeArea(
                    child: SizedBox(
                        height: 85, child: AdWidget(ad: _adController.ad!)))
                : null,

        //refresh button
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10, right: 10),
          child: FloatingActionButton(
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? Color(0xff394075)
                  : Color(0xff4071ff),
              shape: CircleBorder(),
              onPressed: () => _controller.getVpnData(),
              child: Icon(
                CupertinoIcons.refresh,
                color: Colors.white,
              )),
        ),

        body: _controller.isLoading.value
            ? _loadingWidget(context)
            : _controller.vpnList.isEmpty
                ? _noVPNFound(context)
                : _vpnData(),
      ),
    );
  }

  _vpnData() => ListView.builder(
      itemCount: _controller.vpnList.length,
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.only(
          top: mq.height * .015,
          bottom: mq.height * .1,
          left: mq.width * .04,
          right: mq.width * .04),
      itemBuilder: (ctx, i) {
        return VpnCard(vpn: _controller.vpnList[i]);
      });

  _loadingWidget(BuildContext context) => SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //lottie animation
            CircularProgressIndicator(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Color(0xff4071ff))
          ],
        ),
      );

  _noVPNFound(BuildContext context) => Center(
        child: Text(
          'No Availible Country For VPN Right Now',
          style: GoogleFonts.roboto(
            fontSize: 12,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
      );
}
