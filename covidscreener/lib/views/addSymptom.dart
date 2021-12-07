import 'dart:convert';
import 'package:covidscreener/models/symptomsClass.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(AddSymptom());
}

class AddSymptom extends StatefulWidget {
  //this id is the value from dashboard after user clicks on add symptom
  final dynamic id;

  const AddSymptom({Key key, this.id}) : super(key: key);

  @override
  _AddSymptomState createState() => _AddSymptomState();
}

class _AddSymptomState extends State<AddSymptom> {
  //initialize Future for Symptoms class
  Future<List<Symptoms>> _symptoms;

//initializing form editing inputs for filling in symptom data
  final TextEditingController feverController = new TextEditingController();
  final TextEditingController coughController = new TextEditingController();
  final TextEditingController difficulty_breathingController =
      new TextEditingController();
  final TextEditingController chillsController = new TextEditingController();
  final TextEditingController p_idController = new TextEditingController();

//initializing a key for the form and other parameters
  final _formkey = GlobalKey<FormState>();
  Symptoms _newsymptoms;

  String fever, cough, difficulty_breathing, chills, p_id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Column(
          children: [
            Flexible(
              //here we start building our form
              child: Form(
                  key: _formkey,
                  child: Padding(
                    padding: const EdgeInsets.all(38.0),
                    child: Column(
                      children: [
                        Text('Fever'),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: feverController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'feeling feeverish?'),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text('Cough'),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: coughController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'having a cough?'),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text('Difficulty Breathing'),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: difficulty_breathingController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'feeling feeverish?'),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text('chills'),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: chillsController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'having chills?'),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FloatingActionButton.extended(
                          label: Text('Submit'),
                          /*
                          on presssed, the button will passed the entered data as the new parameters
                          for our values, we pick the p_id automatically from the other screen
                          */
                          onPressed: () async {
                            final fever = feverController.text.toString();
                            final cough = coughController.text;
                            final difficulty_breathing =
                                difficulty_breathingController.text;
                            final chills = chillsController.text;
                            final p_id = widget.id;
                            final Symptoms symptom = await _addSymptom(
                                fever,
                                cough,
                                difficulty_breathing,
                                chills,
                                p_id,
                                context);
                            //we use setState to update the value of _newsymtpoms
                            setState(() {
                              _newsymptoms = symptom;
                            });
                          },
                          tooltip: "Submit Follow Up Data",
                          //icon: Icon(Icons.add)
                        ),
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

//function for adding symptoms, it returns a Future<Symptoms> object as per our class
Future<Symptoms> _addSymptom(
    String fever,
    String cough,
    String difficulty_breathing,
    String chills,
    p_id,
    BuildContext context) async {
  try {
    var response = await http.post(
        Uri.http("localhost:5000", "/api/patients/createSymptom"),
        headers: {
          //required headers for using flutter web on chrome
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
          "p_id": p_id,
          "fever": fever,
          "cough": cough,
          "difficulty_breathing": difficulty_breathing,
          "chills": chills,
        }));

    //we can use print to see the data coming in
    print('Response status: ${response.statusCode}');

    print('Response body: ${response.body}');

    // return symptoms;
  } catch (e) {
    //we showcase the error if any
    Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER_RIGHT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    print(e.toString());
  }
}
