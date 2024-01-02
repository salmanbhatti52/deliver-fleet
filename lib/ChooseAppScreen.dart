import 'package:deliver_partner/Constants/Colors.dart';
import 'package:deliver_partner/Constants/buttonConatinerWithBorder.dart';
import 'package:deliver_partner/Constants/buttonContainer.dart';
import 'package:deliver_partner/ErrorPage.dart';
import 'package:deliver_partner/FleetScreens/OnboardingFleetScreen.dart';
import 'package:deliver_partner/RiderScreens/OnboardingSCreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChooseAppScreen extends StatefulWidget {
  const ChooseAppScreen({super.key});

  @override
  State<ChooseAppScreen> createState() => _ChooseAppScreenState();
}

class _ChooseAppScreenState extends State<ChooseAppScreen> {
  int checkmarkFleet = -1;

  int isAppSelected = 1;

  @override
  Widget build(BuildContext context) {
    final appMode = checkmarkFleet == 1 ? 'Fleet' : 'Rider';
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0.0,
      //   backgroundColor: Colors.transparent,
      //   leadingWidth: 70,
      //   leading: Padding(
      //     padding: const EdgeInsets.only(top: 8.0, left: 20),
      //     child: GestureDetector(
      //       onTap: () => Navigator.of(context).pop(),
      //       child: backArrowWithContainer(context),
      //     ),
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 100.h,
              ),
              Text(
                'Choose the role you want to continue with',
                textAlign: TextAlign.center,
                style: GoogleFonts.syne(
                  fontWeight: FontWeight.w700,
                  color: black,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 80.h,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    checkmarkFleet = 1;
                  });
                },
                child: checkmarkFleet == 1
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            checkmarkFleet = -1;
                          });
                        },
                        child: buttonContainer(context, 'SELECT FLEET MODE'),
                      )
                    : buttonContainerWithBorder(context, 'SELECT FLEET MODE'),
              ),
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    checkmarkFleet = 2;
                  });
                },
                child: checkmarkFleet == 2
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            checkmarkFleet = -1;
                          });
                        },
                        child: buttonContainer(context, 'SELECT RIDER MODE'),
                      )
                    : buttonContainerWithBorder(context, 'SELECT RIDER MODE'),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => checkmarkFleet == 1
                          ? OnboardingFleetScreen(
                              fleet: appMode,
                            )
                          : checkmarkFleet == 2
                              ? OnboardingScreen(
                                  rider: appMode,
                                )
                              : ErrorPage(),
                    ),
                  ),
                  child: buttonContainer(context, 'Continue'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
