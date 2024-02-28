import 'dart:io';

import 'package:deliver_partner/LogInScreen.dart';
import 'package:deliver_partner/widgets/columnWithAllDetailsOfRider.dart';
import 'package:deliver_partner/widgets/picturesOfDricingLicense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Constants/Colors.dart';
import '../Constants/buttonContainer.dart';

class CongratulationsScreenDriving extends StatelessWidget {
  final Map licenseMap;
  final String userType;
  File? profileImage;
  final File licenseFrontImage;
  final File licenseBackImage;
  CongratulationsScreenDriving({
    super.key,
    required this.licenseMap,
    this.profileImage,
    required this.licenseFrontImage,
    required this.licenseBackImage,
    required this.userType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: orange,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  Text(
                    'Congratulations!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.syne(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: orange,
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    'Your driving license\n has been successfully verified',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.syne(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: grey,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    width: 120,
                    height: 120,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: profileImage == null
                          ? Image.asset('assets/images/place-holder.png')
                          : Image.file(
                              profileImage!,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  ColumnWithAllDetailsOfRiders(
                    address: licenseMap['address'],
                    cnic: licenseMap['national_identification_no'],
                    licenseNumber: licenseMap['driving_license_no'],
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Text(
                    'Driving License Images ',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.syne(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: black,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  picturesOfDricingLicense(
                    context,
                    licenseFrontImage,
                    licenseBackImage,
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.0.h),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => LogInScreen(
                            userType: 'Rider',
                          ),
                        ),
                      ),
                      child: buttonContainer(context, 'NEXT'),
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
}
