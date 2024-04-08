import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'PortalEmployee.dart'; 

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
  bool showErrorMessage = false;
  String? employeeDocId; // To store the document ID of the employee

  Future<void> signIn() async {
    int? employeeId = int.tryParse(employeeidController.text);
    if (employeeId != null) {
      CollectionReference employees =
          FirebaseFirestore.instance.collection('employees');
      final querySnapshot =
          await employees.where('id', isEqualTo: employeeId).get();
      if (querySnapshot.docs.isEmpty) {
        setState(() {
          showErrorMessage = true;
        });
      } else {
        setState(() {
          showErrorMessage = false;
          employeeDocId = querySnapshot.docs.first.id; // Save document ID
        });

        final employeeData = querySnapshot.docs.first.data();
        final storedPassword = (employeeData as Map<String, dynamic>)['password'];

        final enteredPassword = int.tryParse(passwordController.text);

        if (storedPassword != null && storedPassword == enteredPassword) {
          // Password correct, navigate to PortalEmployy.dart
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PortalEmployeePage()),
          );
          return;
        } else {
          // Password incorrect
          setState(() {
            showPasswordErrorMessage = true;
          });
          return;
        }
      }
    }

    setState(() {
      if (employeeidController.text.isEmpty) {
        showIdErrorMessage = true;
      } else {
        showIdErrorMessage = false;
      }

      if (passwordController.text.isEmpty) {
        showPasswordErrorMessage = true;
      } else {
        showPasswordErrorMessage = false;
      }
    });
  }

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
                      'Please insert your ID.',
                      style: TextStyle(color: Colors.red),
                    ),
                  const SizedBox(height: 20),
                  if (showErrorMessage)
                    const Text(
                      'ID does not exist, try again!',
                      style: TextStyle(color: Colors.red),
                    ),
                  _inputField("Password", passwordController, isPassword: true),
                  if (showPasswordErrorMessage && !showErrorMessage) // Only show if ID exists
                    const Text(
                      'Password is not correct, retry!',
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
                  isPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
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
          showErrorMessage = false;
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
