import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/bloc/attendance/checkin_out/checkin_bloc.dart';
import 'package:resturant/bloc/attendance/list/get_attendance_cubit.dart';
import 'package:resturant/bloc/attendance/list/get_attendance_state.dart';
import 'package:resturant/bloc/attendance/status/attendance_status_cubit.dart';
import 'package:resturant/bloc/attendance/status/attendance_status_state.dart';
import 'package:resturant/components/colors.dart';
import 'package:resturant/models/attendance/checkin_checkout/checkin/check_in_out_model.dart';

import '../../bloc/attendance/checkin_out/checkinout_event.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GetAttendanceCubit>().getAttendance();
      context.read<AttendanceStatusCubit>().getAttendanceStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DashBoard', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColor.primaryColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.1,
            child: Image.asset(
              'assets/icons/Business.png',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BlocBuilder<GetAttendanceCubit, GetAttendanceState>(
                builder: (context, state) {
                  if (state is GetAttendanceLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is GetAttendanceLoaded) {
                    return Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  // ignore: deprecated_member_use
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Attendance',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Total : ${state.attendance.length}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        BlocBuilder<AttendanceStatusCubit,
                            AttendanceStatusState>(
                          builder: (context, state) {
                            if (state is AttendanceStatusLoaded) {
                              return Row(
                                children: [
                                  Visibility(
                                    visible: state.attendanceStatus!.data ==
                                        'not_checked_in',
                                    child: ElevatedButton(
                                        onPressed: () {
                                          context
                                              .read<CheckInBloc>()
                                              .add(CheckInRequested(CheckInRequestModel(
                                                locationLatLong: LocationLatLong(
                                                  checkin: '27.708065',
                                                  checkout: '85.337097',
                                                ),
                                              )));
                                        },
                                        child: Text('Check-in')),
                                  ),
                                  const SizedBox(width: 8),
                                  Visibility(
                                    visible: state.attendanceStatus!.data ==
                                        'checked_in',
                                    child: ElevatedButton(
                                        onPressed: () {},
                                        child: Text('Check-out')),
                                  ),
                                ],
                              );
                            }
                            return SizedBox();
                          },
                        ),
                      ],
                    );
                  } else if (state is GetAttendanceError) {
                    return Text(
                      state.message,
                      style: const TextStyle(color: Colors.red),
                    );
                  } else {
                    return const Text('No data available.');
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
