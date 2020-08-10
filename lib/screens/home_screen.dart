import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/models/UpcomingEvent.dart';
import 'package:petcode_app/screens/medical_info_screen.dart';
import 'package:petcode_app/screens/pet_info_screen.dart';
import 'package:petcode_app/screens/pet_info_screen2.dart';
import 'package:petcode_app/services/pet_service.dart';
import 'package:petcode_app/utils/hero_icons.dart';
import 'package:petcode_app/utils/string_helper.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/widgets/circular_check_box.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = 'Lucas';
  PetService petService;

  PageController _mainPageController;
  PageController _secondPageController;
  ValueNotifier _currentPageNotifier = ValueNotifier<int>(0);

  List<String> names;

  List<UpcomingEvent> _allPetUpcomingEvents;

  bool _value = false;

  int pageIndex = 0;

  @override
  void initState() {
    _mainPageController = PageController(initialPage: 0, viewportFraction: 0.8);
    _secondPageController = new PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    petService = Provider.of<PetService>(context);
    if (petService.allPets == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      names = new List<String>();
      print(petService.allPets.length);

      for (int i = 0; i < petService.allPets.length; i++) {
        Pet currentPet = petService.allPets[i];
        names.add(currentPet.name);
      }

      print('namesLength: ' + names.length.toString());
      print('petImagesLength: ' + petService.petImages.length.toString());

      _allPetUpcomingEvents = petService.getAllPetMedication();

      return Scaffold(
        /*
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: StyleConstants.lightBlue,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StpStartScreen()),
            );
          },
        ),
        */
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            height: height + _allPetUpcomingEvents.length * 15.0,
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 290.0,
                  width: width,
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 280.0,
                        //width: width,
                        //color: Colors.blue,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                height: 300.0,
                                width: width,
                                decoration: BoxDecoration(
                                  //color: StyleConstants.lightGrey,
                                  color: StyleConstants.purpleGrey,
                                  //borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                height: 200.0,
                                width: width,
                                child: Image(
                                  image: petService.petImages[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 12.0,
                              //left: width * 0.04,
                              child: Container(
                                width: width,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Row(
                                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            petService.allPets[index].name,
                                            style: StyleConstants
                                                .blackThinTitleTextLarge,
                                          ),
                                          SizedBox(
                                            height: 2.0,
                                          ),
                                          Text(
                                            petService.allPets[index].breed,
                                            style: StyleConstants
                                                .greyThinDescriptionText,
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      IconButton(icon: Icon(
                                        HeroIcons.icon_globe,
                                        size: 30.0,
                                        color: StyleConstants.darkPurpleGrey,
                                      ), onPressed: () {} ),
                                      SizedBox(
                                        width: width * 0.03,
                                      ),


                                      IconButton(
                                          icon: Icon(
                                            HeroIcons.icon_edit,
                                            size: 30.0,
                                            color:
                                            StyleConstants.darkPurpleGrey,
                                          ),
                                          onPressed: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => PetInfoScreen(
                                                    petIndex: pageIndex,
                                                  )
                                              )
                                          )
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            /*
                            Align(
                              alignment: Alignment.bottomCenter,
                              child:
                            )
                            */
                          ],
                        ),
                      );
                    },
                    itemCount: petService.allPets.length,
                    loop: false,
                    //index: 0,
                    onIndexChanged: (int index) {
                      setState(() {
                        pageIndex = index;
                      });
                    },
                    //pagination: new SwiperPagination(),
                    //viewportFraction: 0.9,
                    //scale: 0.9,
                    //control: new SwiperControl(),
                  ),
                ),
                DotsIndicator(
                  dotsCount: petService.allPets.length > 0
                      ? petService.allPets.length
                      : 1,
                  position: 0.0 + pageIndex,
                ),
                /*
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 200.0,
                    child: PageView.builder(
                      itemCount: petService.petImages.length,
                      controller: _mainPageController,
                      onPageChanged: (int index) {
                        _currentPageNotifier.value = index;
                        _secondPageController.jumpToPage(index);
                      },
                      itemBuilder: (context, position) {
                        return imageSlider(position);
                      },
                    ),
                  ),
                ),
                */
                /*
                CirclePageIndicator(
                  selectedDotColor: Colors.white,
                  itemCount: petService.petImages.length,
                  currentPageNotifier: _currentPageNotifier,
                ),*/
                SizedBox(
                  height: height * 0.001,
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _secondPageController,
                    itemCount: names.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: width * 0.035),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /*
                            Text(
                              names[index],
                              style: StyleConstants.blackTitleText,
                            ),
                            */
                            SizedBox(
                              height: height * 0.03,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  print('tapped pet info');
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            PetInfoScreen(
                                                              petIndex:
                                                                  pageIndex,
                                                            )),
                                                  );
                                                },
                                                child: Column(
                                                  children: [
                                                    Icon(
                                                      //Icons.pets,
                                                      HeroIcons.icon_heart,
                                                      size: 30.0,
                                                      color: StyleConstants
                                                          .darkPurpleGrey,
                                                    ),
                                                    Text(
                                                      'Pet Info',
                                                      style: TextStyle(
                                                          color: StyleConstants
                                                              .darkPurpleGrey,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () => print(
                                                    'schedule meds tapped'),
                                                child: Column(
                                                  children: [
                                                    Icon(
                                                      //Icons.person,
                                                      HeroIcons.icon_call,
                                                      size: 30.0,
                                                      color: StyleConstants
                                                          .darkPurpleGrey,
                                                    ),
                                                    Text(
                                                      'Owner Info',
                                                      style: TextStyle(
                                                          color: StyleConstants
                                                              .darkPurpleGrey,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () => print(
                                                    'schedule meds tapped'),
                                                child: Column(
                                                  children: [
                                                    Icon(
                                                      //Icons.today,
                                                      HeroIcons.icon_notification,
                                                      size: 30.0,
                                                      color: StyleConstants
                                                          .darkPurpleGrey,
                                                    ),
                                                    Text(
                                                      'Reminders',
                                                      style: TextStyle(
                                                          color: StyleConstants
                                                              .darkPurpleGrey,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () => Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            MedicalInfoScreen(
                                                              petId: petService.allPets[pageIndex].pid,
                                                            ))),
                                                child: Column(
                                                  children: [
                                                    Icon(
                                                      //Icons.assignment,
                                                      HeroIcons.icon_clipboard,
                                                      size: 30.0,
                                                      color: StyleConstants
                                                          .darkPurpleGrey,
                                                    ),
                                                    Text(
                                                      'Med Info',
                                                      style: TextStyle(
                                                          color: StyleConstants
                                                              .darkPurpleGrey,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            Divider(
                              height: 2.0,
                              thickness: 5.0,
                              color: StyleConstants.purpleGrey,
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Text(
                              'Upcoming',
                              style: StyleConstants.greyThinTitleText,
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Expanded(
                              child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: _allPetUpcomingEvents.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                                blurRadius: 5,
                                                offset: Offset(0, 3),
                                              ),
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(15.0)),
                                        height: 60.0,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              CircularCheckBox(
                                                value: _value,
                                                onChanged: (bool value) {
                                                  setState(() {
                                                    _value = value;
                                                  });
                                                },
                                                activeColor:
                                                    StyleConstants.green,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      _allPetUpcomingEvents[
                                                              index]
                                                          .name,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      softWrap: false,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontSize: 18.0,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    Text(
                                                      _allPetUpcomingEvents[
                                                              index]
                                                          .petName,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 15.0,
                                                          fontWeight:
                                                              FontWeight.w300),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              _allPetUpcomingEvents[index]
                                                          .date !=
                                                      null
                                                  ? Text(
                                                      StringHelper.getDateString(
                                                          _allPetUpcomingEvents[
                                                                  index]
                                                              .date
                                                              .toDate()),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )
                                                  : Text(
                                                      'No date given',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  noPetsAvailableIndicator() {
    return Container(
      decoration: BoxDecoration(
        color: StyleConstants.yellow,
        borderRadius: BorderRadius.circular(20.0),
      ),
      width: 300,
      height: 200.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You currently have no',
              style: StyleConstants.whiteTitleTextSmall,
            ),
            Text(
              'registered pets',
              style: StyleConstants.whiteTitleTextSmall,
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              width: 150.0,
              height: 45.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: StyleConstants.blue,
              ),
              child: Center(
                child: Text(
                  'Register a Tag',
                  style: StyleConstants.whiteTitleTextXS,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  imageSlider(int index) {
    return AnimatedBuilder(
      animation: _mainPageController,
      builder: (context, widget) {
        double value = 1;
        /*
        if (_mainPageController.position.haveDimensions) {
          value = _mainPageController.page - index;
          value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
        }*/

        return Center(
          child: SizedBox(
            height: 500.0,
            width: 400.0,
            //height: Curves.easeInOut.transform(value) * 200.0,
            //width: Curves.easeInOut.transform(value) * 350.0,
            child: widget,
          ),
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            child: Container(
              height: 500.0,
              width: 300.0,
              color: Colors.blue,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              width: 300.0,
              height: 400.0,
              decoration: BoxDecoration(
                color: StyleConstants.lightGrey,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                children: [
                  Text(petService.allPets[index].name),
                  Text(petService.allPets[index].breed),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 175.0,
              width: 250.0,
              child: Image(
                image: petService.petImages[index],
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}