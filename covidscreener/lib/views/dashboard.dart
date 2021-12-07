import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';

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

  final TextEditingController editingController = new TextEditingController();

  void initState() {
    _patients = _patientsFunction(context);

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
                    //ListView(),

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
                                                    icon: Icon(Icons.add),
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
  var url = 'http://41.220.229.138:5000/api/patients/listPatients';
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
