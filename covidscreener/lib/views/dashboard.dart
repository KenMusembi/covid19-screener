import 'dart:convert';
import 'dart:async';
import 'package:covidscreener/models/symptomsClass.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../models/patientsClass.dart';

import 'package:http/http.dart' as http;

void main() {
  runApp(Dashboard());
}

class Dashboard extends StatefulWidget {
  //const Dashboard({ Key? key }) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future<List<Patients>> _patients;
  String searchString = "";

  final TextEditingController nameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController dobController = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  Patients _newpatient;

  String name, email, username, phone_number, password, dob;

  void initState() {
    // dobController.text = "";
    _patients = _patientsFunction(context);
    _registerPatient(
        name, email, username, phone_number, password, dob, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 70),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //row for cards
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Card(
                          child: Column(
                            children: [
                              Text('# of Patients registered'),
                              FutureBuilder<List<Patients>>(
                                  future: _patients,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      var patientNumber = snapshot.data.length;
                                      return Text(patientNumber.toString());
                                    } else if (snapshot.hasError) {
                                      return Text("${snapshot.error}");
                                    }

                                    // By default, show a loading spinner.

                                    return CircularProgressIndicator();
                                  }),
                            ],
                          ),
                        ),
                        Card(
                          child: Column(
                            children: [
                              Text('# of Patients positive'),
                              Text('data')
                            ],
                          ),
                        ),
                        Card(
                          child: Column(
                            children: [Text('% transmission'), Text('data')],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Patients Testing List'),
                    SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                      ),
                      child: Text(
                        'Register Patient',
                        style: TextStyle(fontSize: 14.0, color: Colors.white),
                      ),

                      //color: Colors.blueAccent,
                      //textColor: Colors.white,
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                elevation: 16,
                                child: Container(
                                    child: Column(
                                  children: [
                                    Text('Add New Patent'),
                                    Form(
                                        key: _formkey,
                                        child: Column(
                                          children: <Widget>[
                                            Text('Patient Name'),
                                            TextField(
                                              controller: nameController,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  hintText:
                                                      'Enter Patient Name'),
                                              onChanged: (newValue) =>
                                                  setState(() {
                                                name = newValue;
                                              }),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text('Patient Email'),
                                            TextField(
                                              controller: emailController,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  hintText:
                                                      'Enter Patient Email Address'),
                                              onChanged: (newValue) =>
                                                  setState(() {
                                                email = newValue;
                                              }),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text('Patient Username'),
                                            TextField(
                                              controller: usernameController,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  hintText:
                                                      'Enter Patient Username'),
                                              onChanged: (newValue) =>
                                                  setState(() {
                                                username = newValue;
                                              }),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text('Patient Phone number'),
                                            TextField(
                                              controller: phoneController,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  hintText:
                                                      'Enter Patient Phone Number'),
                                              onChanged: (newValue) =>
                                                  setState(() {
                                                phone_number = newValue;
                                              }),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text('Patient Password'),
                                            TextField(
                                              obscureText: true,
                                              enableSuggestions: false,
                                              autocorrect: false,
                                              controller: passwordController,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  hintText:
                                                      'Enter Patient Password'),
                                              onChanged: (newValue) =>
                                                  setState(() {
                                                password = newValue;
                                              }),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text('Patient Date Of Birth'),
                                            TextField(
                                              controller: dobController,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  hintText:
                                                      'Enter Patient Date of Birth'),
                                              //readOnly:
                                              // true, //set it true, so that user will not able to edit text
                                              onTap: () async {
                                                DateTime pickedDate =
                                                    await showDatePicker(
                                                        context: context,
                                                        initialDate:
                                                            DateTime.now(),
                                                        firstDate: DateTime(
                                                            2000), //DateTime.now() - not to allow to choose before today.
                                                        lastDate:
                                                            DateTime(2101));

                                                if (pickedDate != null) {
                                                  print(
                                                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                                  String formattedDate =
                                                      DateFormat('yyyy-MM-dd')
                                                          .format(pickedDate);
                                                  print(
                                                      formattedDate); //formatted date output using intl package =>  2021-03-16
                                                  //you can implement different kind of Date Format here according to your requirement

                                                  setState(() {
                                                    dobController.text =
                                                        formattedDate; //set output date to TextField value.
                                                  });
                                                } else {
                                                  print("Date is not selected");
                                                }
                                              },
                                              onChanged: (newValue) =>
                                                  setState(() {
                                                dob = newValue;
                                              }),
                                            ),
                                            SizedBox(height: 10.0),
                                            FloatingActionButton.extended(
                                              label: Text('Submit'),
                                              onPressed: () async {
                                                final name = nameController.text
                                                    .toString();
                                                final email =
                                                    emailController.text;
                                                final username =
                                                    usernameController.text;
                                                final phone_number =
                                                    phoneController.text;
                                                final password =
                                                    passwordController.text;
                                                final dob = dobController.text
                                                    .toString();
                                                final Patients patient =
                                                    await _registerPatient(
                                                        name,
                                                        email,
                                                        username,
                                                        phone_number,
                                                        password,
                                                        dob,
                                                        context);
                                                setState(() {
                                                  _newpatient = patient;
                                                });
                                              },
                                              tooltip: "Submit Follow Up Data",
                                              //icon: Icon(Icons.add)
                                            ),
                                            SizedBox(height: 10.0),
                                          ],
                                        )),
                                  ],
                                )),
                              );
                            });
                      },
                    ),
                    Flexible(
                      child: new FutureBuilder<List<Patients>>(
                          future: _patients,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<Patients> allPatients = snapshot.data;
                              return new ListView.builder(
                                  itemCount: allPatients.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return allPatients[index]
                                            .pName
                                            .contains(searchString)
                                        ? Card(
                                            child: Column(
                                              children: [
                                                ListTile(
                                                  enabled: true,
                                                  //  isThreeLine: true,
                                                  onTap: () {
                                                    //updateTime(
                                                    //     index, allPatients);
                                                  },

                                                  title: Text(allPatients[index]
                                                      .pName
                                                      .toString()),
                                                  subtitle: Text(
                                                      allPatients[index]
                                                          .pUsername
                                                          .toString()),
                                                  trailing: IconButton(
                                                    icon:
                                                        Icon(Icons.view_array),
                                                    onPressed: () {},
                                                  ),
                                                ),

                                                // ),
                                                // Text(resources[index].heading)
                                              ],
                                            ),
                                          )
                                        : Container();
                                  });
                            } else if (snapshot.hasError) {
                              return Text("${snapshot.error}");
                            }

                            // By default, show a loading spinner.

                            return CircularProgressIndicator();
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//future method to fetch patients registered
Future<List<Patients>> _patientsFunction(context) async {
  //parse the link in string with Uri

  try {
    var response = await http.get(
      Uri.http("localhost:5000", "/api/patients/listPatients"),
      headers: {
        "Access-Control-Allow-Origin": "*", // Required for CORS support to work
        "Access-Control-Allow-Credentials":
            'true', // Required for cookies, authorization headers with HTTPS
        "Access-Control-Allow-Headers":
            "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "POST, GET, HEAD, OPTIONS"
      },
    );
    print('Response status: ${response.statusCode}');

    print('Response body: ${response.body}');
    return List<Patients>.from(
        json.decode(response.body).map((x) => Patients.fromJson(x)));
  } catch (e) {
    print(e.toString());
  }
}

//method to post patients
Future<Patients> _registerPatient(String name, String email, String username,
    String phone_number, String password, String dob, context) async {
  //parse the link in string with Uri
  print(' email' + email.toString() + json.encode(username).toString());
  String dob = '1980-12-07';
  try {
    final response = await http.post(
        Uri.http("localhost:5000", "/api/patients/createPatient"),
        headers: {
          "Content-Type": "application/json; charset=utf-8",

          'Accept': '*/*',
          "Access-Control-Allow-Origin":
              "*", // Required for CORS support to work
          "Access-Control-Allow-Credentials":
              'true', // Required for cookies, authorization headers with HTTPS
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, GET, HEAD, OPTIONS"
        },
        body: json.encode({
          "p_name": name,
          "p_username": username,
          "p_email": email,
          "p_phone_number": phone_number,
          "p_password": password,
          "p_dob": "2021-12-06",
        }));
    print('Response status: ${response.statusCode}');

    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Successfully added a patient record.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER_RIGHT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Error saving record, kindly retry.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER_RIGHT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  } catch (e) {
    print(e.toString());
    Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER_RIGHT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

//method to post symptoms
_addSymptoms(pId, fever, cough, difficulty_breathing, chills, context) async {
  //parse the link in string with Uri
  try {
    var response = await http.post(
        Uri.http("localhost:5000", "/api/patients/createSymptom"),
        headers: {
          "Access-Control-Allow-Origin":
              "*", // Required for CORS support to work
          "Access-Control-Allow-Credentials":
              'true', // Required for cookies, authorization headers with HTTPS
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, GET, HEAD, OPTIONS"
        },
        body: {
          "pId": json.encode(pId),
          "fever": json.encode(fever),
          "cough": json.encode(cough),
          "difficultyBreathing": json.encode(difficulty_breathing),
          "chills": json.encode(chills),
        });
    print('Response status: ${response.statusCode}');

    print('Response body: ${response.body}');
    final symptoms = symptomsFromJson(response.body);

    // return symptoms;
  } catch (e) {
    print(e.toString());
  }
}
