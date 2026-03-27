import 'package:flutter/material.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(children: [
          Text("All your favorites"),
          Text("Get all your loved foods in one once place, you just place the orer we do the rest"),
          Text("NEXT"),
          Text("Skip"),
        ],),
      )
    );
  }
}
