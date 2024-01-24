import 'package:deliver_partner/Constants/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ScooterOwnerDetailsWidget extends StatefulWidget {
  final String name;
  final String contactNumber;
  final String address;
  final String userTypeOfVehicleOwner;
  final String statusOfVehicleOwner;
  // final String scooterLicenseExpiryDate;
  // final String statusOfScooter;

  const ScooterOwnerDetailsWidget({
    super.key,
    required this.name,
    required this.contactNumber,
    required this.address,
    required this.userTypeOfVehicleOwner,
    required this.statusOfVehicleOwner,
  });

  @override
  State<ScooterOwnerDetailsWidget> createState() =>
      _ScooterOwnerDetailsWidgetState();
}

class _ScooterOwnerDetailsWidgetState extends State<ScooterOwnerDetailsWidget> {
  bool dropDown = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 12.w, right: 12.w, bottom: 12.h),
      margin: EdgeInsets.only(bottom: 20.h),
      width: double.infinity,
      height: dropDown ? 175.h : 50.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: lightWhite,
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                dropDown = !dropDown;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Vehicle Owner\'s Details',
                  style: GoogleFonts.syne(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: orange,
                  ),
                ),
                const Icon(
                  Icons.arrow_drop_down_rounded,
                  color: orange,
                  size: 35,
                ),
              ],
            ),
          ),
          Expanded(
            child: Visibility(
              visible: dropDown,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Vehicle Owner',
                        style: GoogleFonts.syne(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: black,
                        ),
                      ),
                      Text(
                        widget.userTypeOfVehicleOwner,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: black,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Name',
                        style: GoogleFonts.syne(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: black,
                        ),
                      ),
                      Text(
                        widget.name,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: black,
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   height: 10.h,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Contact Number',
                        style: GoogleFonts.syne(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: black,
                        ),
                      ),
                      Text(
                        widget.contactNumber,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: black,
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   height: 10.h,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Address',
                        style: GoogleFonts.syne(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: black,
                        ),
                      ),
                      Tooltip(
                        message: widget.address,
                        child: Container(
                          color: Colors.transparent,
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text(
                            widget.address,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: black,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Status',
                        style: GoogleFonts.syne(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: black,
                        ),
                      ),
                      Text(
                        widget.statusOfVehicleOwner,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: orange,
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   height: 10.h,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       'Scooter insurance date',
                  //       style: GoogleFonts.syne(
                  //         fontSize: 16,
                  //         fontWeight: FontWeight.w400,
                  //         color: black,
                  //       ),
                  //     ),
                  //     Text(
                  //       'abc xyz, Nigeria',
                  //       style: GoogleFonts.inter(
                  //         fontSize: 14,
                  //         fontWeight: FontWeight.w400,
                  //         color: black,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 10.h,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       'Insurance type ',
                  //       style: GoogleFonts.syne(
                  //         fontSize: 16,
                  //         fontWeight: FontWeight.w400,
                  //         color: black,
                  //       ),
                  //     ),
                  //     Text(
                  //       '12 May 202214',
                  //       style: GoogleFonts.inter(
                  //         fontSize: 14,
                  //         fontWeight: FontWeight.w400,
                  //         color: black,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 10.h,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       'Scooter license \n expires date ',
                  //       style: GoogleFonts.syne(
                  //         fontSize: 16,
                  //         fontWeight: FontWeight.w400,
                  //         color: black,
                  //       ),
                  //     ),
                  //     Text(
                  //       'abc xyz, Nigeria',
                  //       style: GoogleFonts.inter(
                  //         fontSize: 14,
                  //         fontWeight: FontWeight.w400,
                  //         color: black,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 10.h,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       'Status',
                  //       style: GoogleFonts.syne(
                  //         fontSize: 16,
                  //         fontWeight: FontWeight.w700,
                  //         color: black,
                  //       ),
                  //     ),
                  //     Text(
                  //       'Passed',
                  //       style: GoogleFonts.inter(
                  //         fontSize: 16,
                  //         fontWeight: FontWeight.w700,
                  //         color: orange,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
