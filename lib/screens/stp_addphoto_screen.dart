import 'package:flutter/material.dart';
import 'package:petcode_app/screens/stp_connecttag_screen.dart';
import 'package:petcode_app/utils/style_constants.dart';

class StpAddPhotoScreen extends StatefulWidget {
  @override
  _StpAddPhotoScreenState createState() => _StpAddPhotoScreenState();
}

class _StpAddPhotoScreenState extends State<StpAddPhotoScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: StyleConstants.blue,
      body: SingleChildScrollView(
        child: Container(
          width: width,
          height: height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.05,
              ),
              Container(
                height: 70.0,
                width: 200.0,
                child: Image.asset(
                  'assets/images/logoyellow.png',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Text(
                'Step 3: Pet Image',
                style: StyleConstants.whiteTitleText,
              ),
              SizedBox(
                height: height * 0.06,
              ),
              Container(
                height: height * 0.4,
                width: height * 0.4,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Icon(
                    Icons.photo_camera,
                    size: 100.0,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.15,
              ),
              GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => StpConnectTagScreen())),
                child: Container(
                  height: 55.0,
                  width: 250.0,
                  decoration: StyleConstants.roundYellowButtonDeco,
                  child: Center(
                    child: Text(
                      'Next Step',
                      style: StyleConstants.whiteButtonText,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}