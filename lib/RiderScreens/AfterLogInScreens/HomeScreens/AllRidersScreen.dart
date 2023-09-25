import 'package:Deliver_Rider/Constants/Colors.dart';
import 'package:flutter/material.dart';

import '../../../Constants/back-arrow-with-container.dart';

class AllRidersScreen extends StatefulWidget {
  const AllRidersScreen({super.key});

  @override
  State<AllRidersScreen> createState() => _AllRidersScreenState();
}

class _AllRidersScreenState extends State<AllRidersScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leadingWidth: 70,
          leading: Padding(
            padding: const EdgeInsets.only(top: 50.0, left: 20),
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: backArrowWithContainer(context),
            ),
          ),
        ),
      ),
    );
  }
}
