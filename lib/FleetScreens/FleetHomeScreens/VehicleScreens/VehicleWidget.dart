import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Constants/Colors.dart';
import '../../../models/APIModelsFleet/GetAllVehiclesFleetModel.dart';
import 'VehicleDetailScreenFleet.dart';

class VehicleWidget extends StatefulWidget {
  final GetAllVehiclesFleetModel getAllVehiclesFleetModel;
  const VehicleWidget({super.key, required this.getAllVehiclesFleetModel});

  @override
  State<VehicleWidget> createState() => _VehicleWidgetState();
}

class _VehicleWidgetState extends State<VehicleWidget> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        print(
            'usersFleetVehiclesAssigned: ${widget.getAllVehiclesFleetModel.users_fleet_vehicles_assigned!.users_fleet_id}');
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => VehicleDetailScreenFleet(
              users_fleet_vehicles_id:
                  widget.getAllVehiclesFleetModel.users_fleet_vehicles_id!,
              usersFleetVehiclesAssigned: widget.getAllVehiclesFleetModel
                  .users_fleet_vehicles_assigned!.users_fleet_id!,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth > 600 ? 24 : 12,
          vertical: screenHeight > 1000 ? 8 : 4,
        ),
        width: double.infinity,
        height: 75.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: screenWidth > 600 ? 65 : 50,
                  height: screenWidth > 600 ? 65 : 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: orange,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(screenWidth > 600 ? 65 : 50),
                    child: Image.network(
                      'https://deliver.eigix.net/public/${widget.getAllVehiclesFleetModel.image}',
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return SizedBox(
                            child: Image.asset(
                          'assets/images/place-holder.png',
                          fit: BoxFit.scaleDown,
                        ));
                      },
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            color: orange,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: screenWidth > 600 ? 15 : 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: screenWidth > 600 ? 150 : 100,
                      child: Text(
                        widget.getAllVehiclesFleetModel.model!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: GoogleFonts.syne(
                          fontSize: screenWidth > 600 ? 24 : 16,
                          fontWeight: FontWeight.w700,
                          color: black,
                        ).copyWith(
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Text(
                      widget.getAllVehiclesFleetModel.vehicle!.name!,
                      style: GoogleFonts.inter(
                        fontSize: screenHeight > 1000 ? 16 : 14,
                        fontWeight: FontWeight.w500,
                        color: grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: screenWidth > 600 ? 20 : 15,
                ),
                widget.getAllVehiclesFleetModel.users_fleet_vehicles_assigned!
                            .users_fleet_id ==
                        -1
                    ? Container(
                        width: screenWidth > 600 ? 120 : 80,
                        height: screenHeight > 1000 ? 35 : 25,
                        decoration: BoxDecoration(
                          color: orange,
                          borderRadius: BorderRadius.circular(
                              screenHeight > 1000 ? 20 : 15),
                        ),
                        child: Center(
                          child: Text(
                            '${widget.getAllVehiclesFleetModel.total_requests!} requests',
                            style: GoogleFonts.inter(
                              fontSize: screenHeight > 1000 ? 18 : 12,
                              color: white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      )
                    : widget
                                .getAllVehiclesFleetModel
                                .users_fleet_vehicles_assigned!
                                .users_fleet_id !=
                            -1
                        ? Container(
                            width: screenWidth > 600 ? 120 : 80,
                            height: screenHeight > 1000 ? 35 : 25,
                            decoration: BoxDecoration(
                              color: green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(
                                  screenHeight > 1000 ? 20 : 15),
                            ),
                            child: Center(
                              child: Text(
                                'Assigned',
                                style: GoogleFonts.inter(
                                  fontSize: screenHeight > 1000 ? 18 : 12,
                                  color: green,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: grey,
            ),
          ],
        ),
      ),
    );
  }
}
