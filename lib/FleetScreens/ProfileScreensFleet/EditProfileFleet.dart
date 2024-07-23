import 'dart:convert';
import 'dart:io';

import 'package:deliver_partner/Constants/PageLoadingKits.dart';
import 'package:deliver_partner/Constants/buttonContainer.dart';
import 'package:deliver_partner/FleetScreens/BottomNavBarFleet.dart';
import 'package:deliver_partner/models/API_models/LogInModel.dart';
import 'package:deliver_partner/widgets/TextFormField_Widget.dart';
import 'package:deliver_partner/widgets/apiButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Constants/Colors.dart';
import '../../../Constants/back-arrow-with-container.dart';
import '../../../Constants/camera-icon.dart';
import '../../../models/API_models/API_response.dart';
import '../../../services/API_services.dart';
import '../../../utilities/showToast.dart';
import '../../../widgets/customDialogForImage.dart';

class EditProfileFleet extends StatefulWidget {
  const EditProfileFleet({
    super.key,
  });

  @override
  State<EditProfileFleet> createState() => _EditProfileFleetState();
}

class _EditProfileFleetState extends State<EditProfileFleet> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  ApiServices get service => GetIt.I<ApiServices>();

  int userID = -1;
  late SharedPreferences sharedPreferences;

  bool isPageLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      isPageLoading = true;
    });
    init();
  }

  late APIResponse<LogInModel>? getUserProfileResponse;

  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userID = (sharedPreferences.getInt('userID') ?? -1);
    Map data = {
      "users_fleet_id": userID.toString(),
    };

    getUserProfileResponse = await service.getUserProfileAPI(data);

    if (getUserProfileResponse!.status!.toLowerCase() == 'success') {
      if (getUserProfileResponse!.data != null) {
        showToastSuccess('Loading user data', FToast().init(context),
            seconds: 1);
      }
      firstNameController.text =
          getUserProfileResponse!.data!.first_name.toString();
      lastNameController.text =
          getUserProfileResponse!.data!.last_name.toString();
      addressController.text = getUserProfileResponse!.data!.address.toString();
      phoneNumberController.text =
          getUserProfileResponse!.data!.phone.toString();
    } else {
      showToastError(getUserProfileResponse!.message, FToast().init(context));
    }

    setState(() {
      isPageLoading = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    addressController.dispose();

    phoneNumberController.dispose();
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
          showToastError("You didn't Take Any Picture", FToast().init(context));
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
            xFileFront = imageFile1;
            imagePathFront = imageTemporary;
            base64imgFront = base64.encode(imageByte);
          });
        } else {
          showToastError("You didn't Take Any Picture", FToast().init(context));
        }
      } else if (selection == 2) {
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
          showToastError("You didn't Take Any Picture", FToast().init(context));
        }
      } else {
        showToastError("You didn't Take Any Picture", FToast().init(context));
      }
    } catch (e) {
      showToastError("CATCH $e", FToast().init(context));
    }
  }

  File? imagePath;
  String base64img = '';
  XFile? xFile;

  /// front image of license
  File? imagePathFront;
  String base64imgFront = '';
  XFile? xFileFront;

  /// back image of license
  File? imagePathForBack;
  String base64imgForBack = '';
  XFile? xFileForBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leadingWidth: 70,
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: GoogleFonts.syne(
            fontWeight: FontWeight.w700,
            color: black,
            fontSize: 20,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 20),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: backArrowWithContainer(context),
          ),
        ),
      ),
      body: isPageLoading
          ? spinKitRotatingCircle
          : GlowingOverscrollIndicator(
              axisDirection: AxisDirection.down,
              color: orange,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: 150.w,
                              height: 150.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: orange,
                                  width: 4.5,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: imagePath != null
                                    ? Image.file(
                                        imagePath!,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        'https://deliverbygfl.com/public/${getUserProfileResponse!.data!.profile_pic}',
                                        fit: BoxFit.cover,
                                        errorBuilder: (BuildContext context,
                                            Object exception,
                                            StackTrace? stackTrace) {
                                          return SizedBox(
                                            child: Image.asset(
                                              'assets/images/place-holder.png',
                                              fit: BoxFit.cover,
                                            ),
                                          );
                                        },
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return Center(
                                            child: CircularProgressIndicator(
                                              color: orange,
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                  : null,
                                            ),
                                          );
                                        },
                                      ),
                              ),
                            ),
                            Positioned(
                              right: -7,
                              bottom: -10,
                              child: GestureDetector(
                                onTap: () => showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CustomDialogBox(
                                          name: 'Profile Picture',
                                          onCameraBTNPressed: () {
                                            imageSelection(
                                                ImageSource.camera, 0);
                                          },
                                          onGalleryBTNPressed: () {
                                            imageSelection(
                                                ImageSource.gallery, 0);
                                          });
                                    }),
                                child: cameraIcon(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      Text(
                        'First Name',
                        style: GoogleFonts.syne(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: black),
                      ),
                      SizedBox(
                        height: 7.h,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextFormFieldWidget(
                            controller: firstNameController,
                            textInputType: TextInputType.name,
                            enterTextStyle: enterTextStyle,
                            cursorColor: orange,
                            hintText: getUserProfileResponse!.data!.first_name!,
                            border: border,
                            hintStyle: hintStyle,
                            focusedBorder: focusedBorder,
                            obscureText: null,
                            contentPadding: contentPadding,
                            enableBorder: enableBorder,
                            length: -1),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        'Last Name',
                        style: GoogleFonts.syne(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: black),
                      ),
                      SizedBox(
                        height: 7.h,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextFormFieldWidget(
                            controller: lastNameController,
                            textInputType: TextInputType.name,
                            enterTextStyle: enterTextStyle,
                            cursorColor: orange,
                            hintText: getUserProfileResponse!.data!.last_name!,
                            border: border,
                            hintStyle: hintStyle,
                            focusedBorder: focusedBorder,
                            obscureText: null,
                            contentPadding: contentPadding,
                            enableBorder: enableBorder,
                            length: -1),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        'Phone Number',
                        style: GoogleFonts.syne(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: black),
                      ),
                      SizedBox(
                        height: 7.h,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextFormFieldWidget(
                            controller: phoneNumberController,
                            textInputType: TextInputType.name,
                            enterTextStyle: enterTextStyle,
                            cursorColor: orange,
                            hintText: getUserProfileResponse!.data!.phone!,
                            border: border,
                            hintStyle: hintStyle,
                            focusedBorder: focusedBorder,
                            obscureText: null,
                            contentPadding: contentPadding,
                            enableBorder: enableBorder,
                            length: 15),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        'Address',
                        style: GoogleFonts.syne(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: black),
                      ),
                      SizedBox(
                        height: 7.h,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextFormFieldWidget(
                            controller: addressController,
                            textInputType: TextInputType.name,
                            enterTextStyle: enterTextStyle,
                            cursorColor: orange,
                            hintText: getUserProfileResponse!.data!.address!,
                            border: border,
                            hintStyle: hintStyle,
                            focusedBorder: focusedBorder,
                            obscureText: null,
                            contentPadding: contentPadding,
                            enableBorder: enableBorder,
                            length: -1),
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Center(
                          child: isUpdating
                              ? apiButton(context)
                              : GestureDetector(
                                  onTap: () => updateProfileMethod(context),
                                  child: buttonContainer(context, 'SAVE'),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  bool isUpdating = false;
  late APIResponse<LogInModel>? updateResponse;

  updateProfileMethod(BuildContext context) async {
    setState(() {
      isUpdating = true;
    });
    Map updateData = {
      "users_fleet_id": userID.toString(),
      "user_type": "Fleet",
      "first_name": firstNameController.text,
      "last_name": lastNameController.text,
      "phone": phoneNumberController.text,
      "address": addressController.text,
      "profile_pic": base64img,
    };

    updateResponse = await service.updateUserProfileApi(updateData);

    if (updateResponse!.status!.toLowerCase() == 'success') {
      showToastSuccess(
          'Profile is successfully updated', FToast().init(context));
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const BottomNavBarFleet(),
        ),
      );
    } else {
      showToastError('Something went wrong', FToast().init(context));
    }
    setState(() {
      isUpdating = false;
    });
  }
}
