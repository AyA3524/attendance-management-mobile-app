import 'package:flutter/material.dart';

class OvertimeAttendancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
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
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'My Overtime Attendance :',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildAttendanceTable(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceTable() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Table(
        border: TableBorder.all(color: Colors.black),
        children: [
          TableRow(
            children: [
              TableCell(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Day',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Time',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Status',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          // Example rows, replace with actual attendance data
          _buildAttendanceRow('Monday', '9:00 AM', 'Overtime'),
          _buildAttendanceRow('Tuesday', '8:45 AM', 'Overtime '),
        
          _buildAttendanceRow('Friday', '9:00 AM', 'Overtime '),
         
         
          // Add more rows as needed
        ],
      ),
    );
  }

  TableRow _buildAttendanceRow(String day, String time, String status) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(day),
          ),
        ),
        TableCell(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(time),
          ),
        ),
        TableCell(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(status),
          ),
        ),
      ],
    );
  }
}

