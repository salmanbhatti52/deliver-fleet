import 'package:deliver_partner/Constants/Colors.dart';
import 'package:deliver_partner/Constants/buttonContainer.dart';
import 'package:deliver_partner/models/API%20models/API%20response.dart';
import 'package:deliver_partner/utilities/showToast.dart';
import 'package:deliver_partner/widgets/apiButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../services/API_services.dart';
import '../../widgets/TextFormField_Widget.dart';

class InviteRiders extends StatefulWidget {
  final String users_fleet_id;

  const InviteRiders({super.key, required this.users_fleet_id});

  @override
  State<InviteRiders> createState() => _InviteRidersState();
}

class _InviteRidersState extends State<InviteRiders> {
  ApiServices get service => GetIt.I<ApiServices>();

  late TextEditingController emailController;
  final GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Dialog(
      backgroundColor: white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      insetPadding: const EdgeInsets.only(left: 20, right: 20),
      child: SizedBox(
        height: size.height * 0.45,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            children: [
              Positioned(
                top: 15,
                right: -10,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset(
                    "assets/images/close-circle.svg",
                  ),
                ),
              ),
              Form(
                key: _key,
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.08),
                    Text(
                      'Invite Riders Now',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.syne(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: orange,
                      ),
                    ),
                    SizedBox(height: size.height * 0.04),
                    Text(
                      'Invite Riders by entering their email address here',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.syne(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: grey,
                      ),
                    ),
                    SizedBox(height: size.height * 0.04),
                    SizedBox(
                      width: 296.w,
                      child: TextFormFieldWidget(
                        autofillHints: AutofillHints.email,
                        controller: emailController,
                        textInputType: TextInputType.emailAddress,
                        enterTextStyle: enterTextStyle,
                        cursorColor: orange,
                        hintText: 'Email ID',
                        border: border,
                        hintStyle: hintStyle,
                        focusedBorder: focusedBorder,
                        obscureText: null,
                        contentPadding: contentPadding,
                        enableBorder: enableBorder,
                        prefixIcon: null,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'email cannot be empty';
                          }
                          return null;
                        },
                        length: -1,
                      ),
                    ),
                    SizedBox(height: size.height * 0.04),
                    isInviting
                        ? apiButton(context)
                        : GestureDetector(
                            onTap: () => inviteRiders(context),
                            child: buttonContainer(context, 'INVITE'),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    //   AlertDialog.adaptive(
    //   backgroundColor: white,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(20),
    //   ),
    //   icon: Align(
    //     alignment: Alignment.topRight,
    //     child: GestureDetector(
    //       onTap: () => Navigator.of(context).pop(),
    //       child: SvgPicture.asset('assets/images/close-circle.svg'),
    //     ),
    //   ),
    //   title: Text(
    //     'Invite Riders Now',
    //     style: GoogleFonts.syne(
    //       fontSize: 20,
    //       fontWeight: FontWeight.w700,
    //       color: orange,
    //     ),
    //   ),
    //   iconPadding: EdgeInsets.zero,
    //   actionsAlignment: MainAxisAlignment.center,
    //   content: SizedBox(
    //     // color: Colors.red,
    //     height: 160.h,
    //     width: double.infinity,
    //     child: Form(
    //       key: _key,
    //       child: Column(
    //         children: [
    //           Text(
    //             'Invite Riders by entering their Email\n Address here',
    //             textAlign: TextAlign.center,
    //             style: GoogleFonts.syne(
    //               fontSize: 16,
    //               fontWeight: FontWeight.w400,
    //               color: grey,
    //             ),
    //           ),
    //           SizedBox(
    //             height: 55.h,
    //           ),
    //           SizedBox(
    //             width: 296.w,
    //             child: TextFormFieldWidget(
    //               autofillHints: AutofillHints.email,
    //               controller: emailController,
    //               textInputType: TextInputType.emailAddress,
    //               enterTextStyle: enterTextStyle,
    //               cursorColor: orange,
    //               hintText: 'Email ID',
    //               border: border,
    //               hintStyle: hintStyle,
    //               focusedBorder: focusedBorder,
    //               obscureText: null,
    //               contentPadding: contentPadding,
    //               enableBorder: enableBorder,
    //               prefixIcon: null,
    //               validator: (val) {
    //                 if (val!.isEmpty) {
    //                   return 'email cannot be empty';
    //                 }
    //                 return null;
    //               },
    //               length: -1,
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    //   actions: [
    //     isInviting
    //         ? apiButton(context)
    //         : GestureDetector(
    //             onTap: () => inviteRiders(context),
    //             child: buttonContainer(context, 'INVITE'),
    //           ),
    //   ],
    // );
  }

  bool isInviting = false;
  APIResponse<APIResponse>? _inviteResponse;

  inviteRiders(BuildContext context) async {
    if (_key.currentState!.validate()) {
      setState(() {
        isInviting = true;
      });

      Map inviteData = {
        "users_fleet_id": widget.users_fleet_id,
        "email": emailController.text,
      };
      _inviteResponse = await service.inviteRidersAPI(inviteData);
      if (_inviteResponse!.status!.toLowerCase() == 'success') {
        showToastSuccess(_inviteResponse!.message!, FToast().init(context),
            seconds: 1);
      } else {
        showToastError(_inviteResponse!.message!, FToast().init(context),
            seconds: 1);
      }
    }
    setState(() {
      isInviting = false;
    });
  }
}
