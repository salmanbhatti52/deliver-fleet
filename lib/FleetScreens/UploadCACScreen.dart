import 'dart:convert';
import 'dart:io';

import 'package:deliver_partner/Constants/buttonConatinerWithBorder.dart';
import 'package:deliver_partner/widgets/apiButton.dart';
import 'package:deliver_partner/widgets/customDialogForImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import '../models/API_models/API_response.dart';
import '../models/APIModelsFleet/UploadCACCertificateModel.dart';
import '../services/API_services.dart';
import '../utilities/showToast.dart';
import 'BottomNavBarFleet.dart';

class UploadCACScreen extends StatefulWidget {
  const UploadCACScreen({
    super.key,
  });

  @override
  State<UploadCACScreen> createState() => _UploadCACScreenState();
}

class _UploadCACScreenState extends State<UploadCACScreen>
    with TickerProviderStateMixin {
  ApiServices get service => GetIt.I<ApiServices>();

  int userID = -1;
  late SharedPreferences sharedPreferences;
  int? checked;
  bool isPageLoading = false;
  String isLogin = 'false';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checked = -1;
    setState(() {
      isPageLoading = true;
    });
    init();
  }

  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userID = (sharedPreferences.getInt('userID') ?? -1);

    isLogin = (sharedPreferences.getString('isLogin')) ?? 'false';

    setState(() {
      isPageLoading = false;
    });
  }

  Future<void> imageSelection(ImageSource imageSource, int selection) async {
    try {
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
        showToastError("You didn't Take Any Picture", FToast().init(context));
      }
    } catch (e) {
      showToastError("CATCH $e", FToast().init(context));
    }
  }

  /// front image of license
  File? imagePath;
  String? base64img;
  XFile? xFile;

  @override
  Widget build(BuildContext context) {
    return isPageLoading
        ? apiButton(context)
        : Scaffold(
            backgroundColor: white,
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
                          'Upload CAC Certificate',
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
                        'Upload your CAC certificate to verify your\n business',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.syne(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: grey,
                        ),
                      ),
                      SizedBox(
                        height: 100.h,
                      ),
                      Text(
                        'Click to upload',
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
                        height: 200.h,
                      ),
                      isUploading
                          ? apiButton(context)
                          : GestureDetector(
                              onTap: () => uploadCertificate(context),
                              child: buttonContainer(context, 'UPLOAD'),
                            ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 20.h,
                        ),
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const BottomNavBarFleet(),
                            ),
                          ),
                          child: buttonContainerWithBorder(
                              context, 'SKIP FOR NOW'),
                        ),
                      ),
                    ],
                  ),
                )),
              ),
            ),
          );
  }

  bool isUploading = false;
  APIResponse<UploadCACCertificateModel>? _uploadResponse;
  uploadCertificate(BuildContext context) async {
    setState(() {
      isUploading = true;
    });

    Map uploadData = {
      "users_fleet_id": userID.toString(),
      "cac_certificate": base64img,
    };

    _uploadResponse = await service.uploadCACApi(uploadData);
    if (_uploadResponse!.status!.toLowerCase() == 'success') {
      if (_uploadResponse!.data != null) {
        showToastSuccess(
            'certificate successfully uploaded', FToast().init(context));
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const BottomNavBarFleet(),
          ),
        );
      } else {
        showToastError(_uploadResponse!.message, FToast().init(context));
      }
    } else {
      showToastError(
          'Please provide your CAC certificate', FToast().init(context));
    }
    setState(() {
      isUploading = false;
    });
  }

  // bool isVerifying = false;
  // APIResponse<APIResponse>? verifyResponse;
  //
  // licenseVerify(BuildContext context) async {
  //   if (xFile != null && xFileForBack != null) {
  //     setState(() {
  //       isVerifying = true;
  //     });
  //     widget.licenseMap.addAll({
  //       "license_front_image": base64img,
  //       "license_back_image": base64imgForBack,
  //     });
  //     print('object  ' + widget.licenseMap['profile_pic'].toString());
  //     verifyResponse = await service.verifyDrivingLicenseAPI(widget.licenseMap);
  //     if (verifyResponse!.status!.toLowerCase() == 'success') {
  //       print('map data  ' + widget.licenseMap.toString());
  //       showToastSuccess(verifyResponse!.message, FToast().init(context));
  //       Navigator.of(context).push(
  //         MaterialPageRoute(
  //           builder: (context) => CongratulationsScreenDriving(
  //             licenseMap: widget.licenseMap,
  //             profileImage:
  //             widget.profileImage != null ? widget.profileImage : null,
  //             licenseFrontImage: imagePath!,
  //             licenseBackImage: imagePathForBack!,
  //           ),
  //         ),
  //       );
  //     } else {
  //       print('object   message  ' + verifyResponse!.message.toString());
  //       showToastError(verifyResponse!.message, FToast().init(context));
  //     }
  //     setState(() {
  //       isVerifying = false;
  //     });
  //   } else {
  //     showToastError('Please provide license pictures', FToast().init(context));
  //   }
  // }
}
