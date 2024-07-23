import 'dart:convert';
import 'package:deliver_partner/Constants/buttonContainer.dart';
import 'package:deliver_partner/RiderScreens/DrivingLicensePictureVerification.dart';
import 'package:deliver_partner/models/API_models/getFleetVehicleAvailable.dart';
import 'package:deliver_partner/temploginReider.dart';
import 'package:deliver_partner/utilities/showToast.dart';
import 'package:deliver_partner/widgets/TextFormField_Widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:deliver_partner/Constants/Colors.dart';
import 'package:deliver_partner/FleetScreens/CalenderScreens/CalenderWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddFleetVehicleTask extends StatefulWidget {
  const AddFleetVehicleTask({super.key});

  @override
  State<AddFleetVehicleTask> createState() => _AddFleetVehicleTaskState();
}

class _AddFleetVehicleTaskState extends State<AddFleetVehicleTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool _isAddingTask = false;
  var status;
  var message;
  addTask() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userID = (sharedPreferences.getInt('userID') ?? -1);
    String taskDate = formattedDate?.isEmpty ?? true
        ? DateFormat('yyyy-MM-dd').format(DateTime
            .now()) // Format today's date if formattedDate is null or empty
        : formattedDate!;
    var headersList = {'Accept': '*/*', 'Content-Type': 'application/json'};
    var url = Uri.parse('https://deliverbygfl.com/api/add_fleet_vehicle_task');

    var body = {
      "users_fleet_vehicles_id": "$vehicleId",
      "users_fleet_id": "$assignedVehicleUserId",
      "name": titleController.text,
      "description": descriptionController.text,
      "task_date": taskDate
    };
    print("body: $body");

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();
    var data = json.decode(resBody);
    print("$data");
    status = data['status'];
    message = data['message'];

    if (res.statusCode == 200) {
      print("status: $status");
      Navigator.of(context).pop();
      print(resBody);
      showToastSuccess('$message', FToast().init(context));
    } else {
      print(res.reasonPhrase);
      showToastSuccess('${res.reasonPhrase}', FToast().init(context));
    }
  }

  GetFleetVehiclesAvailable getFleetVehiclesAvailable =
      GetFleetVehiclesAvailable();
  getFleetVehicleAvailable() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userID = (sharedPreferences.getInt('userID') ?? -1);
    var headersList = {'Accept': '*/*', 'Content-Type': 'application/json'};
    var url = Uri.parse('https://deliverbygfl.com/api/get_fleet_vehicles_all');

    var body = {"users_fleet_id": "$userID"};

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode == 200) {
      print(resBody);
      getFleetVehiclesAvailable = getFleetVehiclesAvailableFromJson(resBody);
      setState(() {});
    } else {
      print(res.reasonPhrase);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFleetVehicleAvailable();
  }

  String? formattedDate;
  String? vehicleId;
  String? assignedVehicleUserId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leadingWidth: 70,
        centerTitle: true,
        title: Text(
          'Add Task',
          style: GoogleFonts.syne(
            fontWeight: FontWeight.w700,
            color: black,
            fontSize: 20,
          ),
        ),
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.black),
        // leading: Padding(
        //   padding: const EdgeInsets.only(top: 8.0, left: 20),
        //   child: GestureDetector(
        //     onTap: () => Navigator.of(context).pop(),
        //     child: backArrowWithContainer(context),
        //   ),
        // ),
      ),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          CalenderWidget(
            onDateSelected: (DateTime selectedDate) {
              // Format the selected date
              formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
              print("Formatted selected date: $formattedDate");
              // Use the formatted date string for your needs
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 15),
            child: Row(
              children: [
                Text(
                  'Select Vehicle',
                  style: GoogleFonts.syne(
                    fontWeight: FontWeight.w700,
                    color: black,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButtonHideUnderline(
                child: DropdownButtonFormField<String>(
                  value: vehicleId,
                  onChanged: (newValue) {
                    setState(() {
                      vehicleId = newValue;
                      print("vId: $vehicleId");
                    });
                  },
                  items: getFleetVehiclesAvailable.data
                          ?.where((vehicle) =>
                              vehicle.usersFleetVehiclesAssigned != null)
                          .map((vehicle) {
                        assignedVehicleUserId = vehicle
                            .usersFleetVehiclesAssigned!.usersFleetId
                            .toString();
                        print("assignedVehicleUserId: $assignedVehicleUserId");
                        return DropdownMenuItem<String>(
                          value: vehicle.usersFleetVehiclesId
                              .toString(), // Keep using the vehicle ID as the value
                          child: Text(vehicle
                              .model), // Example to show the fleet ID in the dropdown
                        );
                      }).toList() ??
                      [],
                  style: TextStyle(
                    color: blackColor,
                    fontSize: 14,
                    fontFamily: 'Inter-Regular',
                    // fontWeight: FontWeight.w900,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: filledColor,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide.none,
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(
                        color: redColor,
                        width: 1,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    hintText: 'Select Vehicle',
                    hintStyle: TextStyle(
                      color: hintColor,
                      fontSize: 12,
                      fontFamily: 'Inter-Light',
                    ),
                    errorStyle: TextStyle(
                      color: redColor,
                      fontSize: 10,
                      fontFamily: 'Inter-Bold',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 15),
            child: Row(
              children: [
                Text(
                  'Add Title',
                  style: GoogleFonts.syne(
                    fontWeight: FontWeight.w700,
                    color: black,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormFieldWidget(
              controller: titleController,
              textInputType: TextInputType.name,
              enterTextStyle: enterTextStyle,
              cursorColor: orange,
              hintText: 'Title',
              border: border,
              hintStyle: hintStyle,
              focusedBorder: focusedBorder,
              obscureText: null,
              contentPadding: contentPadding,
              enableBorder: enableBorder,
              prefixIcon: null,
              length: -1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 15),
            child: Row(
              children: [
                Text(
                  'Add Description',
                  style: GoogleFonts.syne(
                    fontWeight: FontWeight.w700,
                    color: black,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormFieldWidget(
              controller: descriptionController,
              textInputType: TextInputType.name,
              enterTextStyle: enterTextStyle,
              cursorColor: orange,
              hintText: 'Description',
              border: border,
              hintStyle: hintStyle,
              focusedBorder: focusedBorder,
              obscureText: null,
              contentPadding: contentPadding,
              enableBorder: enableBorder,
              prefixIcon: null,
              length: -1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () async {
                setState(() {
                  _isAddingTask =
                      true; // Step 2: Set to true when starting to add task
                });
                await addTask();
                setState(() {
                  _isAddingTask =
                      false; // Set back to false when task addition is complete
                });
              },
              child: _isAddingTask
                  ? const Center(
                      child:
                          CircularProgressIndicator()) // Step 3: Show progress indicator
                  : buttonContainer(context,
                      'Add Task'), // Show the button if not adding task
            ),
          )
        ]),
      ),
    );
  }

  final hintStyle = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w300,
    color: black,
  );

  final enterTextStyle = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w300,
    color: black,
  );

  final focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: orange,
    ),
  );
  final border = const OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
    borderSide: BorderSide.none,
  );
  final enableBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
    borderSide: BorderSide.none,
  );

  final contentPadding =
      const EdgeInsets.symmetric(horizontal: 14, vertical: 16);
}
