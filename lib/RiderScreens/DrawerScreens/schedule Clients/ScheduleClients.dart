import 'package:deliver_partner/Constants/Colors.dart';
import 'package:deliver_partner/RiderScreens/DrawerScreens/schedule%20Clients/scheduled_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Constants/PageLoadingKits.dart';
import '../../../Constants/back-arrow-with-container.dart';
import '../../../models/API models/API response.dart';
import '../../../models/API models/ScheduledRiderModel.dart';
import '../../../services/API_services.dart';
import '../../../utilities/showToast.dart';

class ScheduleClients extends StatefulWidget {
  const ScheduleClients({super.key});

  @override
  State<ScheduleClients> createState() => _ScheduleClientsState();
}

class _ScheduleClientsState extends State<ScheduleClients> {
  ApiServices get service => GetIt.I<ApiServices>();

  late ScrollController scrollController;

  int userID = -1;
  late SharedPreferences sharedPreferences;
  bool isPageLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
    isPageLoading = true;
  }

  APIResponse<List<ScheduledRiderModel>>? scheduledRidesResponse;
  List<ScheduledRiderModel>? scheduledRidesList;

  String? imageHolder;

  init() async {
    scrollController = ScrollController();

    sharedPreferences = await SharedPreferences.getInstance();
    userID = (sharedPreferences.getInt('userID') ?? -1);
    print('object userId on Scheduled rides is: $userID');

    Map data = {
      "users_fleet_id": userID.toString(),
    };

    scheduledRidesResponse = await service.scheduledRidesAPI(data);
    scheduledRidesList = [];

    if (scheduledRidesResponse!.status!.toLowerCase() == 'success') {
      if (scheduledRidesResponse!.data != null) {
        scheduledRidesList = scheduledRidesResponse!.data!;
      }
    } else {
      print(
          'object massage:  ${scheduledRidesResponse!.message}   ${scheduledRidesResponse!.status}');
      showToastError(scheduledRidesResponse!.message!, FToast().init(context));
    }
    setState(() {
      isPageLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leadingWidth: 70,
          centerTitle: true,
          title: Text(
            'Schedule Rides',
            style: GoogleFonts.syne(
              fontWeight: FontWeight.w700,
              color: black,
              fontSize: 20,
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 20),
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: backArrowWithContainer(context),
            ),
          ),
        ),
        body: isPageLoading
            ? spinKitRotatingCircle
            : scheduledRidesList!.isEmpty
                ? Center(child: Lottie.asset('assets/images/no-data.json'))
                : ListView.builder(
                    itemCount: scheduledRidesList!.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return ScheduledScreen(
                        scheduledRiderModel: scheduledRidesList![index],
                      );
                    },
                  ),
      ),
    );
  }
}
