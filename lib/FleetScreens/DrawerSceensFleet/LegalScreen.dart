// ignore_for_file: avoid_print

import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:deliver_partner/Constants/Colors.dart';
import 'package:deliver_partner/services/API_services.dart';
import 'package:deliver_partner/Constants/PageLoadingKits.dart';
import 'package:deliver_partner/models/API%20models/API%20response.dart';
import 'package:deliver_partner/Constants/back-arrow-with-container.dart';
import 'package:deliver_partner/models/API%20models/GetAllSystemDataModel.dart';

class LegalScreen extends StatefulWidget {
  const LegalScreen({super.key});

  @override
  State<LegalScreen> createState() => _LegalScreenState();
}

class _LegalScreenState extends State<LegalScreen> {
  bool isLoading = false;
  bool isExpanded = false;
  bool isExpanded2 = false;

  String? termsText;
  String? privacyText;

  ApiServices get service => GetIt.I<ApiServices>();

  late APIResponse<List<GetAllSystemDataModel>> _getAllSystemDataResponse;
  List<GetAllSystemDataModel>? _getSystemDataList;

  init() async {
    _getAllSystemDataResponse = await service.getALlSystemDataAPI();
    _getSystemDataList = [];

    if (_getAllSystemDataResponse.status!.toLowerCase() == 'success') {
      if (_getAllSystemDataResponse.data != null) {
        _getSystemDataList!.addAll(_getAllSystemDataResponse.data!);
        for (GetAllSystemDataModel model in _getSystemDataList!) {
          if (model.type == 'terms_text') {
            setState(() {
              termsText = model.description!;
            });
          } else if (model.type == 'privacy_text') {
            setState(() {
              privacyText = model.description!;
            });
          }
        }
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    init();
    setState(() {
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leadingWidth: 70,
        centerTitle: true,
        title: Text(
          'Legal',
          style: GoogleFonts.syne(
            fontWeight: FontWeight.w700,
            color: black,
            fontSize: 20,
          ),
        ),
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: isLoading
          ? Center(
              child: Container(
                width: 100,
                height: 100,
                color: Colors.transparent,
                child: spinKitRotatingCircle,
              ),
            )
          : _getAllSystemDataResponse.data != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: size.height * 0.02),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isExpanded = !isExpanded;
                              isExpanded2 = false;
                            });
                          },
                          child: Container(
                              width: size.width,
                              height: isExpanded
                                  ? size.height * 0.6
                                  : size.height * 0.06,
                              decoration: BoxDecoration(
                                color: white,
                                border: Border.all(
                                  color: grey.withOpacity(0.1),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: black.withOpacity(0.1),
                                    blurRadius: 5,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: isExpanded
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            SizedBox(
                                                height: size.height * 0.02),
                                            Text(
                                              "Terms & Conditions",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.syne(
                                                color: black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                                height: size.height * 0.02),
                                            Html(
                                              data: "$termsText",
                                              style: {
                                                "html": Style(
                                                  fontSize: FontSize(16),
                                                  color: black,
                                                  fontFamily: 'Syne-Regular',
                                                ),
                                              },
                                            ),
                                            SizedBox(
                                                height: size.height * 0.02),
                                            Icon(
                                              Icons.keyboard_arrow_up_rounded,
                                              color: black.withOpacity(0.5),
                                            ),
                                            SizedBox(
                                                height: size.height * 0.01),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Terms & Conditions",
                                            textAlign: TextAlign.left,
                                            style: GoogleFonts.syne(
                                              color: black,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const Spacer(),
                                          Icon(
                                            Icons.keyboard_arrow_right_rounded,
                                            color: black.withOpacity(0.5),
                                          ),
                                        ],
                                      ),
                                    )),
                        ),
                        SizedBox(height: size.height * 0.02),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isExpanded = false;
                              isExpanded2 = !isExpanded2;
                            });
                          },
                          child: Container(
                            width: size.width,
                            height: isExpanded2
                                ? size.height * 0.6
                                : size.height * 0.06,
                            decoration: BoxDecoration(
                              color: white,
                              border: Border.all(
                                color: grey.withOpacity(0.1),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: black.withOpacity(0.1),
                                  blurRadius: 5,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: isExpanded2
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          SizedBox(height: size.height * 0.02),
                                          Text(
                                            "Privacy Policy",
                                            style: GoogleFonts.syne(
                                              color: black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: size.height * 0.02),
                                          Html(
                                            data: "$privacyText",
                                            style: {
                                              "html": Style(
                                                fontSize: FontSize(16),
                                                color: black,
                                                fontFamily: 'Syne-Regular',
                                              ),
                                            },
                                          ),
                                          SizedBox(height: size.height * 0.02),
                                          Icon(
                                            Icons.keyboard_arrow_up_rounded,
                                            color: black.withOpacity(0.5),
                                          ),
                                          SizedBox(height: size.height * 0.01),
                                        ],
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Privacy Policy",
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.syne(
                                            color: black,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const Spacer(),
                                        Icon(
                                          Icons.keyboard_arrow_right_rounded,
                                          color: black.withOpacity(0.5),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Center(
                  child: Text(
                    "Data Not Fetched Completely\nPlease Try Again",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.syne(
                      color: grey,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
    );
  }
}
