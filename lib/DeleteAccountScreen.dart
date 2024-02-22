import 'package:deliver_partner/ChooseAppScreen.dart';
import 'package:deliver_partner/Constants/Colors.dart';
import 'package:deliver_partner/Constants/buttonConatinerWithBorder.dart';
import 'package:deliver_partner/Constants/buttonContainer.dart';
import 'package:deliver_partner/utilities/showToast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? firstName;
String? lastName;

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  sharedPrefs() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    firstName = sharedPref.getString('userFirstName');
    lastName = sharedPref.getString('userLastName');
    debugPrint('sharedPrefs firstName: $firstName');
    debugPrint('sharedPrefs lastName: $lastName');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    sharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leadingWidth: 70,
        centerTitle: true,
        title: Text(
          'Delete Account',
          style: GoogleFonts.syne(
            fontWeight: FontWeight.w700,
            color: black,
            fontSize: 20,
          ),
        ),
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 40.h,
              ),
              Text(
                'Hi there! $firstName $lastName',
                textAlign: TextAlign.center,
                style: GoogleFonts.syne(
                  fontWeight: FontWeight.w700,
                  color: orange,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 80.h,
              ),
              SvgPicture.asset(
                'assets/images/delete-account.svg',
                width: 300,
                height: 300,
              ),
              SizedBox(
                height: 120.h,
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => dialog(context),
                  );
                },
                child: buttonContainer(context, 'Delete Account'),
              ),
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: buttonContainerWithBorderBig(context, 'Go Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dialog(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return Future.value(false);
      },
      child: Dialog(
        backgroundColor: white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        insetPadding: const EdgeInsets.only(left: 20, right: 20),
        child: SizedBox(
          height: size.height * 0.35,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Are you sure you want to delete your account?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.syne(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: orange,
                  ),
                ),
                Text(
                  'If you delete your account then you will lose all your data.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.syne(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: grey,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: buttonContainerWithBorderSmall(context, 'No'),
                    ),
                    GestureDetector(
                      onTap: () async {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const ChooseAppScreen(),
                            ),
                            (route) => false);
                        showToastSuccess(
                            'Delete account request has been sent to admin your account will be deleted in 24 hour.',
                            FToast().init(context));
                        SharedPreferences sharedPref =
                            await SharedPreferences.getInstance();
                        await sharedPref.clear();
                        setState(() {});
                      },
                      child: buttonContainerSmall(context, 'Yes'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
