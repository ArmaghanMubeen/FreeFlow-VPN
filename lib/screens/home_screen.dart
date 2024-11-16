import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vpn_basic_project/widgets/country_map.dart';
import '../controllers/home_controller.dart';
import '../helpers/pref.dart';
import '../main.dart';
import '../models/vpn_status.dart';
import '../services/vpn_engine.dart';
import '../widgets/count_down_timer.dart';
import '../widgets/home_card.dart';
import 'location_screen.dart';
import 'network_test_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.sizeOf(context);

    ///Add listener to update vpn state
    VpnEngine.vpnStageSnapshot().listen((event) {
      _controller.vpnState.value = event;
    });

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Color(0xff151a3c)
            : Color(0xff4071ff),
        centerTitle: false,
        title: Text(
          'FreeFlow VPN',
          style: GoogleFonts.roboto(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.changeThemeMode(
                  Pref.isDarkMode ? ThemeMode.light : ThemeMode.dark);
              Pref.isDarkMode = !Pref.isDarkMode;
            },
            icon: Icon(
              Icons.brightness_medium,
              color: Colors.white,
            ),
          ),
          IconButton(
            padding: EdgeInsets.only(right: 8),
            onPressed: () => Get.to(() => NetworkTestScreen()),
            icon: Icon(
              CupertinoIcons.info,
              color: Colors.white,
            ),
          ),
        ],
      ),

      //body
      body: Column(children: [
        SizedBox(
          height: 30,
        ),
        //vpn button
        Obx(() => _vpnButton(context)),
        SizedBox(
          height: 20,
        ),
        StreamBuilder<VpnStatus?>(
          initialData: VpnStatus(),
          stream: VpnEngine.vpnStatusSnapshot(),
          builder: (context, snapshot) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // download
              HomeCard(
                title: '${snapshot.data?.byteIn ?? '0 kbps'}',
                subtitle: 'DOWNLOAD',
              ),
              Container(
                width: 0.5,
                height: 30,
                color: Colors.grey,
              ),
              // upload
              HomeCard(
                title: '${snapshot.data?.byteOut ?? '0 kbps'}',
                subtitle: 'UPLOAD',
              ),
            ],
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Obx(() => CountryMap(
              selectedCountry: _controller.vpn.value.countryLong,
            )),
      ]),
    );
  }

  //vpn button
  Widget _vpnButton(BuildContext context) => Column(
        children: [
          Text(
            'Connection Time',
            style: GoogleFonts.roboto(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xff9ba1c6),
            ),
          ),
          //count down timer
          Obx(() => CountDownTimer(
              startTimer:
                  _controller.vpnState.value == VpnEngine.vpnConnected)),
          SizedBox(
            height: 15,
          ),
          //button
          Semantics(
            button: true,
            child: InkWell(
                onTap: () {
                  _controller.connectToVpn(
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black);
                },
                borderRadius: BorderRadius.circular(100),
                child: Theme.of(context).brightness == Brightness.dark
                    ? Container(
                        width: mq.height * .14,
                        height: mq.height * .14,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff151a3c),
                          border: Border.all(
                            color: Colors.white,

                            width: 3.0, // width of the border
                          ),
                        ),
                        child: Icon(Icons.power_settings_new,
                            size: 28, color: Colors.white),
                      )
                    : Container(
                        width: mq.height * .14,
                        height: mq.height * .14,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _controller.getButtonColor.withOpacity(.1),
                        ),
                        child: Container(
                          width: mq.height * .14,
                          height: mq.height * .14,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _controller.getButtonColor.withOpacity(.3),
                          ),
                          child: Container(
                            width: mq.height * .14,
                            height: mq.height * .14,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _controller.getButtonColor,
                            ),
                            child: Icon(
                              Icons.power_settings_new,
                              size: 24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            margin:
                EdgeInsets.only(top: mq.height * .015, bottom: mq.height * .02),
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Color(0xff151a3c)
                    : Colors.white,
                border: Border.all(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Color(0xff4071ff)), // color of the border

                borderRadius: BorderRadius.circular(15)),
            child: Text(
              _controller.vpnState.value == VpnEngine.vpnDisconnected
                  ? 'Not Connected'
                  : _controller.vpnState.replaceAll('_', ' ').toUpperCase(),
              style: GoogleFonts.roboto(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Color(0xff4071ff)),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Obx(() => _changeLocation(context)),
        ],
      );

  Widget _changeLocation(BuildContext context) => Semantics(
        button: true,
        child: InkWell(
          highlightColor: Colors.transparent, // Add this line
          splashColor: Colors.transparent, // Add this line
          onTap: () => Get.to(() => LocationScreen()),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
            child: Material(
              elevation: 5.0, // Add the elevation value you want here
              borderRadius: BorderRadius.circular(15),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Color(0xff1e264f)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: mq.width * .04, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // icon
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.blue,
                      child: _controller.vpn.value.countryLong.isEmpty
                          ? Icon(Icons.vpn_lock_rounded,
                              size: 15, color: Colors.white)
                          : null,
                      backgroundImage: _controller.vpn.value.countryLong.isEmpty
                          ? null
                          : AssetImage(
                              'assets/flags/${_controller.vpn.value.countryShort.toLowerCase()}.png'),
                    ),

                    // for adding some space
                    SizedBox(width: 10),

                    _controller.vpn.value.countryLong.isEmpty
                        ? Text(
                            "Select Country",
                            style: GoogleFonts.roboto(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _controller.vpn.value.countryLong,
                                style: GoogleFonts.roboto(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black),
                              ),
                              Text(
                                _controller.vpn.value.ip,
                                style: GoogleFonts.roboto(
                                    fontSize: 13, color: Color(0xff9ba1c6)),
                              ),
                            ],
                          ),

                    // for covering available spacing
                    Spacer(),

                    // icon
                    CircleAvatar(
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? Color(0xff394075)
                              : Colors.white,
                      child: Icon(
                        Icons.keyboard_arrow_right_rounded,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                        size: 22,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
