// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'package:deliver_partner/Constants/Colors.dart';
import 'package:deliver_partner/models/APIModelsFleet/GetAllSupportAdmin.dart';
import 'package:deliver_partner/models/APIModelsFleet/GetSupportChatModel.dart';
import 'package:deliver_partner/models/APIModelsFleet/SendSupportChatModel.dart';
import 'package:deliver_partner/temploginReider.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:deliver_partner/models/APIModelsFleet/StartSupportChatModel.dart';

class RiderSupportScreen extends StatefulWidget {
  const RiderSupportScreen({
    super.key,
  });

  @override
  State<RiderSupportScreen> createState() => _RiderSupportScreenState();
}

class _RiderSupportScreenState extends State<RiderSupportScreen> {
  TextEditingController messageController = TextEditingController();

  Timer? timer;
  int userID = -1;
  bool isLoading = false;

  StartSupportChatModel startSupportChatModel = StartSupportChatModel();
  String? getAdminId;
  String? getAdminName;
  String? getAdminImage;
  String? getAdminAddress;

  GetSupportAdminModel getSupportAdminModel = GetSupportAdminModel();
  bool load = false;
  getSupportAdmin() async {
    String apiUrl = "https://cs.deliverbygfl.com/api/get_admin_list";
    print("apiUrl: $apiUrl");
    setState(() {
      load = true;
    });
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Accept': 'application/json',
      },
    );
    final responseString = response.body;
    print("response: $responseString");
    print("statusCode: ${response.statusCode}");
    if (response.statusCode == 200) {
      getSupportAdminModel = getSupportAdminModelFromJson(responseString);

      print('getSupportAdminModel status: ${getSupportAdminModel.status}');
      print(
          'getSupportAdminModel length: ${getSupportAdminModel.data!.length}');
      for (int i = 0; i < getSupportAdminModel.data!.length; i++) {
        if (getSupportAdminModel.data![0].usersSystemId != null &&
            getSupportAdminModel.data![0].name != null &&
            getSupportAdminModel.data![0].profilePic != null &&
            getSupportAdminModel.data![0].address != null) {
          print(
              'getSupportAdminModel id: ${getSupportAdminModel.data![0].usersSystemId}');

          getAdminId = "${getSupportAdminModel.data![0].usersSystemId}";
          getAdminName = "${getSupportAdminModel.data![0].name}";
          getAdminImage = "${getSupportAdminModel.data![0].profilePic}";
          getAdminAddress = "${getSupportAdminModel.data![0].address}";
          print("getAdminImage $getAdminImage");
        }
      }
      await startSupportChat();
      await getSupportChat();
    }
    setState(() {
      load = false;
    });
    // } catch (e) {
    //   print('Something went wrong = ${e.toString()}');
    //   return null;
    // }
  }

  startSupportChat() async {
    // try{
    sharedPreferences = await SharedPreferences.getInstance();
    userID = (sharedPreferences.getInt('userID') ?? -1);

    String apiUrl = "https://cs.deliverbygfl.com/api/user_chat_live";
    print("apiUrlStartChat: $apiUrl");
    print("userID: $userID");
    print("OtherUserId: ${getAdminId.toString()}");
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
        "other_users_id": getAdminId.toString()
      },
    );
    final responseString = jsonDecode(response.body);
    print("response: $responseString");
    print("status: ${responseString['status']}");
    // } catch (e) {
    //   print('Something went wrong = ${e.toString()}');
    //   return null;
    // }
  }

  GetSupportChatModel getSupportChatModel = GetSupportChatModel();

  getSupportChat() async {
    // try {
    setState(() {
      isLoading = true;
    });
    sharedPreferences = await SharedPreferences.getInstance();
    userID = (sharedPreferences.getInt('userID') ?? -1);

    String apiUrl = "https://cs.deliverbygfl.com/api/user_chat_live";
    print("apiUrlGetChat: $apiUrl");
    print("userID: $userID");
    print("OtherUserId: $getAdminId");
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        "Accept": "application/json",
      },
      body: {
        "request_type": "getMessages",
        "users_type": "Rider",
        "other_users_type": "Admin",
        "users_id": userID.toString(),
        "other_users_id": getAdminId.toString(),
      },
    );
    final responseString = response.body;
    print("response: ${response.body}");
    print("status Code getSupportChatModel: ${response.statusCode}");
    if (response.statusCode == 200) {
      getSupportChatModel = getSupportChatModelFromJson(responseString);
      print('getSupportChatModel status: ${getSupportChatModel.status}');
      print(
          'getSupportChatModel message: ${getSupportChatModel.data?[0].message}');
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
    // } catch (e) {
    //   print('Something went wrong = ${e.toString()}');
    //   return null;
    // }
  }

  SendSupportChatModel sendSupportChatModel = SendSupportChatModel();

  sendSupportChat(String? msg) async {
    try {
      setState(() {
        isLoading = true;
      });
      sharedPreferences = await SharedPreferences.getInstance();
      userID = (sharedPreferences.getInt('userID') ?? -1);

      String apiUrl = "https://cs.deliverbygfl.com/api/user_chat_live";
      print("apiUrlSend: $apiUrl");
      print("userID: $userID");
      print("OtherUserId: $getAdminId");
      print("message: ${messageController.text}");
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Accept': 'application/json',
        },
        body: {
          "request_type": "sendMessage",
          "users_type": "Rider",
          "other_users_type": "Admin",
          "users_id": userID.toString(),
          "other_users_id": getAdminId.toString(),
          "message_type": "text",
          "message": msg
        },
      );
      final responseString = jsonDecode(response.body);
      print("response: $responseString");
      print("status: ${responseString['status']}");
      setState(() {
        isLoading = false;
        getSupportChat();
      });
    } catch (e) {
      print('Something went wrong = ${e.toString()}');
      return null;
    }
  }

  void startTimer() {
    // Start the timer and call getMessageApi() every 1 second
    timer = Timer.periodic(const Duration(seconds: 2), (Timer t) {
      getSupportChat();
    });
  }

  void cancelTimer() {
    // Cancel the timer if it's active
    timer?.cancel();
  }

  // Call this function when the user enters the page
  void onPageEnter() {
    // Start the timer to call getMessageApi() every 1 second
    startTimer();
  }

// Call this function when the user leaves the page
  void onPageExit() {
    // Cancel the timer to stop calling getMessageApi()
    cancelTimer();
  }

  Future<List<ChatCategory>> fetchChatCategories() async {
    final response = await http
        .get(Uri.parse('https://cs.deliverbygfl.com/api/get_chat_categories'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      return jsonResponse.map((data) => ChatCategory.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load chat categories');
    }
  }

  List<ChatCategory> chatCategories = [];
  bool isLoading2 = true;
  @override
  void initState() {
    super.initState();
    fetchChatCategories().then((categories) {
      setState(() {
        chatCategories = categories;
        isLoading = false;
      });
    });
    getSupportAdmin();
    onPageEnter();
  }

  @override
  void dispose() {
    onPageExit();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    if (load == true) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: orange,
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: const Color(0xFFFBF9F7),
        appBar: AppBar(
          backgroundColor: const Color(0xFFFBF9F7),
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: SvgPicture.asset(
                'assets/images/back-icon.svg',
                width: 22,
                height: 22,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
          title: const Text(
            "Contact Support",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: black,
              fontSize: 20,
              fontFamily: 'Syne-Bold',
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: size.height * 0.01),
                Container(
                  width: size.width,
                  height: size.height * 0.1,
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
                                  width: 60,
                                  height: 60,
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  child: FadeInImage(
                                    placeholder: const AssetImage(
                                      "assets/images/user-profile.png",
                                    ),
                                    image: NetworkImage(
                                      'https://cs.deliverbygfl.com/public/$getAdminImage',
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
                          SizedBox(width: size.width * 0.03),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                color: Colors.transparent,
                                width: size.width * 0.55,
                                child: Text(
                                  "$getAdminName",
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    color: black,
                                    fontSize: 16,
                                    fontFamily: 'Syne-SemiBold',
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(height: size.height * 0.005),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/orange-location-icon.svg',
                                  ),
                                  SizedBox(width: size.width * 0.01),
                                  Container(
                                    color: Colors.transparent,
                                    width: size.width * 0.5,
                                    child: AutoSizeText(
                                      "$getAdminAddress",
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        color: Color(0xFFBEBEBE),
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
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                        color: Color(0xFFEBEBEB),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      getSupportChatModel.data != null
                          ? Container(
                              color: Colors.transparent,
                              height: size.height * 0.7,
                              child: ListView.builder(
                                reverse: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount: getSupportChatModel.data?.length,
                                padding: const EdgeInsets.only(bottom: 10),
                                itemBuilder: (context, index) {
                                  int reverseIndex =
                                      getSupportChatModel.data!.length -
                                          1 -
                                          index;
                                  String inputTime =
                                      "${getSupportChatModel.data?[reverseIndex].sendTime}";
                                  DateFormat inputFormat =
                                      DateFormat("H:mm:ss");
                                  DateFormat outputFormat =
                                      DateFormat("h:mm a");
                                  DateTime dateTime =
                                      inputFormat.parse(inputTime);
                                  String formattedTime =
                                      outputFormat.format(dateTime);
                                  return getSupportChatModel.data?[reverseIndex]
                                                  .receiverType !=
                                              "Rider" &&
                                          getSupportChatModel
                                                  .data?[reverseIndex]
                                                  .messageType ==
                                              "text"
                                      ? Column(
                                          children: [
                                            SizedBox(
                                                height: size.height * 0.015),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 84),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10),
                                                      topRight:
                                                          Radius.circular(10),
                                                      bottomLeft:
                                                          Radius.circular(10),
                                                    ),
                                                    child: Container(
                                                      color: orange,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Container(
                                                              color: Colors
                                                                  .transparent,
                                                              width:
                                                                  size.width *
                                                                      0.6,
                                                              child: Text(
                                                                "${getSupportChatModel.data?[reverseIndex].message}",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    const TextStyle(
                                                                  color: white,
                                                                  fontSize: 12,
                                                                  fontFamily:
                                                                      'Inter-Regular',
                                                                ),
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                SvgPicture
                                                                    .asset(
                                                                  'assets/images/clock-white-message-icon.svg',
                                                                ),
                                                                SizedBox(
                                                                    width: size
                                                                            .width *
                                                                        0.01),
                                                                Text(
                                                                  formattedTime,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      const TextStyle(
                                                                    color:
                                                                        white,
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
                                                height: size.height * 0.015),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  child: Container(
                                                    width: 25,
                                                    height: 25,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.transparent,
                                                    ),
                                                    child: FadeInImage(
                                                      placeholder:
                                                          const AssetImage(
                                                        "assets/images/user-profile.png",
                                                      ),
                                                      image: NetworkImage(
                                                        'https://cs.deliverbygfl.com/public/$getAdminImage',
                                                      ),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: size.width * 0.02),
                                                ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10),
                                                  ),
                                                  child: Container(
                                                    color:
                                                        const Color(0xFFEBEBEB),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Container(
                                                            color: Colors
                                                                .transparent,
                                                            width: size.width *
                                                                0.6,
                                                            child: Text(
                                                              "${getSupportChatModel.data?[reverseIndex].message}",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style:
                                                                  const TextStyle(
                                                                color: Color(
                                                                    0xFF0A0A0A),
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    'Inter-Regular',
                                                              ),
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              SvgPicture.asset(
                                                                'assets/images/clock-message-icon.svg',
                                                              ),
                                                              SizedBox(
                                                                  width:
                                                                      size.width *
                                                                          0.01),
                                                              Text(
                                                                formattedTime,
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    const TextStyle(
                                                                  color: Color(
                                                                      0xFFA3A6AA),
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
                                          ],
                                        );
                                },
                              ),
                            )
                          : Container(
                              color: Colors.transparent,
                              height: size.height * 0.7,
                            ),
                    ],
                  ),
                ),
                chatCategoryButtons(),
                SizedBox(height: size.height * 0.005),
                Container(
                  width: size.width,
                  height: size.height * 0.06,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEBEBEB),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: messageController,
                          cursorColor: orange,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          minLines: 1,
                          maxLines: null,
                          style: const TextStyle(
                            color: black,
                            fontSize: 14,
                            fontFamily: 'Inter-Regular',
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFEBEBEB),
                            errorStyle: const TextStyle(
                              color: red,
                              fontSize: 10,
                              fontFamily: 'Inter-Bold',
                            ),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide: BorderSide.none,
                            ),
                            focusedErrorBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide: BorderSide.none,
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide: BorderSide(
                                color: red,
                                width: 1,
                              ),
                            ),
                            contentPadding: const EdgeInsets.only(
                              top: 5,
                              left: 20,
                              right: 0,
                              bottom: 5,
                            ),
                            hintText: "Write message here...",
                            hintStyle: TextStyle(
                              color: const Color(0xFF191919).withOpacity(0.5),
                              fontSize: 12,
                              fontFamily: 'Inter-Light',
                            ),
                          ),
                        ),
                      ),
                      Theme(
                        data: ThemeData(
                          hoverColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                        ),
                        child: FloatingActionButton(
                          onPressed: () async {
                            if (messageController.text.isNotEmpty) {
                              sendSupportChat(messageController.text);
                              setState(() {
                                messageController.clear();
                                FocusManager.instance.primaryFocus?.unfocus();
                              });
                            } else {}
                          },
                          elevation: 0,
                          tooltip: 'Send',
                          hoverElevation: 0,
                          disabledElevation: 0,
                          highlightElevation: 0,
                          foregroundColor: Colors.transparent,
                          backgroundColor: Colors.white,
                          child: SvgPicture.asset(
                            'assets/images/send-icon.svg',
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.02),
              ],
            ),
          ),
        ),
      );
    }
  }

  String? messgs;
  Widget chatCategoryButtons() {
    return Wrap(
      spacing: 8.0, // Horizontal space between buttons
      runSpacing: 4.0, // Vertical space between button rows
      alignment: WrapAlignment.center, // Center align the buttons
      children: chatCategories.map((category) {
        return TextButton(
          onPressed: () {
            setState(() {
              messgs = category.name; // Set the message
            });
            sendSupportChat(messgs); // Send the message
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.orangeAccent, // Ensure solid color is used
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(5), // Optional: Rounded corners
            ),
          ),
          child: Text(category.name),
        );
      }).toList(),
    );
  }
}

class ChatCategory {
  final int id;
  final String name;

  ChatCategory({required this.id, required this.name});

  factory ChatCategory.fromJson(Map<String, dynamic> json) {
    return ChatCategory(
      id: json['chat_categories_id'],
      name: json['name'],
    );
  }
}
