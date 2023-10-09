import 'package:Deliver_Rider/Constants/Colors.dart';
import 'package:Deliver_Rider/Constants/PageLoadingKits.dart';
import 'package:Deliver_Rider/models/API%20models/GetAllUserToUsreChatModel.dart';
import 'package:Deliver_Rider/utilities/showToast.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Constants/back-arrow-with-container.dart';
import '../../../../models/API models/API response.dart';
import '../../../../services/API_services.dart';

class UserToUserChat extends StatefulWidget {
  final String riderID;
  final String clientID;
  final String? name;
  final String? image;
  final String? address;
  const UserToUserChat({
    super.key,
    required this.riderID,
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

  late TextEditingController sendMessageController;

  // Timer? getMessageTimer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
    // getMessageTimer = Timer.periodic(Duration(seconds: 10), (Timer t) {
    //   print('object api after 5 sec runs successfully');
    //   return init();
    // });
  }

  bool isLoading = false;
  late APIResponse<List<GetAllUserToUserChatModel>>
      getAllUserToUserMessagesResponse;
  late List<GetAllUserToUserChatModel> getAllUserToUserChatList;

  init() async {
    setState(() {
      isLoading = true;
    });

    sendMessageController = TextEditingController();

    Map data = {
      "request_type": "getMessages",
      "users_type": "Rider",
      "other_users_type": "Customers",
      "users_id": widget.riderID.toString(),
      "other_users_id": widget.clientID.toString(),
    };
    print('object get all msgs:   ' + data.toString());
    getAllUserToUserChatList = [];
    getAllUserToUserMessagesResponse =
        await service.getAllUserToUserChatAPI(data);
    if (getAllUserToUserMessagesResponse.status!.toLowerCase() == 'success') {
      if (getAllUserToUserMessagesResponse.data != null) {
        print('object getting all msgs success:   ' +
            getAllUserToUserMessagesResponse.data.toString());
        getAllUserToUserChatList.addAll(getAllUserToUserMessagesResponse.data!);
      }
    } else {
      print('object error getting chat:' +
          getAllUserToUserMessagesResponse.status.toString());
      showToastError('could\'nt get chat', FToast().init(context));
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    // getMessageTimer?.cancel();
    super.dispose();
    sendMessageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0.0,
        leading: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 20),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: backArrowWithContainer(context),
          ),
        ),
        title: Text(
          'Call and Chat',
          style: GoogleFonts.syne(
            fontWeight: FontWeight.w700,
            color: black,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(top: 8.h, right: 20.w),
            child: GestureDetector(
              onTap: () => init(),
              child: const Icon(
                Icons.refresh_rounded,
                color: orange,
                size: 28,
              ),
            ),
          )
        ],
      ),
      backgroundColor: white,
      body: isLoading
          ? spinKitRotatingCircle
          : SafeArea(
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
                                      height: MediaQuery.sizeOf(context).height * 0.07,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                      ),
                                      child: FadeInImage(
                                        placeholder: const AssetImage(
                                          "assets/images/user-profile.png",
                                        ),
                                        image: NetworkImage(
                                          'https://deliver.eigix.net/public/${widget.image}',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 0,
                                    child: SvgPicture.asset(
                                      'assets/images/online-status-icon.svg',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: MediaQuery.sizeOf(context).width * 0.03),
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
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontFamily: 'Syne-SemiBold',
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.005),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/orange-location-icon.svg',
                                      ),
                                      SizedBox(width: MediaQuery.sizeOf(context).width * 0.01),
                                      Container(
                                        color: Colors.transparent,
                                        width: MediaQuery.sizeOf(context).width * 0.5,
                                        child: AutoSizeText(
                                          "${widget.address}",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
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
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => CallScreen(
                                  //       name: widget.name,
                                  //       image: widget.image,
                                  //     ),
                                  //   ),
                                  // );
                                },
                                child: SvgPicture.asset(
                                  'assets/images/call-icon.svg',
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 1,
                            color: grey,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: getAllUserToUserChatList.length,
                        itemBuilder: (context, index) {
                          bool isClient = getAllUserToUserChatList[index].receiver_data!.users_fleet_id != -1;
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            margin:
                                const EdgeInsets.only(bottom: 10, right: 40),
                            child: Align(
                              alignment: isClient &&
                                      getAllUserToUserChatList[index]
                                              .receiver_type!
                                              .toLowerCase() ==
                                          'Customers'
                                  ? Alignment.topLeft
                                  : Alignment.topRight,
                              child: Container(
                                // height: double.parse(
                                //     '${messagesList![index].message!.length}'),
                                width: double.infinity,

                                decoration: const BoxDecoration(
                                  color: lightGrey,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                ),
                                alignment: isClient &&
                                        getAllUserToUserChatList[index]
                                                .receiver_type!
                                                .toLowerCase() ==
                                            'Customers'
                                    ? Alignment.topLeft
                                    : Alignment.topRight,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  // crossAxisAlignment:
                                  //     CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: isClient &&
                                              getAllUserToUserChatList[index]
                                                      .receiver_type!
                                                      .toLowerCase() ==
                                                  'Customers'
                                          ? Alignment.topLeft
                                          : Alignment.topRight,
                                      child: Text(
                                        getAllUserToUserChatList[index]
                                            .message!,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines:
                                            getAllUserToUserChatList[index]
                                                .message!
                                                .length,
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: black,
                                        ).copyWith(
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/chat-timer-grey.svg',
                                          colorFilter: const ColorFilter.mode(
                                              grey, BlendMode.srcIn),
                                          width: 10,
                                          height: 10,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          getAllUserToUserChatList[index]
                                              .send_date!,
                                          style: GoogleFonts.inter(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w400,
                                            color: black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      margin: EdgeInsets.only(
                        bottom: 12.h,
                        top: 12.h,
                      ),
                      // height:
                      //     double.parse('${textEditingController.text.length}'),
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: lightGrey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Center(
                              child: TextFormField(
                                controller: sendMessageController,
                                scrollPhysics: const BouncingScrollPhysics(),
                                maxLines: 20,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: black,
                                ),
                                cursorColor: orange,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  // contentPadding: EdgeInsets.zero,
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
                          ),
                          isSending
                              ? SizedBox(
                                  // width: 10.w,
                                  height: 10.h,
                                  child: SpinKitThreeInOut(
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

  sendMessage(BuildContext context) async {
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
