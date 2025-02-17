// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:location/location.dart';
// // import 'package:resturant/bloc/attendance/checkin_out/checkin_bloc.dart';
// // import 'package:resturant/bloc/attendance/checkin_out/checkinout_state.dart';
// import 'package:resturant/bloc/attendance/list/get_attendance_cubit.dart';
// import 'package:resturant/bloc/attendance/list/get_attendance_state.dart';
// import 'package:resturant/bloc/attendance/status/attendance_status_cubit.dart';
// // import 'package:resturant/bloc/attendance/status/attendance_status_state.dart';
// import 'package:resturant/components/colors.dart';
// // import 'package:resturant/models/attendance/checkin_checkout/checkin/check_in_out_model.dart';
// // import '../../bloc/attendance/checkin_out/checkinout_event.dart';

// class DashBoard extends StatefulWidget {
//   const DashBoard({super.key});

//   @override
//   State<DashBoard> createState() => _DashBoardState();
// }

// class _DashBoardState extends State<DashBoard> {
//   LocationData? _currentPosition;
//   final Location _location = Location();

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<GetAttendanceCubit>().getAttendance();
//       context.read<AttendanceStatusCubit>().getAttendanceStatus();
//     });
//   }

//   Future<void> _getCurrentLocation() async {
//     try {
//       bool serviceEnabled = await _location.serviceEnabled();
//       if (!serviceEnabled) {
//         serviceEnabled = await _location.requestService();
//         if (!serviceEnabled) {
//           throw Exception('Location services are disabled.');
//         }
//       }

//       PermissionStatus permissionGranted = await _location.hasPermission();
//       if (permissionGranted == PermissionStatus.denied) {
//         permissionGranted = await _location.requestPermission();
//         if (permissionGranted != PermissionStatus.granted) {
//           throw Exception('Location permissions are denied.');
//         }
//       }

//       final locationData = await _location.getLocation();
//       setState(() {
//         _currentPosition = locationData;
//       });
//     } catch (e) {
//       // ignore: use_build_context_synchronously
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error fetching location: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final isMobile = constraints.maxWidth < 600;
//         final isDesktop = constraints.maxWidth >= 1024;

//         return Scaffold(
//           appBar: AppBar(
//             title: const Text('DashBoard', style: TextStyle(color: Colors.white)),
//             backgroundColor: AppColor.primaryColor,
//             centerTitle: true,
//             automaticallyImplyLeading: false,
//           ),
//           body: Stack(
//             children: [
//               Opacity(
//                 opacity: 0.1,
//                 child: Image.asset(
//                   'assets/icons/Business.png',
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   children: [
//                     BlocBuilder<GetAttendanceCubit, GetAttendanceState>(
//                       builder: (context, state) {
//                         if (state is GetAttendanceLoading) {
//                           return const CircularProgressIndicator();
//                         } else if (state is GetAttendanceLoaded) {
//                           return Row(
//                             mainAxisAlignment: isDesktop
//                                 ? MainAxisAlignment.start
//                                 : MainAxisAlignment.center,
//                             children: [
//                               AttendanceSummaryCard(
//                                 attendanceCount: state.attendance.length,
//                                 isMobile: isMobile,
//                               ),
//                               const SizedBox(width: 16),
//                               // BlocBuilder<AttendanceStatusCubit, AttendanceStatusState>(
//                               //   builder: (context, state) {
//                               //     if (state is AttendanceStatusLoaded) {
//                               //       return AttendanceActionButton(
//                               //         attendanceStatus: state.attendanceStatus?.data ?? '',
//                               //         getCurrentLocation: _getCurrentLocation,
//                               //         currentPosition: _currentPosition,
//                               //         isMobile: isMobile,
//                               //       );
//                               //     }
//                               //     return const SizedBox();
//                               //   },
//                               // ),
//                             ],
//                           );
//                         } else if (state is GetAttendanceError) {
//                           return Text(
//                             state.message,
//                             style: const TextStyle(color: Colors.red),
//                           );
//                         } else {
//                           return const Text('No data available.');
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// class AttendanceSummaryCard extends StatelessWidget {
//   final int attendanceCount;
//   final bool isMobile;

//   const AttendanceSummaryCard({
//     super.key,
//     required this.attendanceCount,
//     required this.isMobile,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             // ignore: deprecated_member_use
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 8,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const Text(
//             'Attendance',
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Total: $attendanceCount',
//             style: TextStyle(fontSize: isMobile ? 16 : 18, color: Colors.black87),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // class AttendanceActionButton extends StatelessWidget {
// //   final String attendanceStatus;
// //   final Future<void> Function() getCurrentLocation;
// //   final LocationData? currentPosition;
// //   final bool isMobile;

// //   const AttendanceActionButton({
// //     super.key,
// //     required this.attendanceStatus,
// //     required this.getCurrentLocation,
// //     required this.currentPosition,
// //     required this.isMobile,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     if (attendanceStatus == 'not_checked_in') {
// //       return BlocListener<CheckInBloc, CheckInState>(
// //         listener: (context, state) {
// //           print('CheckInBloc state: $state');
// //           if (state is CheckInSuccess) {
// //             context.read<AttendanceStatusCubit>().getAttendanceStatus();
// //           }
// //         },
// //         child: ElevatedButton(
// //           onPressed: () async {
// //             await getCurrentLocation();
// //             if (currentPosition != null) {
// //               // ignore: use_build_context_synchronously
// //               context.read<CheckInBloc>().add(
// //                     CheckInRequested(
// //                       CheckInRequestModel(
// //                         locationLatLong: LocationLatLong(
// //                           checkin: '${currentPosition!.latitude}',
// //                           checkout: '',
// //                         ),
// //                       ),
// //                     ),
// //                   );
// //             }
// //           },
// //           child: const Text('Check-in'),
// //         ),
// //       );
// //     } else if (attendanceStatus == 'checked_in') {
// //       return ElevatedButton(
// //         onPressed: () async {
// //           await getCurrentLocation();
// //           if (currentPosition != null) {
// //             context.read<CheckInBloc>().add(
// //                   CheckInRequested(
// //                     CheckInRequestModel(
// //                       locationLatLong: LocationLatLong(
// //                         checkin: '',
// //                         checkout: '${currentPosition!.latitude}',
// //                       ),
// //                     ),
// //                   ),
// //                 );
// //           }
// //         },
// //         child: const Text('Check-out'),
// //       );
// //     } else if (attendanceStatus == 'checked_out') {
// //       return const Text(
// //         'You have already checked out.',
// //         style: TextStyle(color: Colors.green),
// //       );
// //     }
// //     return const SizedBox();
// //   }
// // }

import 'package:flutter/material.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('DashBoard'),
      ),
    );
  }
}