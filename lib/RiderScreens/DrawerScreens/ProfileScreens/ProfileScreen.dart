import 'package:deliver_partner/models/API_models/LogInModel.dart';
import 'package:deliver_partner/widgets/ProfileDetailsFromDrawerProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Constants/Colors.dart';
import '../../../Constants/PageLoadingKits.dart';
import '../../../Constants/back-arrow-with-container.dart';
import '../../../Constants/editButtonContainer.dart';
import '../../../models/API_models/API_response.dart';
import '../../../services/API_services.dart';
import '../../../utilities/showToast.dart';
import 'EditProfileScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
        if (mounted) {
          showToastSuccess('Loading user data', FToast().init(context),
              seconds: 1);
        }
      }
    } else {
      showToastError(getUserProfileResponse!.message, FToast().init(context));
    }

    setState(() {
      isPageLoading = false;
    });
  }

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
          'Profile',
          style: GoogleFonts.syne(
            fontWeight: FontWeight.w700,
            color: black,
            fontSize: 20,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(top: 8.h, right: 20.w),
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditProfileScreen(
                    firstName: getUserProfileResponse!.data!.first_name!,
                    lastName: getUserProfileResponse!.data!.last_name!,
                    phoneNumber: getUserProfileResponse!.data!.phone!,
                    image: getUserProfileResponse!.data!.profile_pic!,
                    address: getUserProfileResponse!.data!.address!,
                    frontImage: getUserProfileResponse!
                        .data!.driving_license_front_image!,
                    backImage: getUserProfileResponse!
                        .data!.driving_license_back_image!,
                  ),
                ),
              ),
              child: editButtonContainer(context),
            ),
          )
        ],
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: isPageLoading
          ? spinKitRotatingCircle
          : GlowingOverscrollIndicator(
              axisDirection: AxisDirection.down,
              color: orange,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 38.0.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
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
                          child:
                              getUserProfileResponse!.data!.profile_pic != null
                                  ? Image.network(
                                      'https://deliverbygfl.com/public/${getUserProfileResponse!.data!.profile_pic}',
                                      fit: BoxFit.cover,
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        return SizedBox(
                                          child: Image.asset(
                                            'assets/images/place-holder.png',
                                            fit: BoxFit.scaleDown,
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
                                    )
                                  : Image.asset(
                                      'assets/images/place-holder.png',
                                      fit: BoxFit.scaleDown,
                                    ),
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      profileDetails(context, 'First Name',
                          '${getUserProfileResponse!.data!.first_name}'),
                      SizedBox(
                        height: 20.h,
                      ),
                      profileDetails(context, 'Last Name',
                          '${getUserProfileResponse!.data!.last_name}'),
                      SizedBox(
                        height: 20.h,
                      ),
                      profileDetails(context, 'Address',
                          '${getUserProfileResponse!.data!.address}'),
                      SizedBox(
                        height: 20.h,
                      ),
                      profileDetails(context, 'Email',
                          '${getUserProfileResponse!.data!.email}'),
                      SizedBox(
                        height: 20.h,
                      ),
                      profileDetails(context, 'Phone No.',
                          '${getUserProfileResponse!.data!.phone}'),
                      SizedBox(
                        height: 30.h,
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
                                    Container(
                                      width: 170.w,
                                      height: 110.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: getUserProfileResponse!.data!
                                                    .driving_license_front_image !=
                                                null
                                            ? Image.network(
                                                'https://deliverbygfl.com/public/${getUserProfileResponse!.data!.driving_license_front_image}',
                                                fit: BoxFit.cover,
                                                errorBuilder: (BuildContext
                                                        context,
                                                    Object exception,
                                                    StackTrace? stackTrace) {
                                                  return SizedBox(
                                                    child: Image.asset(
                                                        'assets/images/place-holder.png'),
                                                  );
                                                },
                                                loadingBuilder:
                                                    (BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                  if (loadingProgress == null) {
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
                                              )
                                            : Image.asset(
                                                'assets/images/place-holder.png'),
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
                                    Container(
                                      width: 170.w,
                                      height: 110.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: getUserProfileResponse!.data!
                                                    .driving_license_back_image !=
                                                null
                                            ? Image.network(
                                                'https://deliverbygfl.com/public/${getUserProfileResponse!.data!.driving_license_back_image}',
                                                fit: BoxFit.cover,
                                                errorBuilder: (BuildContext
                                                        context,
                                                    Object exception,
                                                    StackTrace? stackTrace) {
                                                  return SizedBox(
                                                    child: Image.asset(
                                                        'assets/images/place-holder.png'),
                                                  );
                                                },
                                                loadingBuilder:
                                                    (BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                  if (loadingProgress == null) {
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
                                              )
                                            : Image.asset(
                                                'assets/images/place-holder.png'),
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
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
