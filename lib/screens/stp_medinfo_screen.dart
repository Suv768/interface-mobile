import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petcode_app/screens/stp_vaccinehist_screen.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/models/Pet.dart';

class StpMedicalInfoScreen extends StatefulWidget {
  StpMedicalInfoScreen({Key key, this.pet, this.petImage}) : super(key: key);

  final Pet pet;
  final File petImage;

  @override
  _StpMedicalInfoScreenState createState() => _StpMedicalInfoScreenState();
}

class _StpMedicalInfoScreenState extends State<StpMedicalInfoScreen> {
  TextEditingController _petAllergiesInputController;
  TextEditingController _specialNeedsInputController;
  TextEditingController _vetNameInputController;
  TextEditingController _vetPhoneNumberInputController;

  @override
  void initState() {
    _petAllergiesInputController = new TextEditingController();
    _specialNeedsInputController = new TextEditingController();
    _vetNameInputController = new TextEditingController();
    _vetPhoneNumberInputController = new TextEditingController();

    super.initState();
  }

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
                'Step 6: Medical Information',
                style: StyleConstants.whiteTitleText,
              ),
              SizedBox(
                height: height * 0.06,
              ),
              Container(
                //height: 300.0,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10.0,
                              offset: Offset(0, 2),
                            ),
                          ]),
                      height: 50.0,
                      width: 250.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Center(
                          child: TextFormField(
                            controller: _petAllergiesInputController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Pet Allergies',
                                hintStyle: TextStyle(fontSize: 15.0)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      height: 50.0,
                      width: 250.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Center(
                          child: TextFormField(
                            controller: _specialNeedsInputController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Special Needs',
                                hintStyle: TextStyle(fontSize: 15.0)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      height: 50.0,
                      width: 250.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Center(
                          child: TextFormField(
                            controller: _vetNameInputController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Vet Name',
                                hintStyle: TextStyle(fontSize: 15.0)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      height: 50.0,
                      width: 250.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Center(
                          child: TextFormField(
                            controller: _vetPhoneNumberInputController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Vet Phone Number',
                                hintStyle: TextStyle(fontSize: 15.0)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.1,
              ),
              GestureDetector(
                onTap: () {
                  Pet updatedPet = widget.pet;
                  updatedPet.allergies = _petAllergiesInputController.text;
                  updatedPet.specialNeeds = _specialNeedsInputController.text;
                  updatedPet.vetName = _vetNameInputController.text;
                  updatedPet.vetPhoneNumber =
                      _vetPhoneNumberInputController.text;

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => StpVaccineScreen(
                                pet: updatedPet,
                                petImage: widget.petImage,
                              )));
                },
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
