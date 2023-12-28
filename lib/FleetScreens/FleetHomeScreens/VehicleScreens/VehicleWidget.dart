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
    return GestureDetector(
      onTap: () {
        print('sd: ${widget.getAllVehiclesFleetModel.users_fleet_vehicles_id}');
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  VehicleDetailScreenFleet(
                    users_fleet_vehicles_id: widget.getAllVehiclesFleetModel
                        .users_fleet_vehicles_id!,
                  ),
            ),
          );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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
                  width: 65.w,
                  height: 65.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: orange,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(65),
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
                  width: 10.w,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 100.w,
                      child: Text(
                        widget.getAllVehiclesFleetModel.model!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: GoogleFonts.syne(
                          fontSize: 16,
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
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 15.w,
                ),
                widget.getAllVehiclesFleetModel.users_fleet_vehicles_assigned!.users_fleet_id == -1
                    ? Container(
                        width: 80.w,
                        height: 25.h,
                        decoration: BoxDecoration(
                          color: orange,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            '${widget.getAllVehiclesFleetModel.total_requests!} requests',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      )
                    : widget.getAllVehiclesFleetModel.users_fleet_vehicles_assigned!.users_fleet_id != -1
                        ? Container(
                            width: 80.w,
                            height: 25.h,
                            decoration: BoxDecoration(
                              color: green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Text(
                                'Assigned',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
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
