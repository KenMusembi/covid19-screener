import 'dart:convert';
import 'dart:async';
import 'package:covidscreener/models/symptomsClass.dart';
import 'package:covidscreener/views/AddSymptom.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../models/patientsClass.dart';

import 'package:http/http.dart' as http;

void main() {
  runApp(Dashboard());
}

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  //initialize objects to be used
  Future<List<Patients>> _patients;
  Future<List<Symptoms>> _symptoms;
  String searchString = "";

  //initializing textediting controllers for our form
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController dobController = new TextEditingController();

//initializing form key for our form
  final _formkey = GlobalKey<FormState>();

//patients and symptoms class objects to be used to store new objets from API
  Patients _newpatient;
  Symptoms _newsymptoms;

//initializing form inputs
  String name, email, username, phone_number, password, dob;

  void initState() {
    _patients = _patientsFunction(context);
    _symptoms = _symptomsFunction(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 70),
          child: Column(
            children: <Widget>[
              //row for cards on top
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //card for total patients registered
                        Card(
                          color: Colors.blue,
                          child: Padding(
                            padding: const EdgeInsets.all(28.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '# of Patients Registered',
                                  style: TextStyle(color: Colors.white),
                                ),
                                FutureBuilder<List<Patients>>(
                                    future: _patients,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        var patientNumber =
                                            snapshot.data.length;

                                        return Text(
                                          patientNumber.toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Text("${snapshot.error}");
                                      }

                                      // By default, show a loading spinner.

                                      return CircularProgressIndicator();
                                    }),
                              ],
                            ),
                          ),
                        ),
                        //card for total patients with symptoms
                        Card(
                          color: Colors.blue,
                          child: Padding(
                            padding: const EdgeInsets.all(28.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '# of Symptomatic Patients',
                                  style: TextStyle(color: Colors.white),
                                ),
                                FutureBuilder<List<Symptoms>>(
                                    future: _symptoms,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        var positiveNumber =
                                            snapshot.data.length;

                                        return Text(
                                          positiveNumber.toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Text("${snapshot.error}");
                                      }

                                      // By default, show a loading spinner.

                                      return CircularProgressIndicator();
                                    }),
                              ],
                            ),
                          ),
                        ),
                        /*
                        Data timeframe, this is ti say the data is lifetime and
                         not filtered according to any time frame
                         */
                        Card(
                          color: Colors.blue,
                          child: Padding(
                            padding: const EdgeInsets.all(28.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Data Timeframe',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  'Lifetime',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    //this queueu will use FIFO, unlesss age is greater than 59
                    Text(
                      'Patients Testing Queue',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                        ),
                        child: Text(
                          ' Register Patient ',
                          style: TextStyle(fontSize: 16.0, color: Colors.white),
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
                                      child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Column(
                                      children: [
                                        Text('Add New Patent'),
                                        SizedBox(height: 10),
                                        Form(
                                            key: _formkey,
                                            child: Column(
                                              children: <Widget>[
                                                Text('Patient Name'),
                                                SizedBox(
                                                  height: 7,
                                                ),
                                                TextField(
                                                  controller: nameController,
                                                  decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      hintText:
                                                          'Enter Patient Name'),
                                                  onChanged: (newValue) =>
                                                      setState(() {
                                                    name = newValue;
                                                  }),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text('Patient Email'),
                                                SizedBox(
                                                  height: 7,
                                                ),
                                                TextField(
                                                  controller: emailController,
                                                  decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      hintText:
                                                          'Enter Patient Email Address'),
                                                  onChanged: (newValue) =>
                                                      setState(() {
                                                    email = newValue;
                                                  }),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text('Patient Username'),
                                                SizedBox(
                                                  height: 7,
                                                ),
                                                TextField(
                                                  controller:
                                                      usernameController,
                                                  decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      hintText:
                                                          'Enter Patient Username'),
                                                  onChanged: (newValue) =>
                                                      setState(() {
                                                    username = newValue;
                                                  }),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text('Patient Phone number'),
                                                SizedBox(
                                                  height: 7,
                                                ),
                                                TextField(
                                                  controller: phoneController,
                                                  decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      hintText:
                                                          'Enter Patient Phone Number'),
                                                  onChanged: (newValue) =>
                                                      setState(() {
                                                    phone_number = newValue;
                                                  }),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text('Patient Password'),
                                                SizedBox(
                                                  height: 7,
                                                ),
                                                TextField(
                                                  obscureText: true,
                                                  enableSuggestions: false,
                                                  autocorrect: false,
                                                  controller:
                                                      passwordController,
                                                  decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      hintText:
                                                          'Enter Patient Password'),
                                                  onChanged: (newValue) =>
                                                      setState(() {
                                                    password = newValue;
                                                  }),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text('Patient Date Of Birth'),
                                                SizedBox(
                                                  height: 7,
                                                ),
                                                TextField(
                                                  controller: dobController,
                                                  decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
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
                                                          DateFormat(
                                                                  'yyyy-MM-dd')
                                                              .format(
                                                                  pickedDate);
                                                      print(
                                                          formattedDate); //formatted date output using intl package =>  2021-03-16
                                                      //you can implement different kind of Date Format here according to your requirement

                                                      setState(() {
                                                        dobController.text =
                                                            formattedDate; //set output date to TextField value.
                                                      });
                                                    } else {
                                                      print(
                                                          "Date is not selected");
                                                    }
                                                  },
                                                  onChanged: (newValue) =>
                                                      setState(() {
                                                    dob = newValue;
                                                  }),
                                                ),
                                                SizedBox(height: 20.0),
                                                FloatingActionButton.extended(
                                                  label: Text('Submit'),
                                                  onPressed: () async {
                                                    final name = nameController
                                                        .text
                                                        .toString();
                                                    final email =
                                                        emailController.text;
                                                    final username =
                                                        usernameController.text;
                                                    final phone_number =
                                                        phoneController.text;
                                                    final password =
                                                        passwordController.text;
                                                    final dob = dobController
                                                        .text
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
                                                  tooltip:
                                                      "Submit Follow Up Data",
                                                  //icon: Icon(Icons.add)
                                                ),
                                                SizedBox(height: 10.0),
                                              ],
                                            )),
                                      ],
                                    ),
                                  )),
                                );
                              });
                        },
                      ),
                    ),
                    Text('Tap on a user to see their sympomts'),
                    Flexible(
                      //Future builder for the patients list
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
                                                    (_seeSymptoms(
                                                        allPatients[index].id,
                                                        context));
                                                  },
                                                  title: Text(allPatients[index]
                                                      .pName
                                                      .toString()),
                                                  subtitle: Row(
                                                    children: [
                                                      Text(allPatients[index]
                                                              .pUsername
                                                              .toString() +
                                                          '\t'),
                                                      Text(allPatients[index]
                                                          .pEmail
                                                          .toString()),
                                                    ],
                                                  ),
                                                ),
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
Future<List<Symptoms>> _seeSymptoms(index, BuildContext context) async {
  //parse the link in string with Uri
  var id = index.toString();
  print(id);
  try {
    final String _baseUrl = 'localhost:5000';
    final String _charactersPath = '/api/patients';
    final Map<String, dynamic> _queryparameters = <String, dynamic>{
      'p_id': index.toString(),
    };
    var response = await http.get(
      Uri.http(_baseUrl, _charactersPath, _queryparameters),
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

    print('Response body: ${response.body.length}');
    //easy way to check users without any symptoms
    if (response.body.length == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddSymptom(
                  id: index,
                )),
      );
      Fluttertoast.showToast(
          msg: 'No symptoms added for this user.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER_RIGHT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: response.body,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER_RIGHT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }
//return Symptoms object f
    return List<Symptoms>.from(
        json.decode(response.body).map((x) => Symptoms.fromJson(x)));
  } catch (e) {
    print(e.toString());
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

//future method to fetch symptoms data
Future<List<Symptoms>> _symptomsFunction(context) async {
  //parse the link in string with Uri

  try {
    var response = await http.get(
      Uri.http("localhost:5000", "/api/patients/listSymptoms"),
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
    return List<Symptoms>.from(
        json.decode(response.body).map((x) => Symptoms.fromJson(x)));
  } catch (e) {
    print(e.toString());
  }
}

//method to post patients
Future<Patients> _registerPatient(String name, String email, String username,
    String phone_number, String password, String dob, context) async {
  //parse the link in string with Uri
  print(' email' + email.toString() + json.encode(username).toString());
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
    //print to inspect response from server
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
