import 'package:flutter/material.dart';
import 'package:petcode_app/utils/style_constants.dart';

class EntryScreen extends StatefulWidget {
  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: StyleConstants.blue,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: width * 0.8,
                height: height * 0.2,
                child: Image.asset('assets/images/logoyellow.png', fit: BoxFit.cover,),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Image.asset('assets/images/dog1.png'),
                    ),
                    Positioned(
                      bottom: height * 0.3,
                      child: Container(
                        decoration: StyleConstants.roundYellowButtonDeco,
                        width: 220.0,
                        height: 60.0,
                        child: Center(
                          child: Text('Register'),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: height * 0.15,
                      child: Container(
                        decoration: StyleConstants.roundWhiteButtonDeco,
                        width: 220.0,
                        height: 60.0,
                        child: Center(
                          child: Text('Register'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
