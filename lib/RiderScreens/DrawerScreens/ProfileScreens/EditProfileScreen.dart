import 'dart:convert';
import 'dart:io';

import 'package:deliver_partner/Constants/PageLoadingKits.dart';
import 'package:deliver_partner/models/API_models/LogInModel.dart';
import 'package:deliver_partner/models/APIModelsFleet/StartSupportChatModel.dart';
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
import '../../../Constants/buttonContainer.dart';
import '../../../Constants/camera-icon.dart';
import '../../../models/API_models/API_response.dart';
import '../../../models/API_models/SupportedUserModel.dart';
import '../../../services/API_services.dart';
import '../../../utilities/showToast.dart';
import '../../../widgets/customDialogForImage.dart';
import 'package:http/http.dart' as http;

class EditProfileScreen extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String address;
  final String image;
  final String frontImage;
  final String backImage;
  const EditProfileScreen(
      {super.key,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber,
      required this.address,
      required this.image,
      required this.frontImage,
      required this.backImage});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController phoneNumberController;
  late TextEditingController addressController;

  bool saveInfo = false;

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

  APIResponse<List<SupportedUserModel>>? getAdminResponse;
  List<SupportedUserModel>? getAdminList;

  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userID = (sharedPreferences.getInt('userID') ?? -1);

    getAdminResponse = await service.getAllAdminsAPI();
    getAdminList = [];

    if (getAdminResponse!.status!.toLowerCase() == 'success') {
      getAdminList!.addAll(getAdminResponse!.data!);
      print('object getting all adimns:    ${getAdminResponse!.data}');
    } else {}

    saveInfo = false;
    firstNameController = TextEditingController();
    addressController = TextEditingController();
    lastNameController = TextEditingController();
    phoneNumberController = TextEditingController();

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
                                        'https://deliver.eigix.net/public/${widget.image}',
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
                            hintText: widget.firstName,
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
                            hintText: widget.lastName,
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
                            hintText: widget.phoneNumber,
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
                            hintText: widget.address,
                            border: border,
                            hintStyle: hintStyle,
                            focusedBorder: focusedBorder,
                            obscureText: null,
                            contentPadding: contentPadding,
                            enableBorder: enableBorder,
                            length: -1),
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      Text(
                        'Driving License',
                        style: GoogleFonts.syne(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: black,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20.0.h),
                        child: SizedBox(
                          height: 150.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () => showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return CustomDialogBox(
                                                name: 'Front',
                                                onCameraBTNPressed: () {
                                                  imageSelection(
                                                      ImageSource.camera, 1);
                                                },
                                                onGalleryBTNPressed: () {
                                                  imageSelection(
                                                      ImageSource.gallery, 1);
                                                });
                                          }),
                                      child: Container(
                                        width: 170.w,
                                        height: 110.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: imagePathFront != null
                                                ? Image.file(
                                                    imagePathFront!,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image.network(
                                                    'https://deliver.eigix.net/public/${widget.frontImage}',
                                                    fit: BoxFit.cover,
                                                    errorBuilder:
                                                        (BuildContext context,
                                                            Object exception,
                                                            StackTrace?
                                                                stackTrace) {
                                                      return SizedBox(
                                                        child: Image.asset(
                                                            'assets/images/place-holder.png'),
                                                      );
                                                    },
                                                    loadingBuilder: (BuildContext
                                                            context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                      if (loadingProgress ==
                                                          null) {
                                                        return child;
                                                      }
                                                      return Center(
                                                        child:
                                                            CircularProgressIndicator(
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
                                                  )),
                                      ),
                                    ),
                                    Text(
                                      'Front',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.syne(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: orange,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 7.w,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () => showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return CustomDialogBox(
                                                name: 'Back',
                                                onCameraBTNPressed: () {
                                                  imageSelection(
                                                      ImageSource.camera, 2);
                                                },
                                                onGalleryBTNPressed: () {
                                                  imageSelection(
                                                      ImageSource.gallery, 2);
                                                });
                                          }),
                                      child: Container(
                                        width: 170.w,
                                        height: 110.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: imagePathForBack != null
                                                ? Image.file(
                                                    imagePathForBack!,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image.network(
                                                    'https://deliver.eigix.net/public/${widget.backImage}',
                                                    fit: BoxFit.cover,
                                                    errorBuilder:
                                                        (BuildContext context,
                                                            Object exception,
                                                            StackTrace?
                                                                stackTrace) {
                                                      return SizedBox(
                                                        child: Image.asset(
                                                            'assets/images/place-holder.png'),
                                                      );
                                                    },
                                                    loadingBuilder: (BuildContext
                                                            context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                      if (loadingProgress ==
                                                          null) {
                                                        return child;
                                                      }
                                                      return Center(
                                                        child:
                                                            CircularProgressIndicator(
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
                                                  )),
                                      ),
                                    ),
                                    Text(
                                      'Back',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.syne(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: orange,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Visibility(
                      //   visible: saveInfo,
                      //   child: Column(
                      //     children: [
                      //       Text(
                      //         '* You can not directly update your profile info. If you \n want to update details, contact support now.',
                      //         textAlign: TextAlign.center,
                      //         style: GoogleFonts.inter(
                      //           fontSize: 14,
                      //           fontWeight: FontWeight.w400,
                      //           color: black,
                      //         ),
                      //       ),
                      //       SizedBox(
                      //         height: 30.h,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 20.0.h),
                          child: isUpdating
                              ? apiButton(context)
                              : GestureDetector(
                                  onTap: () {
                                    updateProfileMethod(context);
                                  },
                                  child: buttonContainer(context,
                                      saveInfo ? 'CONTACT SUPPORT' : 'SAVE'),
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
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      isUpdating = true;
    });
    Map updateData = {
      "users_customers_id": userID.toString(),
      "users_customers_type": "Rider",
      "first_name": firstNameController.text,
      "last_name": lastNameController.text,
      "phone": phoneNumberController.text,
      "address": addressController.text,
      "profile_pic": base64img,
      "license_front_image": base64imgFront,
      "license_back_image": base64imgForBack,
    };

    updateResponse = await service.updateUserProfileApi(updateData);

    if (updateResponse!.status!.toLowerCase() == 'error') {
      showToastError(
          '* You can not directly update your profile info. If you \n want to update details, contact support now.',
          FToast().init(context),
          seconds: 7);
      saveInfo
          ? startSupportChat()
          : setState(() {
              saveInfo = true;
              // print("updateResponse ${updateResponse!.data!.profile_pic}");
            });
    } else if (updateResponse!.status!.toLowerCase() == 'success') {
      if (updateResponse!.data != null) {
        await sharedPreferences.setString(
            'userProfilePic', updateResponse!.data!.profile_pic!);
      }
    }

    setState(() {
      isUpdating = false;
    });
  }

  StartSupportChatModel startSupportChatModel = StartSupportChatModel();

  startSupportChat() async {
    try {
      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      userID = sharedPref.getInt('userID') ?? -1;
      String apiUrl = "https://deliver.eigix.net/api/user_chat_live";
      print("apiUrlStartChat: $apiUrl");
      print("userID: $userID");
      print("OtherUserId: ${getAdminList![0].users_system_id.toString()}");
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Accept': 'application/json',
        },
        body: {
          "request_type": " startChat",
          "users_type": "Rider",
          "other_users_type": "Admin",
          "users_id": userID.toString(),
          "other_users_id": getAdminList![0].users_system_id.toString(),
        },
      );
      final responseString = jsonDecode(response.body);
      print("response: $responseString");
      print("status: ${responseString['status']}");
    } catch (e) {
      print('Something went wrong = ${e.toString()}');
      return null;
    }
  }

  // late APIResponse<APIResponse> startChatResponse;
  //
  // startChat(BuildContext context) async {
  //   Map startChatData = {
  //     "request_type": " startChat",
  //     "users_type": "Rider",
  //     "other_users_type": "Admin",
  //     "users_id": userID.toString(),
  //     "other_users_id": getAdminList![0].users_system_id.toString(),
  //   };
  //   startChatResponse = await service.startChatAPI(startChatData);
  //   print('object chat started data:       ' + startChatData.toString());
  //
  //   if (startChatResponse.status!.toLowerCase() == 'success') {
  //     showToastSuccess('Start contact support chat', FToast().init(context));
  //     Navigator.of(context, rootNavigator: true).push(
  //       MaterialPageRoute(
  //         builder: (context) => SupportScreen(
  //           adminPicture: getAdminList![0].user_image!,
  //           adminName: getAdminList![0].first_name!,
  //           adminAddress: getAdminList![0].address!,
  //           adminID: getAdminList![0].users_system_id.toString(),
  //           userID: userID.toString(),
  //         ),
  //       ),
  //     );
  //   } else {
  //     Navigator.of(context, rootNavigator: true).push(
  //       MaterialPageRoute(
  //         builder: (context) => ContactSupport(
  //           adminPicture: getAdminList![0].user_image!,
  //           adminName: getAdminList![0].first_name!,
  //           adminAddress: getAdminList![0].address!,
  //           adminID: getAdminList![0].users_system_id.toString(),
  //           userID: userID.toString(),
  //         ),
  //       ),
  //     );
  //   }
  // }
}
