import 'package:flutter/material.dart';
import 'SalarySlipsPage.dart';
import 'HolidayCalendarPage.dart';
import 'OvertimeAttendancePage.dart';
import 'LateAttendancePage.dart';
import 'AttendanceDetailsPage.dart';
import 'AttendancePage.dart';
import 'ProfilePage.dart';
class PortalEmployeePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    const Color.fromARGB(255, 83, 171, 243),
                    Color.fromARGB(255, 240, 231, 231),
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                width: 600,
                height: 450,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 0.905),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 60,
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              'Employee Portal',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 46, 140, 217),
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: IconButton(
                              icon: Icon(Icons.person, color: Colors.blue),
                              onPressed: () {
                                // Navigate to ProfilePage
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ProfilePage()),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildIconButton(
                              context,
                              Icons.fingerprint,
                              'Mark Attendance',
                              AttendancePage(),
                            ),
                            SizedBox(width: 20),
                            _buildIconButton(
                              context,
                              Icons.list,
                              'Attendance Details',
                              AttendanceDetailsPage(),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildIconButton(
                              context,
                              Icons.watch_later_outlined,
                              'Late Attendance',
                              LateAttendancePage(),
                            ),
                            SizedBox(width: 20),
                            _buildIconButton(
                              context,
                              Icons.watch_later_outlined,
                              'Overtime Attendance',
                              OvertimeAttendancePage(),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildIconButton(
                              context,
                              Icons.calendar_today,
                              'Public Holiday Calendar',
                              HolidayCalendarPage(),
                            ),
                            SizedBox(width: 20),
                            _buildIconButton(
                              context,
                              Icons.attach_money,
                              'Salary Slips',
                              SalarySlipsPage(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(BuildContext context, IconData icon, String label, Widget page) {
    return SizedBox(
      width: 250,
      height: 80,
      child: ElevatedButton.icon(
        onPressed: () {
          // Navigate to respective page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        icon: Icon(icon, size: 32),
        label: Flexible(
          child: Text(
            label,
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          shadowColor: Colors.grey,
          elevation: 5,
        ),
      ),
    );
  }
}

// Define other pages here













