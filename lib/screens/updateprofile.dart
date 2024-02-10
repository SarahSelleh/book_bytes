import 'dart:io';
import 'dart:convert';  // Import for jsonDecode
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../myconfig.dart';  // Import for http package

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({Key? key}) : super(key: key);
  
  get userdata => null;

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  File? _image; // Add this line to store the selected image file
  TextEditingController _pass1editingController = TextEditingController();  // Add this line

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Update Profile",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.pink,
        elevation: 0.0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey,
            height: 1.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section
            Container(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _image != null
                    ? FileImage(_image!) as ImageProvider<Object>
                    : AssetImage("assets/images/profilepic.png"),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildFormField("Name", Icons.person),
            _buildFormField("Email", Icons.email),
            _buildFormField("Phone Number", Icons.phone),
            _buildFormField("Password", Icons.lock),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton("Cancel", Colors.red, 20),
                _buildButton("Save", Colors.green, 20),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Widget _buildFormField(String label, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: label == "Password" ? _pass1editingController : null,
          obscureText: label == "Password",
          decoration: InputDecoration(
            prefixIcon: Icon(icon),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildButton(String text, Color color, double fontSize) {
    return ElevatedButton(
      onPressed: () {
        if (text == "Cancel") {
          Navigator.pop(context);
        } else {
          // Add functionality for the "Save" button
          _updateProfile();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 20),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 17,
        ),
      ),
    );
  }

  void _updateProfile() {

    http.post(
      Uri.parse("${MyConfig.server}/book_bytes/php/update_profile.php"),
      body: {
        "password": _pass1editingController.text,
        "userid": widget.userdata.userid
      }).then((response) {
        var data = jsonDecode(response.body);
        if (response.statusCode == 200 && data['status'] == 'success') {
          _showMessage("Password updated successfully");
        } else {
          _showMessage("Failed to update password");
        }
    });
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
