import 'package:attendance_management_app/Profile.dart';
import 'package:flutter/material.dart';
//import 'profile.dart'; // Assuming profile.dart contains the ProfilePage widget

class PortalEmployeePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Attendance Management App ',
            style: TextStyle(
              color: const Color.fromARGB(255, 46, 140, 217),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Color.fromRGBO(255, 255, 255, 0.905),
          centerTitle: true,
        ),
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ProfilePage()), // Navigate to ProfilePage
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
                            _buildIconButton(Icons.fingerprint, 'Mark Attendance'),
                            SizedBox(width: 20),
                            _buildIconButton(Icons.list, 'Attendance Details'),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildIconButton(Icons.watch_later_outlined, 'Late Attendance'),
                            SizedBox(width: 20),
                            _buildIconButton(Icons.watch_later_outlined, 'Overtime Attendance'),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildIconButton(Icons.calendar_today, 'Public Holiday Calendar'),
                            SizedBox(width: 20),
                            _buildIconButton(Icons.attach_money, 'Salary Slips'),
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

  Widget _buildIconButton(IconData icon, String label) {
    return SizedBox(
      width: 250,
      height: 80,
      child: ElevatedButton.icon(
        onPressed: () {},
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
