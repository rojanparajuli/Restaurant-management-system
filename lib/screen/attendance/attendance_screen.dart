import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/bloc/attendance/list/get_attendance_cubit.dart';
import 'package:resturant/bloc/attendance/list/get_attendance_state.dart';
import 'package:resturant/components/colors.dart';

class AttendanceListScreen extends StatefulWidget {
  const AttendanceListScreen({super.key});

  @override
  State<AttendanceListScreen> createState() => _AttendanceListScreenState();
}

class _AttendanceListScreenState extends State<AttendanceListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GetAttendanceCubit>().getAttendance();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Attendance',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<GetAttendanceCubit, GetAttendanceState>(
        builder: (context, state) {
          if (state is GetAttendanceLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetAttendanceLoaded) {
            if (state.attendance.isEmpty) {
              return const Center(
                child: Text('No attendance records available.'),
              );
            }
            return Stack(
              children: [
                Opacity(
                  opacity: 0.1,
                  child: Image.asset(
                    'assets/icons/Business.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                ListView.builder(
                  itemCount: state.attendance.length,
                  itemBuilder: (context, index) {
                    final attendance = state.attendance[index];
                    if (attendance.records == null ||
                        attendance.records!.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'No records found for this attendance.',
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    }

                    return Card(
                      color: Colors.transparent,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: attendance.records!.map((record) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'User ID: ${record.userId ?? "N/A"}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Check-In: ${record.checkInTime?.toIso8601String() ?? "N/A"}',
                                    ),
                                    Text(
                                      'Check-Out: ${record.checkOutTime?.toIso8601String() ?? "N/A"}',
                                    ),
                                    Text(
                                      'Location: Check-In: ${record.locationLatLong?.checkin ?? "N/A"}, '
                                      'Check-Out: ${record.locationLatLong?.checkout ?? "N/A"}',
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            );
          } else if (state is GetAttendanceError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else {
            return const Center(
              child: Text('Press the button to load attendance.'),
            );
          }
        },
      ),
    );
  }
}
