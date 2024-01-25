import 'package:deliver_partner/Constants/Colors.dart';
import 'package:deliver_partner/Constants/buttonConatinerWithBorder.dart';
import 'package:deliver_partner/Constants/buttonContainer.dart';
import 'package:deliver_partner/ErrorPage.dart';
import 'package:deliver_partner/FleetScreens/OnboardingFleetScreen.dart';
import 'package:deliver_partner/RiderScreens/OnboardingSCreen.dart';
import 'package:flutter/material.dart';
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
      body: Center(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Text(
              'Choose the role you want to continue with',
              textAlign: TextAlign.center,
              style: GoogleFonts.syne(
                fontWeight: FontWeight.w700,
                color: black,
                fontSize: MediaQuery.of(context).size.width * 0.04,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
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
                      child: buttonContainer1(context, 'SELECT FLEET MODE'),
                    )
                  : buttonContainerWithBorder(context, 'SELECT FLEET MODE'),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
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
                      child: buttonContainer1(context, 'SELECT RIDER MODE'),
                    )
                  : buttonContainerWithBorder(context, 'SELECT RIDER MODE'),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.02,
              ),
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
                            : const ErrorPage(),
                  ),
                ),
                child: buttonContainer1(context, 'Continue with $appMode'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
