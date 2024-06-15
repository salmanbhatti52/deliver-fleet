import 'dart:convert';
import 'package:deliver_partner/RiderScreens/DrivingLicensePictureVerification.dart';
import 'package:deliver_partner/models/API_models/notifciaitonRiderModel.dart';
import 'package:deliver_partner/temploginReider.dart';
import 'package:deliver_partner/utilities/showToast.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:deliver_partner/Constants/Colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:deliver_partner/Constants/back-arrow-with-container.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // ApiServices get service => GetIt.I<ApiServices>();

  // int userID = -1;
  // late SharedPreferences sharedPreferences;
  bool isPageLoading = false;
  NotificationRiderModel notificationRiderModel = NotificationRiderModel();
  notificationData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userID = (sharedPreferences.getInt('userID') ?? -1);
    var headersList = {'Accept': '*/*', 'Content-Type': 'application/json'};
    var url =
        Uri.parse('https://cs.deliverbygfl.com/api/get_notifications_fleet');

    var body = {"users_fleet_id": "$userID", "users_type": "Rider"};

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode == 200) {
      notificationRiderModel = notificationRiderModelFromJson(resBody);
      setState(() {
        isPageLoading = false;
      });
      print(resBody);
    } else {
      print(res.reasonPhrase);
      showToastError('${res.reasonPhrase}', FToast().init(context));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isPageLoading = true;
    });
    notificationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leadingWidth: 70,
        leading: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 20),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: backArrowWithContainer(context),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Notification',
          style: GoogleFonts.syne(
            fontWeight: FontWeight.w700,
            color: black,
            fontSize: 20,
          ),
        ),
      ),
      // backgroundColor: lightWhite,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 30.h),
          child: isPageLoading
              ? const Center(
                  child: CircularProgressIndicator(
                  color: Colors.orange,
                  strokeWidth: 2,
                )) // Show loading indicator while data is loading
              : notificationRiderModel.data!.isEmpty
                  ? Center(
                      child: Text(
                        'You have no unread notifications',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.syne(
                          color: grey,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: notificationRiderModel.data!.length,
                      itemBuilder: (context, index) {
                        var notification = notificationRiderModel.data![index];
                        String formattedDate = DateFormat('d MMMM yyyy, h:mm a')
                            .format(notification.dateAdded!);
                        return Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(5),
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                "https://cs.deliverbygfl.com/public/${notification.senderData!.profilePic!}",
                              ),
                            ),
                            title: Text(
                              "${notification.senderData!.firstName!} ${notification.senderData!.lastName!}",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                Text(
                                  notification.message!,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  formattedDate,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ],
                            ),
                            isThreeLine: true,
                          ),
                        );
                      },
                    ),
        ),
      ),
    );
  }

  Future<void> onRefreshReadNotifications() async {
    notificationData();
  }
}
