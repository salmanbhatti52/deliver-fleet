import 'package:deliver_partner/Constants/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RiderBikeDetailsWidget extends StatefulWidget {
  final String model;
  final String color;
  final String chassisNumber;
  final String yearOfManufacture;
  final String bikeInsuranceDate;
  final String licenseExpiryDate;
  final String status;

  const RiderBikeDetailsWidget({
    super.key,
    required this.model,
    required this.color,
    required this.chassisNumber,
    required this.yearOfManufacture,
    required this.bikeInsuranceDate,
    required this.licenseExpiryDate,
    required this.status,
  });

  @override
  State<RiderBikeDetailsWidget> createState() => _RiderBikeDetailsWidgetState();
}

class _RiderBikeDetailsWidgetState extends State<RiderBikeDetailsWidget> {
  bool dropDown = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 12.w, right: 12.w, bottom: 12.h),
      width: double.infinity,
      height: dropDown ? 270.h : 57.h,
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
                  'Bike Details',
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
                        'Model',
                        style: GoogleFonts.syne(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: black,
                        ),
                      ),
                      Text(
                        widget.model,
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
                        'Color',
                        style: GoogleFonts.syne(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: black,
                        ),
                      ),
                      Text(
                        widget.color,
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
                        'Vin / Chassis Number',
                        style: GoogleFonts.syne(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: black,
                        ),
                      ),
                      Text(
                        widget.chassisNumber,
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
                        'Year of manufacture ',
                        style: GoogleFonts.syne(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: black,
                        ),
                      ),
                      Text(
                        widget.yearOfManufacture,
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
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       'Mileage',
                  //       style: GoogleFonts.syne(
                  //         fontSize: 16,
                  //         fontWeight: FontWeight.w400,
                  //         color: black,
                  //       ),
                  //     ),
                  //     Text(
                  //       'widget.mileage',
                  //       style: GoogleFonts.inter(
                  //         fontSize: 14,
                  //         fontWeight: FontWeight.w400,
                  //         color: black,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Bike Insurance Date',
                        style: GoogleFonts.syne(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: black,
                        ),
                      ),
                      Text(
                        widget.bikeInsuranceDate,
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
                        'Bike License Expiry Date',
                        style: GoogleFonts.syne(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: black,
                        ),
                      ),
                      Text(
                        widget.licenseExpiryDate,
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
                        'Status',
                        style: GoogleFonts.syne(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: black,
                        ),
                      ),
                      Text(
                        widget.status,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: orange,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
