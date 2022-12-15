// // import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:leo_inspector/Model/company_model.dart';
// import 'package:leo_inspector/Model/inspector_model2.dart';
//
// // import '../theme/colors.dart';
//
// class QrDetailPage extends StatefulWidget {
//   List<Question> checkBoxForm;
//
//   QuestionOption? questionOption;
//
//   String? clientId;
//
//   String? companyId;
//
//   bool isToBeAuthorised;
//
//   Inspector? authorisedInspector;
//
//   Inspector? surveyInspector;
//
//    QrDetailPage({Key? key ,required this.checkBoxForm,required this.isToBeAuthorised}) : super(key: key);
//
//   @override
//   State<QrDetailPage> createState() => _QrDetailPageState(this.checkBoxForm, this.questionOption, this.clientId, this.companyId, this.isToBeAuthorised, this.authorisedInspector, this.surveyInspector);
// }
//
// class _QrDetailPageState extends State<QrDetailPage> {
//
//   late final List<Question> filledForm;
//   final List<Question> checkBoxForm;
//   final QuestionOption? questionOption;
//
//   final String? clientId;
//   final String? companyId;
//
//   final bool isToBeAuthorised;
//   final Inspector? authorisedInspector;
//   final Inspector? surveyInspector;
//
//   _QrDetailPageState(this.checkBoxForm, this.questionOption, this.clientId, this.companyId, this.isToBeAuthorised, this.authorisedInspector, this.surveyInspector);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: Colors.peacock_blue,
//       // backgroundColor: Colors.blue,
//       body: ListView(
//         children: [
//           Container(
//             // color: Colors.redAccent,
//             // height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width,
//             child: Column(
//               children: [
// // hedder //
//                 Row(
//                   children: [
//                     Container(
//                       height: MediaQuery.of(context).size.height * 0.14,
//                       width: MediaQuery.of(context).size.width,
//                       // color: Colors.blueGrey,
//                       child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Image.asset("assets/images/logo-leo.png"),
//                             Row(
//                               children: [
//                                 NeumorphicButton(
//                                   onPressed: () {},
//                                   style: const NeumorphicStyle(
//                                       shape: NeumorphicShape.convex,
//                                       boxShape: NeumorphicBoxShape.circle(),
//                                       depth: 2,
//                                       lightSource: LightSource.bottom,
//                                       disableDepth: false,
//                                       intensity: 6,
//                                       // shadowLightColor: Colours.white
//                                   ),
//                                   child: const Icon(Icons.home),
//                                 ),
//                               ],
//                             ),
//                           ]),
//                     )
//                   ],
//                 ),
// // hedder //
// // body //
//                 Container(
//                   // color: Colors.white54,
//                   child: Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Container(
//                           width: MediaQuery.of(context).size.width * 0.9,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15),
//                             // color: Colours.white,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey.withOpacity(0.3),
//                                 spreadRadius: 1,
//                                 blurRadius: 8,
//                                 offset: const Offset(
//                                     0, 1), // changes position of shadow
//                               ),
//                             ],
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
// // headding section //
//                                 Container(
//                                   height: 20,
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.9,
//                                   decoration: const BoxDecoration(
//                                       // color: Colors.blueGrey,
//                                       ),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: const [
//                                       Text(
//                                         'Equipment Number',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                       Text(
//                                         'T6/5871',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   height: 50,
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.9,
//                                   decoration: BoxDecoration(
//                                     color: Colors.blueGrey.withOpacity(0.5),
//                                   ),
//                                   child: const Center(
//                                     child: Text(
//                                       'WIRE ROPE SLING',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 20,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Container(
//                                   height: 20,
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.9,
//                                   decoration: const BoxDecoration(
//                                       // color: Colors.blueGrey,
//                                       ),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: const [
//                                       Text(
//                                         'Result',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                       Text(
//                                         'Certified and Color Coded',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   height: 20,
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.9,
//                                   decoration: const BoxDecoration(
//                                       // color: Colors.blueGrey,
//                                       ),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: const [
//                                       Text(
//                                         'Certificate Number',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                       Text(
//                                         'TR0822-790-R1',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   height: 20,
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.9,
//                                   decoration: const BoxDecoration(
//                                       // color: Colors.blueGrey,
//                                       ),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: const [
//                                       Text(
//                                         'Capacity',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                       Text(
//                                         '13.0t@0-45 Deg',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   height: 20,
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.9,
//                                   decoration: const BoxDecoration(
//                                       // color: Colors.blueGrey,
//                                       ),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: const [
//                                       Text(
//                                         'Make',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                       Text(
//                                         'TECHNICAL OILFIELD SUPPLIES',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   height: 20,
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.9,
//                                   decoration: const BoxDecoration(
//                                       // color: Colors.blueGrey,
//                                       ),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: const [
//                                       Text(
//                                         'CENTRE(TOSC)',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                       Text(
//                                         '',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   height: 20,
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.9,
//                                   decoration: const BoxDecoration(
//                                       // color: Colors.blueGrey,
//                                       ),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: const [
//                                       Text(
//                                         'Description',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                       Text(
//                                         '',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   // height: 300,
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.9,
//                                   decoration: const BoxDecoration(
//                                       // color: Colors.blueGrey,
//                                       ),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       const Text(
//                                         '',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                       Container(
//                                         width: MediaQuery.of(context).size.width * 0.45,
//                                         decoration: const BoxDecoration(
//                                             // color: Colors.blue,
//                                             ),
//                                         child: Column(
//                                           children: [
//                                             const SizedBox(
//                                               height: 5,
//                                             ),
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.spaceEvenly,
//                                               children: const [
//                                                 Text(
//                                                   'Description',
//                                                   style: TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 10,
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   'TR0822-790-R1',
//                                                   style: TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 10,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             const SizedBox(
//                                               height: 5,
//                                             ),
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.spaceEvenly,
//                                               children: const [
//                                                 Text(
//                                                   'Description',
//                                                   style: TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 10,
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   'TR0822-790-R1',
//                                                   style: TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 10,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             const SizedBox(
//                                               height: 5,
//                                             ),
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.spaceEvenly,
//                                               children: const [
//                                                 Text(
//                                                   'Description',
//                                                   style: TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 10,
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   'TR0822-790-R1',
//                                                   style: TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 10,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             const SizedBox(
//                                               height: 5,
//                                             ),
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.spaceEvenly,
//                                               children: const [
//                                                 Text(
//                                                   'Description',
//                                                   style: TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 10,
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   'TR0822-790-R1',
//                                                   style: TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 10,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             const SizedBox(
//                                               height: 5,
//                                             ),
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.spaceEvenly,
//                                               children: const [
//                                                 Text(
//                                                   'Description',
//                                                   style: TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 10,
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   'TR0822-790-R1',
//                                                   style: TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 10,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             const SizedBox(
//                                               height: 5,
//                                             ),
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.spaceEvenly,
//                                               children: const [
//                                                 Text(
//                                                   'Description',
//                                                   style: TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 10,
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   'TR0822-790-R1',
//                                                   style: TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 10,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             const SizedBox(
//                                               height: 5,
//                                             ),
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.spaceEvenly,
//                                               children: const [
//                                                 Text(
//                                                   'Description',
//                                                   style: TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 10,
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   'TR0822-790-R1',
//                                                   style: TextStyle(
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 10,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             const SizedBox(
//                                               height: 10,
//                                             ),
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.spaceEvenly,
//                                               children: [
//                                                 Container(
//                                                   width: MediaQuery.of(context).size.width * 0.45,
//                                                   // color: Colors.green,
//                                                   child: const Text(
//                                                     'Lorem ipsum dolor sit amet consectetur adipisicing elit. Nam iste dolor perspiciatis sed dicta voluptates quasi quae ipsa sequi soluta nesciunt, fugiat odit nisi totam earum repudiandae. Reiciendis, eligendi corporis?',
//                                                     style: TextStyle(
//                                                       fontWeight: FontWeight.bold,
//                                                       fontSize: 10,
//                                                     ),
//                                                     textAlign: TextAlign.center,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             const SizedBox(
//                                               height: 10,
//                                             ),
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.spaceEvenly,
//                                               children: [
//                                                 Container(
//                                                   width: MediaQuery.of(context).size.width * 0.45,
//                                                   // color: Colors.green,
//                                                   child: const Text(
//                                                     'Lorem ipsum dolor sit amet consectetur adipisicing elit.\n Nam iste dolor perspiciatis sed dicta voluptates\n quasi quae ipsa sequi soluta nesciunt,\n fugiat odit nisi totam earum \nrepudiandae. Reiciendis, eligendi corporis?',
//                                                     style: TextStyle(
//                                                       fontWeight: FontWeight.bold,
//                                                       fontSize: 10,
//                                                     ),
//                                                     textAlign: TextAlign.center,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             const SizedBox(
//                                               height: 5,
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   height: 20,
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.9,
//                                   decoration: const BoxDecoration(
//                                       // color: Colors.blueGrey,
//                                       ),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: const [
//                                       Text(
//                                         'Certificate Date',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                       Text(
//                                         '31-Aug-2022',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   height: 20,
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.9,
//                                   decoration: const BoxDecoration(
//                                       // color: Colors.blueGrey,
//                                       ),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: const [
//                                       Text(
//                                         'Validity',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                       Text(
//                                         '28-Feb-2023',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   height: 20,
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.9,
//                                   decoration: const BoxDecoration(
//                                       // color: Colors.blueGrey,
//                                       ),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: const [
//                                       Text(
//                                         'Date of Last proof Load',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                       Text(
//                                         'New',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   height: 20,
//                                   width:
//                                       MediaQuery.of(context).size.width * 0.9,
//                                   decoration: const BoxDecoration(
//                                       // color: Colors.blueGrey,
//                                       ),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: const [
//                                       Text(
//                                         'Date of Next proof Load',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                       Text(
//                                         'Not Applicable',
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
// // headding section //
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
// // body //
//                 Row(
//                   children: [
//                     Container(
//                       height: MediaQuery.of(context).size.height * 0.05,
//                       width: MediaQuery.of(context).size.width,
//                       // color: Colors.black,
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
