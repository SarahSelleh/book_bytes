import 'dart:convert';
import 'package:book_bytes/myconfig.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _phoneEditingController = TextEditingController();
  final TextEditingController _passEditingController = TextEditingController();
  final TextEditingController _pass2EditingController = TextEditingController();
  bool _isChecked = false;
  final _formKey = GlobalKey<FormState>();
  late double screenHeight, screenWidth, cardwitdh;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Registration"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: screenHeight * 0.35,
            width: screenWidth,
            child: Image.asset('assets/images/registration.png', fit: BoxFit.cover)
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 8,
            child: Container(
              margin: const EdgeInsets.all(16),
              child: Column(children: [
                Form(
                  key: _formKey,
                  child: Column(children: [
                    TextFormField(
                      controller: _nameEditingController,
                      validator: (val) => val!.isEmpty || (val.length < 5)
                        ? "Name must be longer than 5"
                        : null,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(),
                        icon: Icon(Icons.person),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        )
                      )
                    ),
                    
                    TextFormField(
                      controller: _phoneEditingController,
                      validator: (val) => val!.isEmpty || (val.length < 10)
                        ? "Phone number must be equal or longer than 10"
                        : null,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(),
                        icon: Icon(Icons.phone),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        )
                      )
                    ),
                    
                    TextFormField(
                      controller: _emailEditingController,
                      validator: (val) => val!.isEmpty || 
                        !val.contains("@") ||
                        !val.contains(".")
                        ? "Enter a valid email address"
                        : null,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(),
                        icon: Icon(Icons.email),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        )
                      )
                    ),
                    
                    TextFormField(
                      controller: _passEditingController,
                      validator: (val) => val!.isEmpty || (val.length < 5)
                        ? "Password must be longer than 5"
                        : null,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(),
                        icon: Icon(Icons.lock),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        )
                      )),
                    
                    TextFormField(
                      controller: _pass2EditingController,
                      validator: (val) => val!.isEmpty || (val.length < 5)
                        ? "Password must be longer than 5"
                        : null,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Re-enter password',
                        labelStyle: TextStyle(),
                        icon: Icon(Icons.lock),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        )
                      )
                    ),
        
                    const SizedBox(
                      height: 16,
                    ),
                    
                    Row(
                      children: [
                        Checkbox(
                          value: _isChecked, 
                          onChanged: (bool? value){
                            if (!_isChecked) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Terms have been read and accepted.")));
                              }
                            setState(() {
                              _isChecked = value!;
                            });
                          },
                        ),
        
                        GestureDetector(
                          onTap: null,
                          child: const Text('Agree with terms',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            )),
                        ),
        
                        const SizedBox(
                          width: 16,
                        ),
        
                        Expanded(
                          child: ElevatedButton(
                            onPressed: onRegisterDialog, 
                            child: const Text("Register")
                          )
                        )
                      ],
                    )
                ]),)
              ]),
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        GestureDetector(
            onTap: _goLogin,
            child: const Text(
              "Already Registered? Login",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
        ]),
      ),
    );
  }

  void onRegisterDialog() {
    if (!_formKey.currentState!.validate()){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Invalid input")));
      return;
    }
    if (!_isChecked) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please agree with terms and conditions")));
      return;
    }

    String passa = _passEditingController.text;
    String passb = _pass2EditingController.text;
    if (passa != passb) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Password and re-enter password does not match")));
      return;
    }

    showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))
          ),
          title: const Text(
            "Register new account",
            style: TextStyle(),
          ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                registerUser();
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

    void registerUser() {
      showDialog(
        context: context, 
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Text("Please Wait"),
            content: Text("Registration..."),
          );
        },
      );

      String name = _nameEditingController.text;
      String email = _emailEditingController.text;
      String phone = _phoneEditingController.text;
      String pass = _passEditingController.text;
    
    
      http.post(Uri.parse("${MyConfig().SERVER}/book_bytes/php/register_user.php"),
        body: {
          "name": name, 
          "phone": phone, 
          "email": email, 
          "password": pass,
        }).then((response) {
        //print(response.body);
        if (response.statusCode == 200) {
          var jsondata = jsonDecode(response.body);
          if (jsondata['status'] == 'success') {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Registration Success"))
            );
          }
          else{
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Registration Failed"))
            );
          }
          Navigator.pop(context);
        }else{
          ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Registration Failed")));
        Navigator.pop(context);
        }
      });
    }

    void _goLogin(){}
}
