import 'dart:convert';
import 'dart:io';
import 'package:deliver_partner/widgets/TextFormField_Widget.dart';
import 'package:deliver_partner/widgets/customDialogForImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Constants/Colors.dart';
import '../Constants/back-arrow-with-container.dart';
import '../Constants/buttonContainer.dart';
import 'package:google_maps_webservice_ex/places.dart';
import '../Constants/camera-icon.dart';
import '../utilities/showToast.dart';
import 'DrivingLicensePictureVerification.dart';

class VerifyDrivingLicenseManually extends StatefulWidget {
  final String? email;
  final String userType;
  final String? deviceID;
  const VerifyDrivingLicenseManually(
      {super.key, required this.email, required this.userType, this.deviceID});

  @override
  State<VerifyDrivingLicenseManually> createState() =>
      _VerifyDrivingLicenseManuallyState();
}

class _VerifyDrivingLicenseManuallyState
    extends State<VerifyDrivingLicenseManually> {
  TextEditingController licenseController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  // late TextEditingController CNICController;

  final GlobalKey<FormState> _key = GlobalKey();
  sharedPrefs() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    fleetId = sharedPref.getInt('userID');
    parentId = sharedPref.getString('userEmail');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sharedPrefs();
    print(widget.email);
    // CNICController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    addressController.dispose();
    // CNICController.dispose();
    licenseController.dispose();
  }

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
          showToastError("You didn't take any picture", FToast().init(context));
        }
      } else {
        showToastError("Select image to proceed", FToast().init(context));
      }
    } catch (e) {
      showToastError("Couldn't select image $e", FToast().init(context));
    }
  }

  File? imagePath;
  String base64img = '';
  XFile? xFile;
  // Future pickCoverImage() async {
  //   print("abc");
  //   try {
  //     final ImagePicker picker = ImagePicker();
  //     xFile = await picker.pickImage(source: ImageSource.gallery);
  //     if (xFile == null) return;
  //
  //     Uint8List imageByte = await xFile!.readAsBytes();
  //
  //     final imageTemporary = File(xFile!.path);
  //
  //     setState(() {
  //       imagePath = imageTemporary;
  //       base64img = base64.encode(imageByte);
  //       print("base64img $base64img");
  //       print("newImage $imagePath");
  //     });
  //   } on PlatformException catch (e) {
  //     print('Failed to pick image: ${e.toString()}');
  //   }
  // }

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
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        // leadingWidth: 70,
        // leading: Padding(
        //   padding: const EdgeInsets.only(top: 8.0, left: 20),
        //   child: GestureDetector(
        //     onTap: () => Navigator.of(context).pop(),
        //     child: backArrowWithContainer(context),
        //   ),
        // ),
      ),
      body: WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: LayoutBuilder(
          builder: (context, constraints) => GlowingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            color: orange,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.minHeight),
                child: Padding(
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
                          'Rider Onboarding',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.syne(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: black,
                          ),
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        Stack(
                          alignment: Alignment.bottomRight,
                          clipBehavior: Clip.none,
                          children: [
                            imagePath != null
                                ? Container(
                                    width: 150.w,
                                    height: 150.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
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
                                    width: 150.w,
                                    height: 150.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: lightGrey,
                                        width: 4.5,
                                      ),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                            'assets/images/place-holder.png'),
                                        fit: BoxFit.cover,
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
                        Stack(
                          children: [
                            SizedBox(
                              width: 300.w,
                              child: TextFormFieldWidget(
                                controller: addressController,
                                textInputType: TextInputType.text,
                                enterTextStyle: enterTextStyle,
                                cursorColor: orange,
                                hintText: 'Address',
                                border: border,
                                hintStyle: hintStyle,
                                focusedBorder: focusedBorder,
                                obscureText: null,
                                contentPadding: contentPadding,
                                enableBorder: enableBorder,
                                onChanged: (value) {
                                  searchAddressPlaces(value!);
                                  return null;
                                },
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'make sure you\'ve entered the same address';
                                  }
                                  return null;
                                },
                                length: -1,
                              ),
                            ),
                            if (addressPredictions.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 40),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  child: ListView.separated(
                                    itemCount: addressPredictions.length,
                                    itemBuilder: (context, index) {
                                      final prediction =
                                          addressPredictions[index];
                                      return ListTile(
                                        title: Text(prediction.name),
                                        subtitle: Text(
                                            prediction.formattedAddress ?? ''),
                                        onTap: () {
                                          addressController.text =
                                              prediction.formattedAddress!;
                                          final double lat =
                                              prediction.geometry!.location.lat;
                                          final double lng =
                                              prediction.geometry!.location.lng;
                                          const double zoomLevel = 15.0;
                                          onAddressLocationSelected(
                                              LatLng(lat, lng), zoomLevel);
                                          addressLat = lat.toString();
                                          addressLng = lng.toString();
                                          setState(() {
                                            addressPredictions.clear();
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                            print("pickupLat: $addressLat");
                                            print("pickupLng $addressLng");
                                            print(
                                                "pickupLocation: ${prediction.formattedAddress}");
                                          });
                                          // Move the map camera to the selected location
                                          mapController?.animateCamera(
                                              CameraUpdate.newLatLng(
                                                  selectedLocation!));
                                        },
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return const Divider(
                                        color: Colors.black,
                                      );
                                    },
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        // SizedBox(
                        //   width: 300.w,
                        //   child: TextFormFieldWidget(
                        //     controller: CNICController,
                        //     textInputType: TextInputType.number,
                        //     enterTextStyle: enterTextStyle,
                        //     cursorColor: orange,
                        //     hintText: 'National identification number',
                        //     border: border,
                        //     hintStyle: hintStyle,
                        //     focusedBorder: focusedBorder,
                        //     obscureText: null,
                        //     contentPadding: contentPadding,
                        //     enableBorder: enableBorder,
                        //     validator: (val) {
                        //       if (val!.isEmpty) {
                        //         return 'make sure you\'ve entered the same NIN';
                        //       }
                        //       return null;
                        //     },
                        //     length: 11,
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 30.h,
                        // ),
                        SizedBox(
                          width: 300.w,
                          child: TextFormFieldWidget(
                            controller: licenseController,
                            textInputType: TextInputType.number,
                            enterTextStyle: enterTextStyle,
                            cursorColor: orange,
                            hintText: 'Driving license number',
                            border: border,
                            hintStyle: hintStyle,
                            focusedBorder: focusedBorder,
                            obscureText: null,
                            contentPadding: contentPadding,
                            enableBorder: enableBorder,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'make sure you\'ve entered the same number';
                              }
                              return null;
                            },
                            length: -1,
                          ),
                        ),
                        SizedBox(
                          height: 120.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20.0.h),
                          child: GestureDetector(
                            onTap: () => licenseVerify(context),
                            child: buttonContainer(context, 'NEXT'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email1');
  }

  licenseVerify(BuildContext context) async {
    String? email = await getEmail();
    print("email: $email ");
    sharedPrefs() async {
      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      fleetId = sharedPref.getInt('userID');
      parentId = sharedPref.getString('userEmail');
    }

    await sharedPrefs();

    print(parentId.toString());
    print(addressController.text);
    print(licenseController.text);

    if (_key.currentState!.validate()) {
      if (imagePath == null) {
        showToastError(
            'Please select image to proceed', FToast().init(context));
      } else {
        print("widget.email: ${widget.email}");
        Map licenseMap = {
          "email": email ?? widget.email,
          "address": addressController.text,
          // "national_identification_no": CNICController.text,
          "driving_license_no": licenseController.text,
          "profile_pic": base64img,
        };
        print("$licenseMap");
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DrivingLicensePictureVerification(
              licenseMap: licenseMap,
              profileImage: imagePath != null ? imagePath! : null,
              userType: widget.userType,
              deviceID: widget.deviceID,
            ),
          ),
        );
      }
    } else {
      showToastError(
          'Provide mandatory fields to proceed', FToast().init(context));
    }
  }

  final places =
      GoogleMapsPlaces(apiKey: 'AIzaSyAk-CA4yYf-txNZvvwmCshykjpLiASEkcw');
  List<PlacesSearchResult> addressPredictions = [];
  LatLng? selectedLocation;
  LatLng? currentLocation;
  MarkerId? selectedMarker;
  GoogleMapController? mapController;
  String? addressLat;
  String? addressLng;

  Future<void> searchAddressPlaces(String input) async {
    if (input.isNotEmpty) {
      final response = await places.searchByText(input);

      if (response.isOkay) {
        setState(() {
          addressPredictions = response.results;
        });
      }
    }
  }

  void onAddressLocationSelected(LatLng location, double zoomLevel) {
    setState(() {
      selectedLocation = location;
      currentLocation = null; // Clear current location
      selectedMarker = const MarkerId('selectedLocation');
    });

    mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(selectedLocation!, zoomLevel));
  }
}
