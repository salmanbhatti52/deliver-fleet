import 'package:deliver_partner/Constants/Colors.dart';
import 'package:deliver_partner/Constants/drawer_container.dart';
import 'package:deliver_partner/widgets/DrawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../services/API_services.dart';
import 'CencelledRidesScreen.dart';
import 'CompletedRidesScreen.dart';
import 'InProgresssScreen.dart';

class RidesScreen extends StatefulWidget {
  const RidesScreen({super.key});

  @override
  State<RidesScreen> createState() => _RidesScreenState();
}

class _RidesScreenState extends State<RidesScreen>
    with SingleTickerProviderStateMixin {
  ApiServices get service => GetIt.I<ApiServices>();

  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(3, 5, 3, 5),
                  width: double.infinity,
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      width: 1,
                      color: lightGrey.withOpacity(0.5),
                    ),
                  ),
                  child: TabBar(
                    labelColor: white,
                    controller: tabController,
                    unselectedLabelColor: black,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(19),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xffFF6302),
                          Color(0xffFBC403),
                        ],
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                      ),
                    ),
                    tabs: [
                      Text(
                        'In Progress',
                        style: GoogleFonts.syne(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'Completed',
                        style: GoogleFonts.syne(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,

                        ),
                      ),
                      Text(
                        'Cancelled',
                        style: GoogleFonts.syne(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,

                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: tabController,
                    children: const [
                      InProgressScreen(),
                      CompletedRidesScreen(),
                      CencelledRidesScreen(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
