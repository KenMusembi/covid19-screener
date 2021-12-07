import 'package:covidscreener/views/dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(title: 'COVID SCREENER DASHBOARDr'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    String whiteColor = "#F9F9F9";
    String greenColor = "#00e04f";

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        backgroundColor: Colors.white,
        //drawer: AppDrawer(),

        body: Center(
          child: Card(
            child: Column(children: <Widget>[
              //Image(image: AssetImage('assets/images/covid19_scanner.png')),
              Image.asset('assets/images/codvid19_scanner.png'),
              Image.network('https://ibb.co/CKsssWH'),
              SizedBox(
                height: 50,
              ),
              Text('Covid-19 Screener',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              Text('Register and log patient symptoms'),
              Container(
                margin: EdgeInsets.all(25),
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  child: Text(
                    'Go To Dashboard',
                    style: TextStyle(fontSize: 14.0, color: Colors.white),
                  ),

                  //color: Colors.blueAccent,
                  //textColor: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Dashboard()),
                      // );
                    );
                  },
                ),
              ),
            ]),
          ),
        ));
  }
}
