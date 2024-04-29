import 'package:flutter/material.dart';
import 'login.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  final int employeeId;

  ProfilePage({required this.employeeId});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = '';
  String function = '';

  @override
  void initState() {
    super.initState();
    fetchEmployeeDetails();
  }

  void fetchEmployeeDetails() async {
  try {
    final response = await http.get(Uri.parse('http://localhost:3000/employees'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> employees = data['data'];
      
      // Find the employee with the provided employeeId
      final employee = employees.firstWhere((emp) => emp['EmployeeID'] == widget.employeeId, orElse: () => null);

      if (employee != null) {
        setState(() {
          name = employee['Name'];
          function = employee['Functio'];
        });
      } else {
        // Handle case when employee is not found
        print('Employee not found');
      }
    } else {
      // Handle error
      print('Error: ${response.statusCode}');
    }
  } catch (e) {
    // Handle exception
    print('Exception: $e');
  }
}


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
              width: 300,
              height: 300,
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'My Profile :',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildProfileInfo(context, 'Name', name),
                  _buildProfileInfo(context, 'Function', function),
                  _buildProfileInfo(context, 'Employee ID', widget.employeeId.toString()),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      'Sign Out',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileInfo(BuildContext context, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 10),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
