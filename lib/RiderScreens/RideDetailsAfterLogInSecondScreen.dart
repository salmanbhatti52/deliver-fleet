import 'dart:io';

import 'package:deliver_partner/FleetScreens/BottomNavBarFleet.dart';
import 'package:deliver_partner/LogInScreen.dart';
import 'package:deliver_partner/widgets/TextFormField_Widget.dart';
import 'package:deliver_partner/widgets/apiButton.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Constants/Colors.dart';
import '../Constants/back-arrow-with-container.dart';
import '../Constants/buttonConatinerWithBorder.dart';
import '../Constants/buttonContainer.dart';
import '../models/API models/API response.dart';
import '../models/API models/AddVehicleModel.dart';
import '../services/API_services.dart';
import '../tempLoginFleet.dart';
import '../utilities/showToast.dart';
import 'BottomNavBar.dart';
import 'RequestRideFromFleetActive.dart';

class RideDetailsAfterLogInSecondScreen extends StatefulWidget {
  final Map addBikeData;
  final String userType;
  final String parentID;
  final String userFleetId;
  const RideDetailsAfterLogInSecondScreen(
      {super.key,
      required this.addBikeData,
      required this.userType,
      required this.parentID,
      required this.userFleetId});

  @override
  State<RideDetailsAfterLogInSecondScreen> createState() =>
      _RideDetailsAfterLogInSecondScreenState();
}

class _RideDetailsAfterLogInSecondScreenState
    extends State<RideDetailsAfterLogInSecondScreen> {
  late TextEditingController expDateOfVehicleController;
  late TextEditingController expDateOfInsuranceController;
  late TextEditingController expDateOfRoadWorthinessController;
  // late TextEditingController costController;
  late TextEditingController manufacturingYearController;

  final GlobalKey<FormState> _key = GlobalKey();

  String? parentID;
  late SharedPreferences sharedPreferences;
  sharePref() async {
    sharedPreferences = await SharedPreferences.getInstance();
    parentID = sharedPreferences.getString('parentID')!;
    print("parentID $parentID");
  }

  bool systemSettings = false;
  String? loginType;

  Future<String?> fetchSystemSettingsDescription28() async {
    const String apiUrl = 'https://deliver.eigix.net/api/get_all_system_data';
    setState(() {
      systemSettings = true;
    });
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON
        final Map<String, dynamic> data = json.decode(response.body);

        // Find the setting with system_settings_id equal to 26
        final setting40 = data['data'].firstWhere(
            (setting) => setting['system_settings_id'] == 40,
            orElse: () => null);
        setState(() {
          systemSettings = false;
        });
        if (setting40 != null) {
          // Extract and return the description if setting 28 exists
          loginType = setting40['description'];

          return loginType;
        } else {
          throw Exception('System setting with ID 40 not found');
        }
      } else {
        // If the server did not return a 200 OK response,
        // throw an exception.
        throw Exception('Failed to fetch system settings');
      }
    } catch (e) {
      // Catch any exception that might occur during the process
      print('Error fetching system settings: $e');
      return null;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchSystemSettingsDescription28();
    sharePref();
    expDateOfVehicleController = TextEditingController();
    expDateOfInsuranceController = TextEditingController();
    expDateOfRoadWorthinessController = TextEditingController();
    print("bikeData ${widget.addBikeData}");
    // costController = TextEditingController();
    manufacturingYearController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    expDateOfVehicleController.dispose();
    expDateOfRoadWorthinessController.dispose();
    expDateOfInsuranceController.dispose();
    // costController.dispose();
    manufacturingYearController.dispose();
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

  /// expiry date of vehicle license date picker:

  String? vehicleLicenseDate;
  Future<void> _vehicleLicenseDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: orange,
              onPrimary: white,
              onSurface: grey,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: orange, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
      initialDatePickerMode: DatePickerMode.day,
      useRootNavigator: true,
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(
        const Duration(
          days: 0,
        ),
      ),
      lastDate: DateTime(3000),
    );

    if (picked != null) {
      setState(() {
        //selectedDate = picked;
        String selectedFormatDate = DateFormat('yyyy-MM-dd').format(picked);
        vehicleLicenseDate = selectedFormatDate;
        expDateOfVehicleController.text = vehicleLicenseDate!;
      });
    }
  }

  /// expiry date of insurance date picker:

  String? insuranceExpiryDate;
  Future<void> _insuranceExpiryDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: orange,
              onPrimary: white,
              onSurface: grey,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: orange, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
      initialDatePickerMode: DatePickerMode.day,
      useRootNavigator: true,
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(
        const Duration(
          days: 0,
        ),
      ),
      lastDate: DateTime(3000),
    );

    if (picked != null) {
      setState(() {
        //selectedDate = picked;
        String selectedFormatDate = DateFormat('yyyy-MM-dd').format(picked);
        insuranceExpiryDate = selectedFormatDate;
        expDateOfInsuranceController.text = insuranceExpiryDate!;
      });
    }
  }

  /// expiry of road worthiness date picker:

  String? expiryOfRoadWorthinessDate;
  Future<void> _expiryOfRoadWorthinessDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: orange,
              onPrimary: white,
              onSurface: grey,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: orange, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
      initialDatePickerMode: DatePickerMode.day,
      useRootNavigator: true,
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(
        const Duration(
          days: 0,
        ),
      ),
      lastDate: DateTime(3000),
    );

    if (picked != null) {
      setState(() {
        //selectedDate = picked;
        String selectedFormatDate = DateFormat('yyyy-MM-dd').format(picked);
        expiryOfRoadWorthinessDate = selectedFormatDate;
        expDateOfRoadWorthinessController.text = expiryOfRoadWorthinessDate!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (systemSettings == true) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: orange,
          ),
        ),
      );
    } else {
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
            'Ride Details',
            style: GoogleFonts.syne(
              fontWeight: FontWeight.w700,
              color: black,
              fontSize: 20,
            ),
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) => GlowingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            color: orange,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0.w),
                child: Form(
                  key: _key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        'Enter Ride Details if you have one or \n request a ride from Fleet Manager.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.syne(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: grey,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      SvgPicture.asset(
                        'assets/images/bike.svg',
                        width: 150.w,
                        height: 120.h,
                        fit: BoxFit.scaleDown,
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      SizedBox(
                        width: 296.w,
                        child: TextFormFieldWidget(
                          onTap: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            await _vehicleLicenseDate(context);
                          },
                          onSaved: (date) {
                            vehicleLicenseDate = date;
                            return null;
                          },
                          readOnly: true,
                          controller: expDateOfVehicleController,
                          textInputType: TextInputType.datetime,
                          enterTextStyle: enterTextStyle,
                          cursorColor: orange,
                          hintText: 'Expiry date of vehicle license',
                          border: border,
                          hintStyle: hintStyle,
                          focusedBorder: focusedBorder,
                          obscureText: null,
                          contentPadding: contentPadding,
                          enableBorder: enableBorder,
                          prefixIcon: null,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'exp. date cannot be empty';
                            }
                            return null;
                          },
                          length: -1,
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      SizedBox(
                        width: 296.w,
                        child: TextFormFieldWidget(
                          onTap: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            await _insuranceExpiryDate(context);
                          },
                          onSaved: (date) {
                            insuranceExpiryDate = date;
                            return null;
                          },
                          readOnly: true,
                          controller: expDateOfInsuranceController,
                          textInputType: TextInputType.datetime,
                          enterTextStyle: enterTextStyle,
                          cursorColor: orange,
                          hintText: 'Expiry date of insurance',
                          border: border,
                          hintStyle: hintStyle,
                          focusedBorder: focusedBorder,
                          obscureText: null,
                          contentPadding: contentPadding,
                          enableBorder: enableBorder,
                          prefixIcon: null,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'exp. date cannot be empty';
                            }
                            return null;
                          },
                          length: -1,
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      SizedBox(
                        width: 296.w,
                        child: TextFormFieldWidget(
                          onTap: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            await _expiryOfRoadWorthinessDate(context);
                          },
                          onSaved: (date) {
                            expiryOfRoadWorthinessDate = date;
                            return null;
                          },
                          readOnly: true,
                          controller: expDateOfRoadWorthinessController,
                          textInputType: TextInputType.datetime,
                          enterTextStyle: enterTextStyle,
                          cursorColor: orange,
                          hintText:
                              'Certificate of road worthiness expiry date',
                          border: border,
                          hintStyle: hintStyle,
                          focusedBorder: focusedBorder,
                          obscureText: null,
                          contentPadding: contentPadding,
                          enableBorder: enableBorder,
                          prefixIcon: null,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'exp. date cannot be empty';
                            }
                            return null;
                          },
                          length: -1,
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      // SizedBox(
                      //   width: 140.w,
                      //   child: TextFormFieldWidget(
                      //     controller: costController,
                      //     textInputType: TextInputType.number,
                      //     enterTextStyle: enterTextStyle,
                      //     cursorColor: orange,
                      //     hintText: '₦ Cost',
                      //     border: border,
                      //     hintStyle: hintStyle,
                      //     focusedBorder: focusedBorder,
                      //     obscureText: null,
                      //     contentPadding: contentPadding,
                      //     enableBorder: enableBorder,
                      //     prefixIcon: null,
                      //     validator: (val) {
                      //       if (val!.isEmpty) {
                      //         return 'cost cannot be empty';
                      //       }
                      //       return null;
                      //     },
                      //     length: -1,
                      //   ),
                      // ),
                      SizedBox(
                        width: 296.w,
                        child: TextFormFieldWidget(
                          controller: manufacturingYearController,
                          textInputType: TextInputType.number,
                          enterTextStyle: enterTextStyle,
                          cursorColor: orange,
                          hintText: 'Manufacturing Year',
                          border: border,
                          hintStyle: hintStyle,
                          focusedBorder: focusedBorder,
                          obscureText: null,
                          contentPadding: contentPadding,
                          enableBorder: enableBorder,
                          prefixIcon: null,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'year cannot be empty';
                            }
                            return null;
                          },
                          length: -1,
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      isAddingBike
                          ? apiButton(context)
                          : GestureDetector(
                              onTap: () async {
                                await _deviceDetails();
                                await addBike(context);
                              },
                              child: buttonContainer(context, 'NEXT'),
                            ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  String deviceName = '';
  String deviceVersion = '';
  String identifier = '';

  Future<void> _deviceDetails() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        setState(() {
          deviceName = build.model;
          deviceVersion = build.version.toString();
          identifier = build.androidId;
          print('device id for android while registering:  $identifier');
        });
        //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        setState(() {
          deviceName = data.name;
          deviceVersion = data.systemVersion;
          identifier = data.identifierForVendor;
        }); //UUID for iOS
      }
    } on PlatformException catch (e) {
      debugPrint() {
        return e.toString();
      }
    }
  }

  ApiServices get service => GetIt.I<ApiServices>();
  bool isAddingBike = false;
  APIResponse<AddVehicleModel>? addVehicleResponse;
  Future<void> addBike(BuildContext context) async {
    if (_key.currentState!.validate()) {
      setState(() {
        isAddingBike = true;
      });
      widget.addBikeData.addAll({
        "vehicle_license_expiry_date": expDateOfVehicleController.text,
        "vehicle_insurance_expiry_date": expDateOfInsuranceController.text,
        "rwc_expiry_date": expDateOfRoadWorthinessController.text,
        "cost": '',
        "manufacture_year": manufacturingYearController.text,
      });
      print('vehicle_license_expiry_date ${expDateOfVehicleController.text}');
      print("bikedata ${widget.addBikeData}");
      print(
          'vehicle_insurance_expiry_date ${expDateOfInsuranceController.text}');
      print('rwc_expiry_date ${expDateOfRoadWorthinessController.text}');
      print('manufacture_year ${manufacturingYearController.text}');
      addVehicleResponse = await service.addVehicleAPI(widget.addBikeData);
      print(
          "addVehicleResponse!.status!.toLowerCase() ${addVehicleResponse!.status!.toLowerCase()}");
      if (addVehicleResponse!.status!.toLowerCase() == 'success') {
        print("status ${addVehicleResponse!.status!.toLowerCase()}");
        showToastSuccess(
            'Your bike is added successfully', FToast().init(context));
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => widget.userType == 'Rider'
        //         ? const BottomNavBar()
        //         : const BottomNavBarFleet(),
        //   ),
        // );
        loginType == "Email"
            ? Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TempLoginFleet(
                      userType: widget.userFleetId,
                      deviceID: identifier.toString(),
                      phoneNumber: "1234"),
                ),
              )
            : Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => LogInScreen(
                    userType: widget.userFleetId,
                    deviceID: identifier.toString(),
                  ),
                ),
              );
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => LogInScreen(userType: widget.userType),
        //   ),
        // );
      } else {
        print(
            'error   ${addVehicleResponse!.status}  ${addVehicleResponse!.message}');
        showToastError(addVehicleResponse!.status, FToast().init(context));
      }
    }
    setState(() {
      isAddingBike = false;
    });
  }
}
