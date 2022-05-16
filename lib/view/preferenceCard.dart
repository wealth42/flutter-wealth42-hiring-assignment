import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PreferenceCard extends StatelessWidget {
  PreferenceCard(
      {Key? key,
      required this.labelText,
      required this.value,
      required this.functionName()})
      : super(key: key);

  String labelText;
  String value;
  var functionName;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xffD4D4E1),
                      blurRadius: 4,
                      spreadRadius: 0,
                      offset: Offset(0, 1),
                    ),
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Text(
                      "$labelText",
                      style: GoogleFonts.manrope(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color(0xff34353E),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "$value",
                        style: GoogleFonts.manrope(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Color(0xff34353E),
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: functionName,
                        icon: Icon(
                          Icons.edit,
                        ),
                        iconSize: 16,
                        color: Colors.grey,
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
