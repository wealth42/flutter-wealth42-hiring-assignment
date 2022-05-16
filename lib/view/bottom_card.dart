import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomCard extends StatelessWidget {
  const BottomCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Color(0xff5A18AF), Color(0xFFB84BFB)]),
        // borderRadius: BorderRadius.only(
        //   topRight: Radius.circular(16),
        //   topLeft: Radius.circular(16),
        // ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Text("Happy with your settings?",
                  style: GoogleFonts.manrope(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  )),
              Positioned(
                right: -8,
                top: -4,
                child: Image.asset(
                  "assets/star1.png",
                  width: 11,
                ),
              ),
              Positioned(
                right: -15,
                top: 4,
                child: Image.asset(
                  "assets/star2.png",
                  width: 8,
                ),
              ),
              Positioned(
                right: -20,
                top: -8,
                child: Image.asset(
                  "assets/star3.png",
                  width: 8,
                ),
              ),
            ],
            overflow: Overflow.visible,
          ),
          SizedBox(height: 8),
          Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
              style: GoogleFonts.manrope(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              )),
          SizedBox(height: 24),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                "Show me my plan",
                style: GoogleFonts.manrope(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Color(0xff1A1B22)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
