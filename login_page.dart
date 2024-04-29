import 'package:ama/employeePortal.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'employeePortal.dart';
import 'package:http/http.dart' as http;
class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController employeeidController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;
  bool showIdErrorMessage = false;
  bool showPasswordErrorMessage = false;
void signIn() async {
  int? employeeId = int.tryParse(employeeidController.text);
  bool isValidId = employeeId != null && employeeidController.text.isNotEmpty;
  bool isValidPassword =
      passwordController.text.isNotEmpty && int.tryParse(passwordController.text) != null;

  if (isValidId && isValidPassword) {
    final response = await http.post(
      Uri.parse('http://localhost:3000/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': employeeId,
        'password': int.parse(passwordController.text),
      }),
    );

    if (response.statusCode == 200) {
      // User authenticated successfully
     // Navigator.pushNamed(context, 'Aya');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EmployeePortalPage(employeeId: employeeId)),
      );
  
    } 
    else if (response.statusCode == 401) {
      // Authentication failed
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Authentication Error'),
          content: Text('Password is incorrect.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // Other errors
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Error'),
          content: Text('An error occurred during authentication.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  } else {
    setState(() {
      showIdErrorMessage = !isValidId;
      showPasswordErrorMessage = !isValidPassword;
    });
  }
  
}

  //void signIn() {
    //int? employeeId = int.tryParse(employeeidController.text);
    //bool isValidId = employeeId != null && employeeidController.text.isNotEmpty;
    //bool isValidPassword =
      //  passwordController.text.isNotEmpty && int.tryParse(passwordController.text) != null;

    //setState(() {
     // showIdErrorMessage = !isValidId;
      //showPasswordErrorMessage = !isValidPassword;
    //});
  //}

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.blue,
            Color.fromARGB(255, 240, 231, 231),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _icon(),
                  const SizedBox(height: 50),
                  _inputField("Employee ID", employeeidController),
                  if (showIdErrorMessage)
                    const Text(
                      'Please insert your ID as number.',
                      style: TextStyle(color: Colors.red),
                    ),
                  const SizedBox(height: 20),
                  _inputField("Password", passwordController, isPassword: true),
                  if (showPasswordErrorMessage)
                    const Text(
                      'Please insert your password as number.',
                      style: TextStyle(color: Colors.red),
                    ),
                  const SizedBox(height: 50),
                  _loginBtn(),
                  const SizedBox(height: 20),
                  _extraText(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _icon() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2),
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.person, color: Colors.white, size: 120),
    );
  }

  Widget _inputField(String hintText, TextEditingController controller,
      {bool isPassword = false}) {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: const BorderSide(color: Colors.white),
    );

    return TextField(
      keyboardType: isPassword ? TextInputType.number : TextInputType.text,
      style: const TextStyle(color: Colors.white),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white),
        enabledBorder: border,
        focusedBorder: border,
        prefixIcon: hintText == 'Employee ID'
            ? Icon(Icons.person, color: Colors.white)
            : hintText == 'Password'
                ? Icon(Icons.lock, color: Colors.white)
                : null,
        suffixIcon: isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
                icon: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white,
                ),
              )
            : null,
      ),
      obscureText: isPassword && !isPasswordVisible,
      onChanged: (value) {
        setState(() {
          showIdErrorMessage = false;
          showPasswordErrorMessage = false;
        });
      },
    );
  }

  Widget _loginBtn() {
    return ElevatedButton(
      onPressed: signIn,
      child: const SizedBox(
        width: double.infinity,
        child: Text(
          "Sign in",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      ),
      style: ElevatedButton.styleFrom(
        foregroundColor: const Color.fromRGBO(33, 150, 243, 1),
        shape: const StadiumBorder(),
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    );
  }

  Widget _extraText() {
    return const Text(
      "If you can't access your account, please contact the IT department.",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 16, color: Colors.white),
    );
  }
}
