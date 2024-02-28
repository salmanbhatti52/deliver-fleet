import 'package:deliver_partner/Constants/buttonContainer.dart';
import 'package:flutter/material.dart';

class CustomDialogBox extends StatefulWidget {
  Function onCameraBTNPressed, onGalleryBTNPressed;
  final String name;

  CustomDialogBox(
      {super.key,
      required this.onCameraBTNPressed,
      required this.onGalleryBTNPressed,
      required this.name});

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding:
              const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
          margin: const EdgeInsets.only(top: 60),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.name,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Rajdhani'),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Please select any option',
                style: TextStyle(fontSize: 20, fontFamily: 'Poppins'),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 22,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // ElevatedButton(
                  //     onPressed: () {
                  //       Navigator.pop(context);
                  //       widget.onCameraBTNPressed();
                  //     },
                  //     child: const ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        widget.onCameraBTNPressed();
                      },
                      child: buttonContainer(context, 'Camera'),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        widget.onGalleryBTNPressed();
                      },
                      child: buttonContainer(context, 'Gallery'),
                    ),
                  ),
                  // ElevatedButton(
                  //     onPressed: () {
                  //       Navigator.pop(context);
                  //       widget.onGalleryBTNPressed();
                  //     },
                  //     child: const Text(
                  //       'Gallery',
                  //       style: TextStyle(
                  //           fontSize: 15,
                  //           color: Colors.white,
                  //           fontFamily: 'Poppins'),
                  //     )),
                ],
              ),
            ],
          ),
        ),
        // Positioned(
        //   left: 20,
        //   right: 20,
        //   child: CircleAvatar(
        //     backgroundColor: Colors.white,
        //     radius: 45,
        //     child: ClipRRect(
        //         borderRadius: const BorderRadius.all(Radius.circular(45)),
        //         child: Image.asset("assets/images/camera.svg")),
        //   ),
        // ),
      ],
    );
  }
}
