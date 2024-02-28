import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:deliver_partner/Constants/PageLoadingKits.dart';
import 'package:deliver_partner/widgets/TextFormField_Widget.dart';
import 'package:deliver_partner/widgets/customDialogForImage.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Constants/Colors.dart';
import '../../../Constants/back-arrow-with-container.dart';
import '../../../Constants/buttonContainer.dart';
import '../../../Constants/camera-icon.dart';
import '../../../models/API models/API response.dart';
import '../../../models/API models/GetAllVehicalsModel.dart';
import '../../../services/API_services.dart';
import '../../../utilities/showToast.dart';
import 'AddVehicleFleetSecondScreen.dart';

class AddVehicleFleetFirstScreen extends StatefulWidget {
  final String userType;

  const AddVehicleFleetFirstScreen({
    super.key,
    required this.userType,
  });

  @override
  State<AddVehicleFleetFirstScreen> createState() =>
      _AddVehicleFleetFirstScreenState();
}

class _AddVehicleFleetFirstScreenState
    extends State<AddVehicleFleetFirstScreen> {
  late TextEditingController modelController;
  late TextEditingController colorController;
  late TextEditingController registrationController;
  late TextEditingController chassisNumberController;
  late TextEditingController bikeCategoryController;
  final GlobalKey<FormState> _key = GlobalKey();

  // final List<String> items = [
  //   'Item1',
  //   'Item2',
  //   'Item3',
  //   'Item4',
  //   'Item5',
  //   'Item6',
  //   'Item7',
  //   'Item8',
  // ];
  String? selectedValue;
  int userID = -1;

  late SharedPreferences sharedPreferences;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isLoading = true;
      // gettingCategory = true;
    });
    init();
  }

  ApiServices get service => GetIt.I<ApiServices>();

  late APIResponse<List<GetAllVehicalsModel>> _getAllVehicalsResponse;
  List<GetAllVehicalsModel>? _getAllVehicalsList;

  // bool gettingCategory = false;

  int bikeCategoryID = -1;

  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userID = (sharedPreferences.getInt('userID') ?? -1);

    _getAllVehicalsResponse = await service.getBikeCategoryAPI();

    _getAllVehicalsList = [];
    if (_getAllVehicalsResponse.status!.toLowerCase() == 'success') {
      if (_getAllVehicalsResponse.data != null) {
        _getAllVehicalsList!.addAll(_getAllVehicalsResponse.data!);
      }
    } else {
      showToastError('something went wrong!', FToast().init(context));
    }

    modelController = TextEditingController();
    colorController = TextEditingController();
    registrationController = TextEditingController();
    chassisNumberController = TextEditingController();
    bikeCategoryController = TextEditingController();

    selectedValue = _getAllVehicalsList![0].name!;
    bikeCategoryID = _getAllVehicalsList![0].vehicles_id!;

    setState(() {
      isLoading = false;
      // gettingCategory = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    modelController.dispose();
    registrationController.dispose();
    chassisNumberController.dispose();
    colorController.dispose();
    bikeCategoryController.dispose();
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
        XFile? imageFile = await ImagePicker().pickImage(
            source: imageSource,
            imageQuality: 30,
            preferredCameraDevice: CameraDevice.rear,
            maxHeight: 800,
            maxWidth: 1000);
        if (imageFile != null) {
          Uint8List imageByte = await imageFile.readAsBytes();
          final imageTemporary = File(imageFile.path);
          setState(() {
            xFile = imageFile;
            imagePath = imageTemporary;
            base64img = base64.encode(imageByte);
          });
        } else {
          showToastError("You didn't Take Any Picture", FToast().init(context));
        }
      } else {
        showToastError("Select Image to proceed", FToast().init(context));
      }
    } catch (e) {
      showToastError("Couldn't select image $e", FToast().init(context));
    }
  }

  File? imagePath;
  String base64img = '';
  XFile? xFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leadingWidth: 70,
        leading: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 20),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: backArrowWithContainer(context),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Add Vehicle',
          style: GoogleFonts.syne(
            fontWeight: FontWeight.w700,
            color: black,
            fontSize: 20,
          ),
        ),
      ),
      body: isLoading
          ? spinKitRotatingCircle
          : LayoutBuilder(
              builder: (context, constraints) => GlowingOverscrollIndicator(
                axisDirection: AxisDirection.down,
                color: orange,
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: MediaQuery.sizeOf(context).height,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SvgPicture.asset('assets/images/big-circle.svg'),
                            Align(
                              alignment: Alignment.topRight,
                              child: SvgPicture.asset(
                                  'assets/images/small-circle.svg'),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.0.w),
                        child: Form(
                          key: _key,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                'Enter Ride Details as Fleet Manager.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.syne(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: black,
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              SvgPicture.asset(
                                'assets/images/logo.svg',
                                fit: BoxFit.scaleDown,
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Stack(
                                alignment: Alignment.bottomRight,
                                clipBehavior: Clip.none,
                                children: [
                                  imagePath != null
                                      ? Container(
                                          width: double.infinity,
                                          height: 150.h,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: lightGrey,
                                              width: 4.5,
                                            ),
                                            image: DecorationImage(
                                              image: FileImage(imagePath!),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          // child: ClipRRect(
                                          //   borderRadius: BorderRadius.circular(10),
                                          //   child: SvgPicture.asset(
                                          //     'assets/images/sample.jpg',
                                          //     fit: BoxFit.cover,
                                          //   ),
                                          // ),
                                        )
                                      : Container(
                                          width: double.infinity,
                                          height: 150.h,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: lightGrey,
                                              width: 4.5,
                                            ),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: SvgPicture.asset(
                                              'assets/images/bike.svg',
                                              fit: BoxFit.scaleDown,
                                            ),
                                          ),
                                        ),
                                  Positioned(
                                    right: -7,
                                    bottom: -10,
                                    child: GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return CustomDialogBox(
                                                  name: '',
                                                  onCameraBTNPressed: () {
                                                    imageSelection(
                                                        ImageSource.camera, 0);
                                                  },
                                                  onGalleryBTNPressed: () {
                                                    imageSelection(
                                                        ImageSource.gallery, 0);
                                                  });
                                            });
                                      },
                                      child: cameraIcon(context),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              SizedBox(
                                width: 296.w,
                                child: TextFormFieldWidget(
                                  controller: modelController,
                                  textInputType: TextInputType.text,
                                  enterTextStyle: enterTextStyle,
                                  cursorColor: orange,
                                  hintText: 'Model',
                                  border: border,
                                  hintStyle: hintStyle,
                                  focusedBorder: focusedBorder,
                                  obscureText: null,
                                  contentPadding: contentPadding,
                                  enableBorder: enableBorder,
                                  prefixIcon: null,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'model cannot be empty';
                                    }
                                    return null;
                                  },
                                  length: -1,
                                ),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              SizedBox(
                                width: 296.w,
                                child: TextFormFieldWidget(
                                  controller: colorController,
                                  textInputType: TextInputType.text,
                                  enterTextStyle: enterTextStyle,
                                  cursorColor: orange,
                                  hintText: 'Color',
                                  border: border,
                                  hintStyle: hintStyle,
                                  focusedBorder: focusedBorder,
                                  obscureText: null,
                                  contentPadding: contentPadding,
                                  enableBorder: enableBorder,
                                  prefixIcon: null,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'color cannot be empty';
                                    }
                                    return null;
                                  },
                                  length: -1,
                                ),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              SizedBox(
                                width: 296.w,
                                child: TextFormFieldWidget(
                                  controller: registrationController,
                                  textInputType: TextInputType.text,
                                  enterTextStyle: enterTextStyle,
                                  cursorColor: orange,
                                  hintText: 'Registration',
                                  border: border,
                                  hintStyle: hintStyle,
                                  focusedBorder: focusedBorder,
                                  obscureText: null,
                                  contentPadding: contentPadding,
                                  enableBorder: enableBorder,
                                  prefixIcon: null,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'registration cannot be empty';
                                    }
                                    return null;
                                  },
                                  length: -1,
                                ),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              SizedBox(
                                width: 296.w,
                                child: TextFormFieldWidget(
                                  controller: chassisNumberController,
                                  textInputType: TextInputType.text,
                                  enterTextStyle: enterTextStyle,
                                  cursorColor: orange,
                                  hintText: 'Vin/Chassis Number',
                                  border: border,
                                  hintStyle: hintStyle,
                                  focusedBorder: focusedBorder,
                                  obscureText: null,
                                  contentPadding: contentPadding,
                                  enableBorder: enableBorder,
                                  prefixIcon: null,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'chassis number cannot be empty';
                                    }
                                    return null;
                                  },
                                  length: -1,
                                ),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: mildGrey,
                                ),
                                height: 50.h,
                                width: 300.w,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    isExpanded: true,
                                    hint: Text(
                                      'Bike Category',
                                      style: GoogleFonts.inter(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w300,
                                        color: black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    items: _getAllVehicalsList!
                                        .map((GetAllVehicalsModel item) =>
                                            DropdownMenuItem<String>(
                                              value: item.name,
                                              child: Text(
                                                item.name!,
                                                style: GoogleFonts.inter(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w300,
                                                  color: black,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ))
                                        .toList(),
                                    value: selectedValue,
                                    onChanged: (val) {
                                      setState(() {
                                        selectedValue = val.toString();
                                        bikeCategoryID = _getAllVehicalsList!
                                            .firstWhere((element) =>
                                                element.name == selectedValue)
                                            .vehicles_id!;
                                      });
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 17.w),
                                      // decoration: BoxDecoration(
                                      //   borderRadius: BorderRadius.circular(14),
                                      //   border: Border.all(
                                      //     color: lightGrey,
                                      //   ),
                                      //   color: lightGrey,
                                      // ),
                                    ),
                                    // iconStyleData: const IconStyleData(
                                    //   icon: Icon(
                                    //     Icons.arrow_forward_ios_outlined,
                                    //   ),
                                    //   iconSize: 14,
                                    //   iconEnabledColor: Colors.yellow,
                                    //   iconDisabledColor: Colors.grey,
                                    // ),
                                    dropdownStyleData: DropdownStyleData(
                                      maxHeight: 200,
                                      width: 300.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color: lightGrey,
                                      ),
                                      // offset: const Offset(-20, 0),
                                      // scrollbarTheme: ScrollbarThemeData(
                                      //   radius: const Radius.circular(40),
                                      //   thickness: MaterialStateProperty.all(6),
                                      //   thumbVisibility: MaterialStateProperty.all(true),
                                      // ),
                                    ),
                                    // menuItemStyleData: const MenuItemStyleData(
                                    //   height: 40,
                                    //   padding: EdgeInsets.only(left: 14, right: 14),
                                    // ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              GestureDetector(
                                onTap: () {
                                  addBike(context);
                                },
                                child: buttonContainer(context, 'NEXT'),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                            ],
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

  addBike(BuildContext context) {
    if (_key.currentState!.validate()) {
      if (bikeCategoryID == -1) {
        showToastError('Failed to get category id', FToast().init(context));
      } else if (imagePath == null) {
        showToastError('Please select image of the bike to proceed',
            FToast().init(context));
      } else {
        Map addBikeData = {
          "users_fleet_id": userID.toString(),
          "vehicles_id": bikeCategoryID.toString(),
          "model": modelController.text,
          "color": colorController.text,
          "vehicle_registration_no": registrationController.text,
          "vehicle_identification_no": chassisNumberController.text,
          "image": base64img,
        };
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AddVehicleFleetSecondScreen(
              addBikeData: addBikeData,
              userType: widget.userType,
            ),
          ),
        );
      }
    }
  }
}
