import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({super.key});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.grey,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                width: double.infinity,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Row(
                  children: [
                    IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Resolved Complaints',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 16),
                        ),
                        Text(
                          'حل شدہ شکایات',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Card(
                        elevation: 0.5,
                        semanticContainer: true,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8),
                          margin: const EdgeInsets.only(left: 16, right: 16),
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              18,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '7',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    '9',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                                  ),
                                  Text(
                                    '2023',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    VerticalDivider(
                                      color: Color(0xFF757575),
                                      width: 2,
                                      thickness: 2,
                                      indent: 2,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Complaint ID :${'3456'}',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18),
                                          ),
                                          Text(
                                            'Status',
                                            style: TextStyle(
                                                color: Color(0xFF757575),
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16),
                                          ),
                                          Container(
                                            width: 80,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFCFD8DC),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'CLOSED',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 19),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Subject : ${'Mobile App DevelopmentMobile App '}',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            softWrap: true,
                                            style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              IconButton(
                                onPressed: null,
                                icon: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.blue,
                                  size: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: 10,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                ),
              ),
            ],
          ),
        ),
      );
  }
}

// import 'package:flutter/material.dart';
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];
//   List<DropdownButton<String>> dropdowns = [];
//   List<String> selectedItems = [];
//
//   @override
//   void initState() {
//     super.initState();
//     initializeDropdowns();
//   }
//
//   void initializeDropdowns() {
//     // Create and initialize DropdownButton widgets
//     for (int i = 0; i < 4; i++) {
//       dropdowns.add(buildDropdown(i));
//     }
//   }
//
//   DropdownButton<String> buildDropdown(int dropdownIndex) {
//     // Create a DropdownButton with items from the list, excluding selected items
//     List<DropdownMenuItem<String>> dropdownItems = items
//         .where((item) => !selectedItems.contains(item))
//         .map((item) => DropdownMenuItem<String>(
//               value: item,
//               child: Text(item),
//             ))
//         .toList();
//
//     return DropdownButton<String>(
//       hint: Text('Select an item'),
//       items: dropdownItems,
//       onChanged: (value) {
//         setState(() {
//           // Track selected items to prevent duplication
//           selectedItems.add(value!);
//         });
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Assign Items to Dropdowns'),
//       ),
//       body: Column(
//         children: dropdowns,
//       ),
//     );
//   }
// }
//
// import 'package:flutter/material.dart';
//
// class MyScreen extends StatefulWidget {
//   const MyScreen({super.key});
//
//   @override
//   _MyScreenState createState() => _MyScreenState();
// }
//
// class _MyScreenState extends State<MyScreen> {
//   List<String> listValues = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0.0,
//         backgroundColor: Color(0xFF6A1B9A),
//         centerTitle: true,
//         title: Text(
//           'Dynamic List',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20.0),
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 itemCount: listValues.length,
//                 itemBuilder: (context, index) {
//                   return Center(
//                     child: Card(
//                       shadowColor: Color(0xFFCE93D8),
//                       elevation: 3,
//                       margin: EdgeInsets.all(10),
//                       child: Padding(
//                         padding: EdgeInsets.all(12.0),
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: TextField(
//                                 decoration: InputDecoration(
//                                     border: InputBorder.none,
//                                     hintText: 'Enter Text',
//                                     hintStyle: TextStyle(
//                                         color: Color(0xFF6A1B9A),
//                                         overflow: TextOverflow.ellipsis)),
//                                 onChanged: (text) {
//                                   listValues[index] = text;
//                                 },
//                               ),
//                             ),
//                             IconButton(
//                               icon: Icon(
//                                 Icons.delete,
//                                 color: Color(0xFFCE93D8),
//                               ),
//                               onPressed: () {
//                                 setState(() {
//                                   listValues.removeAt(index);
//                                 });
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ElevatedButton(
//                   style: ButtonStyle(
//                     backgroundColor: MaterialStatePropertyAll(
//                       Color(0xFFBA68C8),
//                     ),
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       listValues.add('');
//                     });
//                   },
//                   child: Text('Add'),
//                 ),
//                 SizedBox(width: 16),
//                 ElevatedButton(
//                   style: ButtonStyle(
//                     backgroundColor: MaterialStatePropertyAll(
//                       Color(0xFFBA68C8),
//                     ),
//                   ),
//                   onPressed: () {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => DisplayScreen(listValues),
//                       ),
//                     );
//                   },
//                   child: Text('Save'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class DisplayScreen extends StatelessWidget {
//   final List<String> givenValues;
//
//   const DisplayScreen(this.givenValues, {super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0.0,
//         backgroundColor: Color(0xFF6A1B9A),
//         centerTitle: true,
//         title: Text(
//           'Values of List',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: ListView.builder(
//         itemCount: givenValues.length,
//         itemBuilder: (context, index) {
//           return Container(
//             width: double.infinity,
//             height: 50,
//             margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//             padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(40),
//                 border: Border.all(
//                   color: Color(0xFFAB47BC),
//                 )),
//             child: Center(
//                 child: Text(
//               'Value ${index + 1}: ${givenValues[index]}',
//               overflow: TextOverflow.ellipsis,
//             )),
//           );
//         },
//       ),
//     );
//   }
// }
