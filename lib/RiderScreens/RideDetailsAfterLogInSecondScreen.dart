import 'package:Deliver_Rider/FleetScreens/BottomNavBarFleet.dart';
import 'package:Deliver_Rider/widgets/TextFormField_Widget.dart';
import 'package:Deliver_Rider/widgets/apiButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../Constants/Colors.dart';
import '../Constants/back-arrow-with-container.dart';
import '../Constants/buttonConatinerWithBorder.dart';
import '../Constants/buttonContainer.dart';
import '../models/API models/API response.dart';
import '../models/API models/AddVehicleModel.dart';
import '../services/API_services.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    expDateOfVehicleController = TextEditingController();
    expDateOfInsuranceController = TextEditingController();
    expDateOfRoadWorthinessController = TextEditingController();
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
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
                              onTap: () {
                                addBike(context);
                              },
                              child: buttonContainer(context, 'NEXT'),
                            ),
                      SizedBox(
                        height: 20.h,
                      ),
                      widget.parentID == '0'
                          ? const SizedBox()
                          : GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      RequestRideFromFleetActive(
                                    parentID: widget.parentID,
                                    userFleetId: widget.userFleetId,
                                  ),
                                ),
                              ),
                              child: buttonContainerWithBorder(
                                  context, "REQUEST A BIKE"),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  ApiServices get service => GetIt.I<ApiServices>();
  bool isAddingBike = false;
  APIResponse<AddVehicleModel>? addVehicleResponse;
  addBike(BuildContext context) async {
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
      print('vehicle_insurance_expiry_date ${expDateOfInsuranceController.text}');
      print('rwc_expiry_date ${expDateOfRoadWorthinessController.text}');
      print('manufacture_year ${manufacturingYearController.text}');
      addVehicleResponse = await service.addVehicleAPI(widget.addBikeData);
      if (addVehicleResponse!.status!.toLowerCase() == 'success') {
        print("status ${addVehicleResponse!.status!.toLowerCase()}");
        showToastSuccess(
            'Your bike is added successfully', FToast().init(context));
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => widget.userType == 'Rider'
                ? const BottomNavBar()
                : const BottomNavBarFleet(),
          ),
        );
      } else {
        print('error   ' +
            addVehicleResponse!.status.toString() +
            '  ' +
            addVehicleResponse!.message.toString());
        showToastError(addVehicleResponse!.status, FToast().init(context));
      }
    }
    setState(() {
      isAddingBike = false;
    });
  }
}
