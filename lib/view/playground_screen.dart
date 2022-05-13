import 'package:flutter/material.dart';

class PlaygroundScreen extends StatefulWidget {
  const PlaygroundScreen({Key? key}) : super(key: key);

  @override
  State<PlaygroundScreen> createState() => _PlaygroundScreenState();
}

class _PlaygroundScreenState extends State<PlaygroundScreen> {
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
                          colors: [Color(0xFFE5E5E5), Colors.white])),
                  child: ListView(
                    children: [
                      //Preference Cards
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'My Goals',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                      //Goal Cards
                      //Assumptions Card
                    ],
                  )))
        ],
      ),
    );
  }

  Widget _buildMIRTSection() {
    return Container(
      height: 160,
      color: const Color(0xFF2E52EF),
    );
  }

  Widget _buildPreferenceCard() {
    return Container();
  }

  Widget _buildGoalCard() {
    return Container();
  }
}
