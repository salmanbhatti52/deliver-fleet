import 'package:Deliver_Rider/Constants/Colors.dart';
import 'package:Deliver_Rider/RiderScreens/DrawerScreens/schedule%20Clients/scheduled_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Constants/back-arrow-with-container.dart';
import '../../../models/API models/API response.dart';
import '../../../services/API_services.dart';

class ScheduleClients extends StatefulWidget {
  const ScheduleClients({super.key});

  @override
  State<ScheduleClients> createState() => _ScheduleClientsState();
}

class _ScheduleClientsState extends State<ScheduleClients> {
  ApiServices get service => GetIt.I<ApiServices>();

  int userID = -1;
  late SharedPreferences sharedPreferences;
  bool isPageLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // init();
    isPageLoading = true;
  }

  // APIResponse<GetAllAvailableVehicles>? vehicleDetailsResponse;
  //
  // init() async {
  //   sharedPreferences = await SharedPreferences.getInstance();
  //   userID = (sharedPreferences.getInt('userID') ?? -1);
  //
  //   Map data = {
  //     "users_fleet_id": userID.toString(),
  //     "user_type": "Rider",
  //   };
  //
  //   vehicleDetailsResponse = await service.getVehicleDetailsForRiderAPI(data);
  //
  //   if (vehicleDetailsResponse!.status!.toLowerCase() == 'success') {
  //     if (vehicleDetailsResponse!.data != null) {
  //       showToastSuccess('getting vehicle details', FToast().init(context),
  //           seconds: 1);
  //     }
  //   } else {
  //     showToastError(vehicleDetailsResponse!.message!, FToast().init(context));
  //   }
  //   setState(() {
  //     isPageLoading = false;
  //   });
  // }

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
            'Schedule Clients',
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
                const ScheduledScreen(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
