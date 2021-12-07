import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  //const Dashboard({ Key? key }) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              //column for cards row and list
              child: Column(
                children: [
                  //row for cards
                  Row(
                    children: [
                      Card(
                        child: Column(
                          children: [
                            Text('# of Patients registered'),
                            Text('data')
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
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
