import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:deliver_partner/services/API_services.dart';
import 'package:deliver_partner/Constants/PageLoadingKits.dart';
import 'package:deliver_partner/models/API_models/API_response.dart';
import 'package:deliver_partner/models/API_models/InProgressRidesModel.dart';
import 'package:deliver_partner/RiderScreens/AfterLogInScreens/RidesScreens/CompletedRidesWidget.dart';

class CompletedRidesScreen extends StatefulWidget {
  const CompletedRidesScreen({super.key});

  @override
  State<CompletedRidesScreen> createState() => _CompletedRidesScreenState();
}

class _CompletedRidesScreenState extends State<CompletedRidesScreen> {
  ApiServices get service => GetIt.I<ApiServices>();

  late ScrollController scrollController;

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

  APIResponse<List<InProgressRidesModel>>? completedRidesResponse;
  List<InProgressRidesModel>? completedRidesList;

  // APIResponse<GetUserProfileModel>? getUserProfileResponse;
  // GetUserProfileModel? getUserProfile;
  String? imageHolder;

  init() async {
    scrollController = ScrollController();

    sharedPreferences = await SharedPreferences.getInstance();
    userID = (sharedPreferences.getInt('userID') ?? -1);
    debugPrint("userId on completed rides is: $userID");

    Map data = {
      "users_fleet_id": userID.toString(),
    };

    completedRidesResponse = await service.completedRidesAPI(data);
    completedRidesList = [];

    if (completedRidesResponse!.status!.toLowerCase() == 'success') {
      if (completedRidesResponse!.data != null) {
        completedRidesList = completedRidesResponse!.data!;
      }
    } else {
      debugPrint("error status: ${completedRidesResponse!.status}");
      debugPrint("error massage: ${completedRidesResponse!.message}");
    }
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
        : completedRidesList!.isEmpty
            ? Lottie.asset('assets/images/no-data.json')
            : ListView.builder(
                itemCount: completedRidesList!.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return CompletedRidesWidget(
                    completedRidesModel: completedRidesList![index],
                  );
                },
              );
  }
}
