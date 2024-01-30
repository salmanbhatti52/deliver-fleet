import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Constants/PageLoadingKits.dart';
import '../../../models/API models/API response.dart';
import '../../../models/API models/InProgressRidesModel.dart';
import '../../../services/API_services.dart';
import 'CancelledRidesWidget.dart';

class CencelledRidesScreen extends StatefulWidget {
  const CencelledRidesScreen({super.key});

  @override
  State<CencelledRidesScreen> createState() => _CencelledRidesScreenState();
}

class _CencelledRidesScreenState extends State<CencelledRidesScreen> {
  ApiServices get service => GetIt.I<ApiServices>();

  int userID = -1;
  late SharedPreferences sharedPreferences;
  bool isPageLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
    isPageLoading = true;
  }

  APIResponse<List<InProgressRidesModel>>? canceledRidesResponse;
  List<InProgressRidesModel>? cancelledRidesList;

  // APIResponse<GetUserProfileModel>? getUserProfileResponse;
  // GetUserProfileModel? getUserProfile;
  String? imageHolder;

  init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userID = (sharedPreferences.getInt('userID') ?? -1);

    Map data = {
      "users_fleet_id": userID.toString(),
    };

    // getUserProfileResponse = await service.getUserProfileAPI(data);
    // if (getUserProfileResponse!.status!.toLowerCase() == 'success') {
    //   getUserProfile = getUserProfileResponse!.data!;
    //   imageHolder = getUserProfile!.profile_pic!;
    // }

    canceledRidesResponse = await service.canceledRidesAPI(data);
    cancelledRidesList = [];

    if (canceledRidesResponse!.status!.toLowerCase() == 'success') {
      if (canceledRidesResponse!.data != null) {
        cancelledRidesList = canceledRidesResponse!.data!;
      }
    } else {}
    if (mounted) {
      setState(() {
        isPageLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isPageLoading
        ? spinKitRotatingCircle
        : cancelledRidesList!.isEmpty
            ? Lottie.asset('assets/images/no-data.json')
            : ListView.builder(
                itemCount: cancelledRidesList!.length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return CancelledRidesWidget(
                    canceledRidesModel: cancelledRidesList![index],
                  );
                },
              );
  }
}
