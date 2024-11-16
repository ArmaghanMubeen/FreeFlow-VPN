import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:vpn_basic_project/controllers/native_ad_controller.dart';
import 'package:vpn_basic_project/helpers/ad_helper.dart';

import '../apis/apis.dart';
import '../main.dart';
import '../models/ip_details.dart';
import '../models/network_data.dart';
import '../widgets/network_card.dart';

class NetworkTestScreen extends StatelessWidget {
  NetworkTestScreen({super.key});

  final _adController = NativeAdController();
  @override
  Widget build(BuildContext context) {
    final ipData = IPDetails.fromJson({}).obs;
    APIs.getIPDetails(ipData: ipData);
    _adController.ad = AdHelper.loadNativeAd(adController: _adController);
    return Scaffold(
      bottomNavigationBar:
          // Config.hideAds ? null:
          _adController.ad != null && _adController.adLoaded.isTrue
              ? SafeArea(
                  child: SizedBox(
                      height: 85, child: AdWidget(ad: _adController.ad!)))
              : null,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Network Information',
          style: GoogleFonts.roboto(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Color(0xff151a3c)
            : Color(0xff4071ff),
      ),

      //refresh button
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 10),
        child: FloatingActionButton(
            backgroundColor: Theme.of(context).brightness == Brightness.dark
                ? Color(0xff394075)
                : Color(0xff4071ff),
            shape: CircleBorder(),
            onPressed: () {
              ipData.value = IPDetails.fromJson({});
              APIs.getIPDetails(ipData: ipData);
            },
            child: Icon(
              CupertinoIcons.refresh,
              color: Colors.white,
            )),
      ),

      body: Obx(
        () => ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(
                left: mq.width * .04,
                right: mq.width * .04,
                top: mq.height * .01,
                bottom: mq.height * .1),
            children: [
              //ip
              NetworkCard(
                  data: NetworkData(
                      title: 'IP Address',
                      subtitle: ipData.value.query,
                      icon: Icon(CupertinoIcons.location_solid,
                          color: Colors.blue))),

              //isp
              NetworkCard(
                  data: NetworkData(
                      title: 'Internet Provider',
                      subtitle: ipData.value.isp,
                      icon: Icon(Icons.business, color: Colors.orange))),

              //location
              NetworkCard(
                  data: NetworkData(
                      title: 'Location',
                      subtitle: ipData.value.country.isEmpty
                          ? 'Fetching ...'
                          : '${ipData.value.city}, ${ipData.value.regionName}, ${ipData.value.country}',
                      icon: Icon(CupertinoIcons.location, color: Colors.pink))),

              //pin code
              NetworkCard(
                  data: NetworkData(
                      title: 'Pin-code',
                      subtitle: ipData.value.zip,
                      icon: Icon(CupertinoIcons.location_solid,
                          color: Colors.cyan))),

              //timezone
              NetworkCard(
                  data: NetworkData(
                      title: 'Timezone',
                      subtitle: ipData.value.timezone,
                      icon: Icon(CupertinoIcons.time, color: Colors.green))),
            ]),
      ),
    );
  }
}
