import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task/services/api.dart';
import 'package:task/view/bottom_card.dart';
import 'package:task/view/gold_card.dart';
import 'package:task/view/preferenceCard.dart';
import 'package:video_player/video_player.dart';

class PlaygroundScreen extends StatefulWidget {
  const PlaygroundScreen({Key? key}) : super(key: key);

  @override
  State<PlaygroundScreen> createState() => _PlaygroundScreenState();
}

class _PlaygroundScreenState extends State<PlaygroundScreen> {
  late VideoPlayerController _controller;

  String riskProfileValue = "Moderate";
  String lifeExpectancyValue = "85";
  String monthlyExpanseValue = "50000";
  String monthlyExpanseValue2 = "50000";
  String currentSavingsValue = "50000";
  String retirementAgeValue = "45";

  var prefDetails;
  var mirtAmountData;

  bool isLoadingVideo = true;

  bool isLoadingAmount = true;
  bool isLoadingDetails = true;

  setVideoController() {
    _controller = VideoPlayerController.asset('assets/CalculatingBg.mp4')
      ..initialize().then((_) {
        _controller.setLooping(true);

        // Ensure the first frame is shown after the video is initialized
        setState(() {
          isLoadingVideo = false;
        });
      });
  }

  getAPIData1() async {
    setState(() {
      isLoadingAmount = true;
    });
    _controller.play();
    var mirtData = await dioGetMirtAmount();
    print(mirtData);
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        mirtAmountData = mirtData['data'];
        isLoadingAmount = false;
      });
      _controller.pause();
      _controller.seekTo(Duration.zero);
      print(mirtAmountData);
    });
  }

  getAPIData2() async {
    setState(() {
      isLoadingDetails = true;
    });
    var detailData = await dioPreferenceDetails();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        prefDetails = detailData['data'];
        riskProfileValue = detailData['data']['mirt']['risk_profile'];
        lifeExpectancyValue =
            detailData['data']['mirt']['life_expectancy'].toString();
        monthlyExpanseValue = detailData['data']['mirt']['monthly_expenses']
                ['other_household_expenses']
            .toString();
        monthlyExpanseValue2 = detailData['data']['mirt']['monthly_expenses']
                ['house_rent']
            .toString();
        currentSavingsValue =
            detailData['data']['mirt']['current_savings'].toString();
        retirementAgeValue =
            detailData['data']['mirt']['retirement_age'].toString();
        isLoadingDetails = false;
      });
      print(prefDetails);
    });
  }

  @override
  void initState() {
    setVideoController();

    getAPIData1();
    getAPIData2();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildMIRTSection(),
          Expanded(
              child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Color(0xFFE5E5E5), Colors.white]),
                  ),
                  child: ListView(
                    padding: EdgeInsets.only(top: 12),
                    scrollDirection: Axis.vertical,
                    children: [
                      isLoadingDetails
                          ? Shimmer.fromColors(
                              baseColor: Colors.grey.withOpacity(0.1),
                              highlightColor: Colors.white,
                              child: _buildPreferenceCard(
                                  labelText: "Risk Profile",
                                  value: riskProfileValue,
                                  functionName: editRiskProfile),
                            )
                          : _buildPreferenceCard(
                              labelText: "Risk Profile",
                              value: riskProfileValue,
                              functionName: editRiskProfile),
                      isLoadingDetails
                          ? Shimmer.fromColors(
                              baseColor: Colors.grey.withOpacity(0.1),
                              highlightColor: Colors.white,
                              child: _buildPreferenceCard(
                                  labelText: "Life expectancy",
                                  value: "$lifeExpectancyValue Years",
                                  functionName: editLifeExpectancy),
                            )
                          : _buildPreferenceCard(
                              labelText: "Life expectancy",
                              value: "$lifeExpectancyValue Years",
                              functionName: editLifeExpectancy),
                      isLoadingDetails
                          ? Shimmer.fromColors(
                              baseColor: Colors.grey.withOpacity(0.1),
                              highlightColor: Colors.white,
                              child: _buildPreferenceCard(
                                  labelText: "Monthly Expenses",
                                  value: "₹$monthlyExpanseValue",
                                  functionName: editMonthlyExpanse),
                            )
                          : _buildPreferenceCard(
                              labelText: "Monthly Expenses",
                              value: "₹$monthlyExpanseValue",
                              functionName: editMonthlyExpanse),
                      isLoadingDetails
                          ? Shimmer.fromColors(
                              baseColor: Colors.grey.withOpacity(0.1),
                              highlightColor: Colors.white,
                              child: _buildPreferenceCard(
                                  labelText: "Current Savings",
                                  value: "₹$currentSavingsValue",
                                  functionName: editCurrentSavings),
                            )
                          : _buildPreferenceCard(
                              labelText: "Current Savings",
                              value: "₹$currentSavingsValue",
                              functionName: editCurrentSavings),
                      isLoadingDetails
                          ? Shimmer.fromColors(
                              baseColor: Colors.grey.withOpacity(0.1),
                              highlightColor: Colors.white,
                              child: _buildPreferenceCard(
                                  labelText: "Retirement Age",
                                  value: "$retirementAgeValue Years",
                                  functionName: editRetirementAge),
                            )
                          : _buildPreferenceCard(
                              labelText: "Retirement Age",
                              value: "$retirementAgeValue Years",
                              functionName: editRetirementAge),
                      SizedBox(height: 13),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'My Goals',
                              style: GoogleFonts.manrope(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            GestureDetector(
                              onTap: () async {},
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                    color: Color(0xff2E52EF),
                                    borderRadius: BorderRadius.circular(6)),
                                child: Text(
                                  "+ Add",
                                  style: GoogleFonts.manrope(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Goal Cards
                      isLoadingDetails
                          ? Shimmer.fromColors(
                              baseColor: Colors.grey.withOpacity(0.1),
                              highlightColor: Colors.white,
                              child: _buildGoalCard())
                          : _buildGoalCard(),
                      SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 8),
                        child: Text(
                          'ASSUMPTIONS',
                          style: GoogleFonts.manrope(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        ),
                      ),

                      //Assumptions Card
                      isLoadingDetails
                          ? Shimmer.fromColors(
                              baseColor: Color(0xffDEE1F4),
                              highlightColor: Colors.white,
                              child: _buildAssumptionsCard())
                          : _buildAssumptionsCard(),

                      //Question
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 4),
                        child: Row(
                          children: [
                            Text(
                              "Got Questions?",
                              style: GoogleFonts.manrope(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0x9933343C),
                              ),
                            ),
                            SizedBox(width: 4),
                            Stack(
                              children: [
                                Image.asset(
                                  "assets/chat1.png",
                                  color: Color(0xff33343B),
                                  width: 16,
                                ),
                                Positioned(
                                  top: 4,
                                  left: 4,
                                  child: SvgPicture.asset(
                                    "assets/chat2.svg",
                                    color: Color(0xffFCFCFE),
                                    width: 8,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 4),
                            Text(
                              "Chat with us",
                              style: GoogleFonts.manrope(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff33343C),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),

                      //Bottom Card
                      _buildBottomCard(),
                    ],
                  )))
        ],
      ),
    );
  }

  Widget _buildMIRTSection() {
    return FittedBox(
      fit: BoxFit.fill,
      child: Container(
        //height: 160,
        color: const Color(0xFF2E52EF),
        width: isLoadingVideo ? 300 : _controller.value.size.width,
        height: isLoadingVideo
            ? 100
            : _controller.value.size.height +
                (MediaQuery.of(context).padding.top * 3),
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top * 3),
          child: Stack(
            children: [
              isLoadingVideo ? Container() : VideoPlayer(_controller),
              isLoadingAmount
                  ? Container()
                  : Positioned(
                      top: isLoadingVideo
                          ? 50
                          : _controller.value.size.height / 3.5,
                      left: isLoadingVideo
                          ? 50
                          : _controller.value.size.width / 3.5,
                      child: Column(
                        children: [
                          Text(
                            "Expected monthly income",
                            style: GoogleFonts.manrope(
                                color: Colors.white,
                                fontSize: 36,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "₹${mirtAmountData['expected_monthly_income']['a']}",
                            style: GoogleFonts.manrope(
                                color: Colors.white,
                                fontSize: 100,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPreferenceCard(
      {required String labelText,
      required String value,
      required functionName()}) {
    return PreferenceCard(
        labelText: labelText, value: value, functionName: functionName);
  }

  Widget _buildGoalCard() {
    return GoalCard();
  }

  Widget _buildBottomCard() {
    return BottomCard();
  }

  Widget _buildAssumptionsCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color(0xffDEE1F4),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  "assets/growth.svg",
                  width: 15,
                ),
                SizedBox(width: 12),
                Text(
                  isLoadingDetails
                      ? "My income grows by 7% every year"
                      : "My income grows by ${prefDetails['assumptions']['income_growth']} every year",
                  style: GoogleFonts.manrope(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color(0xff000000),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                SvgPicture.asset(
                  "assets/inflation.svg",
                  width: 15,
                ),
                SizedBox(width: 12),
                Text(
                  isLoadingDetails
                      ? "An Inflation rate of 5%"
                      : "An Inflation rate of ${prefDetails['assumptions']['inflation_rate']} ",
                  style: GoogleFonts.manrope(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color(0xff000000),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                SvgPicture.asset(
                  "assets/contingency.svg",
                  width: 15,
                ),
                SizedBox(width: 12),
                Text(
                  isLoadingDetails
                      ? "Reserving contingency for 2 months"
                      : "Reserving contingency for ${prefDetails['assumptions']['contingency_period']}",
                  style: GoogleFonts.manrope(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color(0xff000000),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /* -----------------------------     BottomSheets      ------------------------*/

  editRiskProfile() {
    // _controller.pause();
    // _controller.seekTo(Duration.zero);
    showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            topLeft: Radius.circular(16),
          ),
        ),
        builder: (context) {
          String riskValue = riskProfileValue;
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: 330,
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  topLeft: Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Text(
                    "Risk Profile",
                    style: GoogleFonts.manrope(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Vivamus sollicitudin fringilla lectus sed interdum",
                    style: GoogleFonts.manrope(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff686873)),
                  ),
                  SizedBox(height: 32),
                  Text(
                    "Select type of profile",
                    style: GoogleFonts.manrope(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff52525B)),
                  ),
                  SizedBox(height: 6),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Color(0xffCAD2DA), width: 1)),
                    child: DropdownButton<String>(
                      focusColor: Colors.white,
                      value: riskValue,
                      underline: Container(),
                      style: TextStyle(color: Colors.white),
                      iconEnabledColor: Colors.black,
                      isDense: true,
                      isExpanded: true,
                      items: <String>['Balanced', 'Moderate', 'Risky']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        riskValue = value!;
                      },
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Proin vitae orci sit amet quam tristique laoreet. Cras tortor leo, gravida sit amet sodales eu, ",
                    style: GoogleFonts.manrope(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff686873)),
                  ),
                  SizedBox(height: 32),
                  GestureDetector(
                    onTap: () {
                      getAPIData1();
                      getAPIData2();
                      setState(() {
                        riskProfileValue = riskValue;
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                            color: Color(0xff2E52EF),
                            borderRadius: BorderRadius.circular(8),
                            border:
                                Border.all(color: Color(0xffCAD2DA), width: 1)),
                        child: Center(
                          child: Text(
                            "Save Changes",
                            style: GoogleFonts.manrope(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        )),
                  ),
                ],
              ),
            );
          });
        });
  }

  editLifeExpectancy() {
    // _controller.play();
    showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            topLeft: Radius.circular(16),
          ),
        ),
        builder: (context) {
          String lifeValue = lifeExpectancyValue;
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: SingleChildScrollView(
                child: Container(
                  height: 330,
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16),
                      topLeft: Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      Text(
                        "Life expectancy",
                        style: GoogleFonts.manrope(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Vivamus sollicitudin fringilla lectus sed interdum",
                        style: GoogleFonts.manrope(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff686873)),
                      ),
                      SizedBox(height: 32),
                      Text(
                        "Expected years of life",
                        style: GoogleFonts.manrope(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff52525B)),
                      ),
                      SizedBox(height: 6),
                      Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 40,
                          child: Row(
                            children: [
                              Container(
                                width: 100,
                                height: 40,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(4),
                                        topLeft: Radius.circular(4)),
                                    border: Border.all(
                                        color: Color(0xffCAD2DA), width: 1)),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  initialValue: lifeValue,
                                  expands: false,
                                  decoration: new InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    filled: false,
                                    isDense: true,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      lifeValue = value;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                width: 60,
                                height: 40,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                    color: Color(0xffCAD2DA),
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(4),
                                        topRight: Radius.circular(4)),
                                    border: Border.all(
                                        color: Color(0xffCAD2DA), width: 1)),
                                child: Center(
                                  child: Text(
                                    "Years",
                                    style: GoogleFonts.manrope(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff1A1818)),
                                  ),
                                ),
                              )
                            ],
                          )),
                      SizedBox(height: 4),
                      Text(
                        "Proin vitae orci sit amet quam tristique laoreet. Cras tortor leo, gravida sit amet sodales eu, ",
                        style: GoogleFonts.manrope(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff686873)),
                      ),
                      SizedBox(height: 32),
                      GestureDetector(
                        onTap: () {
                          getAPIData1();
                          getAPIData2();
                          setState(() {
                            lifeExpectancyValue = lifeValue;
                          });
                          Navigator.pop(context);
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                                color: Color(0xff2E52EF),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: Color(0xffCAD2DA), width: 1)),
                            child: Center(
                              child: Text(
                                "Save Changes",
                                style: GoogleFonts.manrope(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: Colors.white),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  editMonthlyExpanse() {
    showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            topLeft: Radius.circular(16),
          ),
        ),
        builder: (context) {
          String monthlyValue = monthlyExpanseValue;
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: SingleChildScrollView(
                child: Container(
                  height: 415,
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16),
                      topLeft: Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Monthly Expenses",
                            style: GoogleFonts.manrope(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          Text(
                            "Remove",
                            style: GoogleFonts.manrope(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff2E52EF)),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        "House Rent",
                        style: GoogleFonts.manrope(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff52525B)),
                      ),
                      SizedBox(height: 6),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          child: Row(
                            children: [
                              Container(
                                height: 40,
                                width: MediaQuery.of(context).size.width - 50,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(4),
                                        topLeft: Radius.circular(4)),
                                    border: Border.all(
                                        color: Color(0xffCAD2DA), width: 1)),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  initialValue: monthlyExpanseValue2,
                                  expands: false,
                                  decoration: new InputDecoration(
                                    prefix: Text("₹"),
                                    suffix: Text(monthlyExpanseValue2.length > 3
                                        ? "₹${monthlyExpanseValue2.substring(0, monthlyExpanseValue2.length - 3)}K"
                                        : "0K"),
                                    contentPadding: EdgeInsets.zero,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    filled: false,
                                    isDense: true,
                                  ),
                                  onChanged: (value) {
                                    // setState(() {
                                    //   monthlyValue = value;
                                    // });
                                  },
                                ),
                              ),
                            ],
                          )),
                      SizedBox(height: 4),
                      Text(
                        "Proin vitae orci sit amet quam tristique laoreet. Cras tortor leo, gravida sit amet sodales eu, ",
                        style: GoogleFonts.manrope(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff686873)),
                      ),
                      SizedBox(height: 24),
                      Text(
                        "Other Household Expenses",
                        style: GoogleFonts.manrope(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff52525B)),
                      ),
                      SizedBox(height: 6),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          child: Row(
                            children: [
                              Container(
                                height: 40,
                                width: MediaQuery.of(context).size.width - 50,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(4),
                                        topLeft: Radius.circular(4)),
                                    border: Border.all(
                                        color: Color(0xffCAD2DA), width: 1)),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  initialValue: monthlyExpanseValue,
                                  expands: false,
                                  decoration: new InputDecoration(
                                    prefix: Text("₹"),
                                    suffix: Text(monthlyExpanseValue.length > 3
                                        ? "₹${monthlyExpanseValue.substring(0, monthlyExpanseValue.length - 3)}K"
                                        : "0K"),
                                    contentPadding: EdgeInsets.zero,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    filled: false,
                                    isDense: true,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      monthlyValue = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          )),
                      SizedBox(height: 4),
                      Text(
                        "Proin vitae orci sit amet quam tristique laoreet. Cras tortor leo, gravida sit amet sodales eu, ",
                        style: GoogleFonts.manrope(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff686873)),
                      ),
                      SizedBox(height: 32),
                      GestureDetector(
                        onTap: () {
                          getAPIData1();
                          getAPIData2();
                          setState(() {
                            monthlyExpanseValue = monthlyValue;
                          });
                          Navigator.pop(context);
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                                color: Color(0xff2E52EF),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: Color(0xffCAD2DA), width: 1)),
                            child: Center(
                              child: Text(
                                "Save Changes",
                                style: GoogleFonts.manrope(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: Colors.white),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  editCurrentSavings() {
    showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            topLeft: Radius.circular(16),
          ),
        ),
        builder: (context) {
          String cashValue = currentSavingsValue;
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: SingleChildScrollView(
                child: Container(
                  height: 265,
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16),
                      topLeft: Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Savings",
                            style: GoogleFonts.manrope(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          Text(
                            "Remove",
                            style: GoogleFonts.manrope(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff2E52EF)),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Cash Savings",
                        style: GoogleFonts.manrope(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff52525B)),
                      ),
                      SizedBox(height: 6),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          child: Row(
                            children: [
                              Container(
                                height: 40,
                                width: MediaQuery.of(context).size.width - 50,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(4),
                                        topLeft: Radius.circular(4)),
                                    border: Border.all(
                                        color: Color(0xffCAD2DA), width: 1)),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  initialValue: cashValue,
                                  expands: false,
                                  decoration: new InputDecoration(
                                    prefix: Text("₹"),
                                    suffix: Text("₹50K"),
                                    contentPadding: EdgeInsets.zero,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    filled: false,
                                    isDense: true,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      cashValue = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          )),
                      SizedBox(height: 4),
                      Text(
                        "Lorem Ipsum Dolor Sit Amet",
                        style: GoogleFonts.manrope(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff686873)),
                      ),
                      SizedBox(height: 32),
                      GestureDetector(
                        onTap: () {
                          getAPIData1();
                          getAPIData2();
                          setState(() {
                            currentSavingsValue = cashValue;
                          });
                          Navigator.pop(context);
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                                color: Color(0xff2E52EF),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: Color(0xffCAD2DA), width: 1)),
                            child: Center(
                              child: Text(
                                "Save Changes",
                                style: GoogleFonts.manrope(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: Colors.white),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  editRetirementAge() {
    showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            topLeft: Radius.circular(16),
          ),
        ),
        builder: (context) {
          String retirementValue = retirementAgeValue;
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: SingleChildScrollView(
                child: Container(
                  height: 330,
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16),
                      topLeft: Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      Text(
                        "Retirement Age",
                        style: GoogleFonts.manrope(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Vivamus sollicitudin fringilla lectus sed interdum",
                        style: GoogleFonts.manrope(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff686873)),
                      ),
                      SizedBox(height: 32),
                      Text(
                        "When are you planning to retire?",
                        style: GoogleFonts.manrope(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff52525B)),
                      ),
                      SizedBox(height: 6),
                      Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 40,
                          child: Row(
                            children: [
                              Container(
                                width: 100,
                                height: 40,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(4),
                                        topLeft: Radius.circular(4)),
                                    border: Border.all(
                                        color: Color(0xffCAD2DA), width: 1)),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  initialValue: retirementValue,
                                  expands: false,
                                  decoration: new InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    filled: false,
                                    isDense: true,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      retirementValue = value;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                width: 60,
                                height: 40,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                    color: Color(0xffCAD2DA),
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(4),
                                        topRight: Radius.circular(4)),
                                    border: Border.all(
                                        color: Color(0xffCAD2DA), width: 1)),
                                child: Center(
                                  child: Text(
                                    "Years",
                                    style: GoogleFonts.manrope(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff1A1818)),
                                  ),
                                ),
                              )
                            ],
                          )),
                      SizedBox(height: 4),
                      Text(
                        "Proin vitae orci sit amet quam tristique laoreet. Cras tortor leo, gravida sit amet sodales eu, ",
                        style: GoogleFonts.manrope(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff686873)),
                      ),
                      SizedBox(height: 32),
                      GestureDetector(
                        onTap: () {
                          getAPIData1();
                          getAPIData2();
                          setState(() {
                            retirementAgeValue = retirementValue;
                          });
                          Navigator.pop(context);
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                                color: Color(0xff2E52EF),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: Color(0xffCAD2DA), width: 1)),
                            child: Center(
                              child: Text(
                                "Save Changes",
                                style: GoogleFonts.manrope(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: Colors.white),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }
}
