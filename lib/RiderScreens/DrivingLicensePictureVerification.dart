import 'dart:convert';
import 'dart:io';

import 'package:deliver_partner/widgets/apiButton.dart';
import 'package:deliver_partner/widgets/customDialogForImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_gif/flutter_gif.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/Colors.dart';
import '../Constants/back-arrow-with-container.dart';
import '../Constants/buttonContainer.dart';
import '../LogInScreen.dart';
import '../models/API models/API response.dart';
import '../services/API_services.dart';
import '../utilities/showToast.dart';
import 'RideDetailsAfterLogIn.dart';

int? fleetId;
String? parentId;
int? userID;

class DrivingLicensePictureVerification extends StatefulWidget {
  final Map licenseMap;
  File? profileImage;
  final String userType;

  DrivingLicensePictureVerification(
      {super.key,
      required this.licenseMap,
      this.profileImage,
      required this.userType});

  @override
  State<DrivingLicensePictureVerification> createState() =>
      _DrivingLicensePictureVerificationState();
}

class _DrivingLicensePictureVerificationState
    extends State<DrivingLicensePictureVerification>
    with TickerProviderStateMixin {
  // late FlutterGifController gifController;

  ApiServices get service => GetIt.I<ApiServices>();

  sharedPrefs() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    fleetId = sharedPref.getInt('userID');
    parentId = sharedPref.getString('userEmail');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // gifController = FlutterGifController(vsync: this);
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   gifController.repeat(
    //     min: 0,
    //     max: 60,
    //     period: const Duration(seconds: 2),
    //   );
    // });
  }

  Future<void> imageSelection(ImageSource imageSource, int selection) async {
    try {
      if (selection == 0) {
        XFile? imageFile1 = await ImagePicker().pickImage(
            source: imageSource,
            imageQuality: 30,
            preferredCameraDevice: CameraDevice.rear,
            maxHeight: 800,
            maxWidth: 1000);
        if (imageFile1 != null) {
          Uint8List imageByte = await imageFile1.readAsBytes();
          final imageTemporary = File(imageFile1.path);
          setState(() {
            xFile = imageFile1;
            imagePath = imageTemporary;
            base64img = base64.encode(imageByte);
          });
        } else {
          showToastError("You didn't take any picture", FToast().init(context));
        }
      } else if (selection == 1) {
        XFile? imageFile1 = await ImagePicker().pickImage(
            source: imageSource,
            imageQuality: 30,
            preferredCameraDevice: CameraDevice.rear,
            maxHeight: 800,
            maxWidth: 1000);
        if (imageFile1 != null) {
          Uint8List imageByte = await imageFile1.readAsBytes();
          final imageTemporary = File(imageFile1.path);
          setState(() {
            xFileForBack = imageFile1;
            imagePathForBack = imageTemporary;
            base64imgForBack = base64.encode(imageByte);
          });
        } else {
          showToastError("You didn't take any picture", FToast().init(context));
        }
      } else {
        showToastError("You didn't take any picture", FToast().init(context));
      }
    } catch (e) {
      showToastError("CATCH " + e.toString(), FToast().init(context));
    }
  }

  /// front image of license
  File? imagePath;
  String? base64img;
  XFile? xFile;

  // Future pickCoverImageForFront() async {
  //   print("abc");
  //   try {
  //     final ImagePicker picker = ImagePicker();
  //     xFile = await picker.pickImage(source: ImageSource.gallery);
  //     if (xFile == null) return;
  //
  //     Uint8List imageByte = await xFile!.readAsBytes();
  //
  //     final imageTemporary = File(xFile!.path);
  //
  //     setState(() {
  //       imagePath = imageTemporary;
  //       base64img = base64.encode(imageByte);
  //       print("base64img $base64img");
  //       print("newImage $imagePath");
  //     });
  //   } on PlatformException catch (e) {
  //     print('Failed to pick image: ${e.toString()}');
  //   }
  // }

  /// back image of license
  File? imagePathForBack;
  String? base64imgForBack;
  XFile? xFileForBack;

  // Future pickCoverImage() async {
  //   print("abc");
  //   try {
  //     final ImagePicker picker = ImagePicker();
  //     xFileForBack = await picker.pickImage(source: ImageSource.gallery);
  //     if (xFileForBack == null) return;
  //
  //     Uint8List imageByte = await xFileForBack!.readAsBytes();
  //
  //     final imageTemporary = File(xFileForBack!.path);
  //
  //     setState(() {
  //       imagePathForBack = imageTemporary;
  //       base64imgForBack = base64.encode(imageByte);
  //       print("base64img $base64imgForBack");
  //       print("newImage $imagePathForBack");
  //     });
  //   } on PlatformException catch (e) {
  //     print('Failed to pick image: ${e.toString()}');
  //   }
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
          leading: Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 20),
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: backArrowWithContainer(context),
            ),
          ),
        ),
        body: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: orange,
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.0.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  Center(
                    child: Text(
                      'Driving License Verification',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.syne(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'Upload front and back side your\n driving license',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.syne(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: grey,
                    ),
                  ),
                  SizedBox(
                    height: 26.h,
                  ),
                  Text(
                    'Front Side',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: black,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  GestureDetector(
                    onTap: () => showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomDialogBox(
                              name: 'Back',
                              onCameraBTNPressed: () {
                                imageSelection(ImageSource.camera, 0);
                              },
                              onGalleryBTNPressed: () {
                                imageSelection(ImageSource.gallery, 0);
                              });
                        }),
                    child: imagePath != null
                        ? SizedBox(
                            width: double.infinity,
                            height: 200.h,
                            child: Image.file(
                              imagePath!,
                              fit: BoxFit.cover,
                            ))
                        : SvgPicture.asset(
                            'assets/images/upload-pic.svg',
                            fit: BoxFit.scaleDown,
                          ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Text(
                    'Back Side',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: black,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  GestureDetector(
                    onTap: () => showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomDialogBox(
                              name: 'BACK',
                              onCameraBTNPressed: () {
                                imageSelection(ImageSource.camera, 1);
                              },
                              onGalleryBTNPressed: () {
                                imageSelection(ImageSource.gallery, 1);
                              });
                        }),
                    child: imagePathForBack != null
                        ? SizedBox(
                            width: double.infinity,
                            height: 200.h,
                            child: Image.file(
                              imagePathForBack!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : SvgPicture.asset(
                            'assets/images/upload-pic.svg',
                            fit: BoxFit.scaleDown,
                          ),
                  ),
                  SizedBox(
                    height: 80.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 20,
                    ),
                    child: isVerifying
                        ? apiButton(context)
                        : GestureDetector(
                            onTap: () => licenseVerify(context),
                            child: buttonContainer(context, 'VERIFY'),
                          ),
                  ),
                ],
              ),
            )),
          ),
        ),
      ),
    );
  }

  bool isVerifying = false;
  APIResponse<APIResponse>? verifyResponse;
  String? deviceIDInfo;

  licenseVerify(BuildContext context) async {
    if (xFile != null && xFileForBack != null) {
      setState(() {
        isVerifying = true;
      });
      widget.licenseMap.addAll({
        "driving_license_front_image": base64img,
        "driving_license_back_image": base64imgForBack,
      });

      verifyResponse = await service.verifyDrivingLicenseAPI(widget.licenseMap);
      if (verifyResponse!.status!.toLowerCase() == 'success') {
        SharedPreferences sharedPref = await SharedPreferences.getInstance();
        userID = (sharedPref.getInt('userID') ?? null);
        deviceIDInfo = (sharedPref.getString('deviceIDInfo') ?? null);
        print("userId value is = $userID");
        print("deviceIDInfo = $deviceIDInfo");
        if (userID != null) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => RideDetailsAfterLogInScreen(
                  userType: 'Rider',
                  userFleetId: fleetId.toString(),
                  parentID: parentId.toString(),
                ),
              ),
              (route) => false);
        } else {
          showToastSuccess(verifyResponse!.message, FToast().init(context));
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => LogInScreen(
                  userType: 'Rider',
                  deviceID: deviceIDInfo,
                ),
              ),
              (route) => false);
        }
      } else {
        showToastError(verifyResponse!.message, FToast().init(context));
      }
      setState(() {
        isVerifying = false;
      });
    } else {
      showToastError('Please provide license pictures', FToast().init(context));
    }
  }
}
