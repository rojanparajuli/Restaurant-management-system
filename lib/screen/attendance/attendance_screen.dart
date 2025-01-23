import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resturant/bloc/attendance/get_attendance_cubit.dart';
import 'package:resturant/bloc/attendance/get_attendance_state.dart';
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
        title: const Text('Attendance' , style: TextStyle(color: Colors.white),),
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
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                ListView.builder(
                  itemCount: state.attendance.length,
                  itemBuilder: (context, index) {
                    final attendance = state.attendance[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: ListTile(
                        title: Text('User ID: ${attendance.userId}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Check-In: ${attendance.checkInTime}'),
                            Text('Check-Out: ${attendance.checkOutTime ?? "N/A"}'),
                            Text(
                              'Location: Check-In: ${attendance.locationLatLong?.checkin}, Check-Out: ${attendance.locationLatLong?.checkout}',
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          } else if (state is GetAttendanceError) {
            return Center(
              child: Text('Attendance Unavailable'),
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
