import 'dart:async';

import 'package:deliver_partner/Constants/Colors.dart';
import 'package:deliver_partner/Constants/PageLoadingKits.dart';
import 'package:deliver_partner/models/API_models/GetAllUserToUsreChatModel.dart';
import 'package:deliver_partner/utilities/showToast.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../Constants/back-arrow-with-container.dart';
import '../../../../models/API_models/API_response.dart';
import '../../../../services/API_services.dart';

class UserToUserChat extends StatefulWidget {
  final String riderID;
  final String clientID;
  final String? name;
  final String? image;
  final String? phone;
  final String? address;
  const UserToUserChat({
    super.key,
    required this.riderID,
    required this.phone,
    required this.clientID,
    this.name,
    this.image,
    this.address,
  });

  @override
  State<UserToUserChat> createState() => _UserToUserChatState();
}

class _UserToUserChatState extends State<UserToUserChat> {
  ApiServices get service => GetIt.I<ApiServices>();

  TextEditingController sendMessageController = TextEditingController();
  late Timer chatRefreshTimer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chatRefreshTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      init();
    });
    init();
  }

  // bool isLoading = false;
  late APIResponse<List<GetAllUserToUserChatModel>>
      getAllUserToUserMessagesResponse;
  late List<GetAllUserToUserChatModel> getAllUserToUserChatList;

  Future<void> init() async {
    // setState(() {
    //   isLoading = true;
    // });

    Map data = {
      "request_type": "getMessages",
      "users_type": "Rider",
      "other_users_type": "Customers",
      "users_id": widget.riderID.toString(),
      "other_users_id": widget.clientID.toString(),
    };
    print('object get all msgs:   $data');
    getAllUserToUserChatList = [];
    getAllUserToUserMessagesResponse =
        await service.getAllUserToUserChatAPI(data);
    if (getAllUserToUserMessagesResponse.status!.toLowerCase() == 'success') {
      if (getAllUserToUserMessagesResponse.data != null) {
        print(
            'object getting all msgs success:   ${getAllUserToUserMessagesResponse.data}');
        getAllUserToUserChatList.addAll(getAllUserToUserMessagesResponse.data!);
        if (mounted) {
          setState(() {});
        }
      }
    } else {
      print(
          'object error getting chat:${getAllUserToUserMessagesResponse.status}');
      showToastError('could\'nt get chat', FToast().init(context));
    }
    // setState(() {
    //   isLoading = false;
    // });
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  void dispose() {
    super.dispose();
    chatRefreshTimer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0.0,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'Call and Chat',
          style: GoogleFonts.syne(
            fontWeight: FontWeight.w700,
            color: black,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        // actions: [
        //   Padding(
        //     padding: EdgeInsets.only(top: 8.h, right: 20.w),
        //     child: GestureDetector(
        //       onTap: () => init(),
        //       child: const Icon(
        //         Icons.refresh_rounded,
        //         color: orange,
        //         size: 28,
        //       ),
        //     ),
        //   )
        // ],
      ),
      backgroundColor: white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          child: Column(
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height * 0.1,
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 0.15,
                                height:
                                    MediaQuery.sizeOf(context).height * 0.07,
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                child: FadeInImage(
                                  placeholder: const AssetImage(
                                    "assets/images/user-profile.png",
                                  ),
                                  image: NetworkImage(
                                    'https://deliverbygfl.com/public/${widget.image}',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            // Positioned(
                            //   top: 8,
                            //   right: 0,
                            //   child: SvgPicture.asset(
                            //     'assets/images/online-status-icon.svg',
                            //   ),
                            // ),
                          ],
                        ),
                        SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.03),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: Colors.transparent,
                              width: MediaQuery.sizeOf(context).width * 0.55,
                              child: Text(
                                "${widget.name}",
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'Syne-SemiBold',
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.sizeOf(context).height * 0.005),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/location.svg',
                                ),
                                SizedBox(
                                    width: MediaQuery.sizeOf(context).width *
                                        0.01),
                                Container(
                                  color: Colors.transparent,
                                  width: MediaQuery.sizeOf(context).width * 0.5,
                                  child: AutoSizeText(
                                    "${widget.address}",
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      color: grey,
                                      fontSize: 12,
                                      fontFamily: 'Inter-Regular',
                                    ),
                                    minFontSize: 12,
                                    maxFontSize: 12,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            _makePhoneCall(widget.phone.toString());
                          },
                          child: Container(
                            width: 34.w,
                            height: 34.h,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: orange,
                            ),
                            child: SvgPicture.asset(
                              'assets/images/call.svg',
                              width: 30,
                              height: 30,
                              colorFilter: const ColorFilter.mode(
                                  white, BlendMode.srcIn),
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                      color: grey,
                    ),
                  ],
                ),
              ),
              // isLoading
              //     ? Expanded(
              //   child: SpinKitWaveSpinner(
              //     waveColor: orange,
              //     color: orange,
              //     size: 90.0,
              //   ),
              // ) :
              Expanded(
                child: ListView.builder(
                  itemCount: getAllUserToUserChatList.length,
                  reverse: true,
                  itemBuilder: (context, index) {
                    int reverseIndex =
                        getAllUserToUserChatList.length - 1 - index;
                    String inputTime =
                        "${getAllUserToUserChatList[reverseIndex].send_time}";
                    DateFormat inputFormat = DateFormat("H:mm:ss");
                    DateFormat outputFormat = DateFormat("h:mm a");
                    DateTime dateTime = inputFormat.parse(inputTime);
                    String formattedTime = outputFormat.format(dateTime);
                    return getAllUserToUserChatList[reverseIndex].sender_type ==
                            'Rider'
                        ? Column(
                            children: [
                              SizedBox(
                                  height: MediaQuery.sizeOf(context).height *
                                      0.015),
                              Padding(
                                padding: const EdgeInsets.only(left: 80),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                      ),
                                      child: Container(
                                        color: orange,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Container(
                                                color: Colors.transparent,
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.6,
                                                child: Text(
                                                  "${getAllUserToUserChatList[reverseIndex].message}",
                                                  textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                    color: white,
                                                    fontSize: 12,
                                                    fontFamily: 'Inter-Regular',
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/images/chat-timer-grey.svg',
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.01),
                                                  Text(
                                                    formattedTime,
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                      color: white,
                                                      fontSize: 8,
                                                      fontFamily:
                                                          'Inter-Regular',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              SizedBox(
                                  height: MediaQuery.sizeOf(context).height *
                                      0.015),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Container(
                                      width: 25.6,
                                      height: 25.5,
                                      decoration: const BoxDecoration(
                                        color: Colors.transparent,
                                      ),
                                      child: FadeInImage(
                                        placeholder: const AssetImage(
                                          "assets/images/user-profile.png",
                                        ),
                                        image: NetworkImage(
                                          'https://deliverbygfl.com/public/${widget.image}',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.02),
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                    child: Container(
                                      color: lightGrey,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                              color: Colors.transparent,
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.6,
                                              child: Text(
                                                "${getAllUserToUserChatList[reverseIndex].message}",
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontFamily: 'Inter-Regular',
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/images/chat-timer-grey.svg',
                                                ),
                                                SizedBox(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.01),
                                                Text(
                                                  formattedTime,
                                                  textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                    color: grey,
                                                    fontSize: 8,
                                                    fontFamily: 'Inter-Regular',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                    //   Container(
                    //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    //   margin: const EdgeInsets.only(bottom: 10, right: 40),
                    //   child: Align(
                    //     alignment: getAllUserToUserChatList[index].receiver_type == 'Rider'
                    //         ? Alignment.topLeft
                    //         : Alignment.topRight,
                    //     child: Row(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         ClipRRect(
                    //           borderRadius:
                    //           const BorderRadius.only(
                    //             topLeft: Radius.circular(10),
                    //             topRight: Radius.circular(10),
                    //             bottomLeft: Radius.circular(10),
                    //           ),
                    //           child: Container(
                    //             color: getAllUserToUserChatList[index].receiver_type == 'Rider' ? orange : Colors.black,
                    //             width: 100,
                    //             child: Padding(
                    //               padding: const EdgeInsets.all(10),
                    //               child: Column(
                    //                 // crossAxisAlignment: CrossAxisAlignment.end,
                    //                 children: [
                    //                   Container(
                    //                     color: Colors.transparent,
                    //                     width: MediaQuery.sizeOf(context).width * 0.6,
                    //                     child: Text(
                    //                       "${getAllUserToUserChatList[reverseIndex].message}",
                    //                       textAlign: TextAlign.left,
                    //                       style:
                    //                       TextStyle(
                    //                         color: white,
                    //                         fontSize: 12,
                    //                         fontFamily: 'Inter-Regular',
                    //                       ),
                    //                     ),
                    //                   ),
                    //                   Row(
                    //                     children: [
                    //                       SvgPicture.asset(
                    //                         'assets/images/chat-timer-grey.svg',
                    //                       ),
                    //                       SizedBox(
                    //                           width: MediaQuery.sizeOf(context).width * 0.01),
                    //                       Text(
                    //                         formattedTime, textAlign:
                    //                         TextAlign.left,
                    //                         style: TextStyle(
                    //                           color: white,
                    //                           fontSize: 8,
                    //                           fontFamily: 'Inter-Regular',
                    //                         ),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: EdgeInsets.only(
                  bottom: 12.h,
                  top: 12.h,
                ),
                decoration: BoxDecoration(
                  color: lightGrey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: sendMessageController,
                        cursorColor: orange,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        minLines: 1,
                        maxLines: null,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Inter-Regular',
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: 'Write message here..',
                          hintStyle: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: black,
                          ),
                        ),
                      ),
                    ),
                    isSending
                        ? SizedBox(
                            // width: 10.w,
                            height: 10.h,
                            child: const SpinKitThreeInOut(
                              size: 12,
                              color: orange,
                              // size: 50.0,
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              sendMessage(context);
                            },
                            child: SvgPicture.asset(
                              'assets/images/pointer.svg',
                              colorFilter: const ColorFilter.mode(
                                  orange, BlendMode.srcIn),
                              height: 40,
                              width: 40,
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isSending = false;
  APIResponse<APIResponse>? sendMsgResponse;

  Future<void> sendMessage(BuildContext context) async {
    setState(() {
      isSending = true;
    });
    Map sendMsgData = {
      "request_type": "sendMessage",
      "users_type": "Rider",
      "other_users_type": "Customers",
      "users_id": widget.riderID.toLowerCase(),
      "other_users_id": widget.clientID.toString(),
      "message_type": "text",
      "message": sendMessageController.text,
    };
    sendMsgResponse = await service.sendUserToUserChatAPI(sendMsgData);
    if (sendMsgResponse!.status!.toLowerCase() == 'success') {
      sendMessageController.clear();
      showToastSuccess(sendMsgResponse!.message, FToast().init(context),
          seconds: 1);
      init();
      print('msg send');
    } else {
      showToastError(sendMsgResponse!.message, FToast().init(context),
          seconds: 1);
    }
    setState(() {
      isSending = false;
    });
  }
}
