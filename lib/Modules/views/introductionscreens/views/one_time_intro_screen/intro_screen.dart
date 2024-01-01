import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class one_time_intro_screen extends StatelessWidget {
  const one_time_intro_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IntroductionScreen(
          onDone: () async {
            // On button pressed
            Navigator.pushReplacementNamed(context, 'home');
            SharedPreferences preferences =
                await SharedPreferences.getInstance();

            preferences.setBool('isVisited', true);
          },
          back: const Text(
            "Back",
            style: TextStyle(
              color: Colors.redAccent,
            ),
          ),
          done: const Text(
            'Done',
            style: TextStyle(
              color: Colors.redAccent,
            ),
          ),
          next: const Text(
            'Next',
            style: TextStyle(
              color: Colors.redAccent,
            ),
          ),
          allowImplicitScrolling: true,
          dotsDecorator: DotsDecorator(
            activeColor: Colors.redAccent,
            color: Colors.red.shade50,
          ),
          showNextButton: true,
          pages: [
            PageViewModel(
              title: "MY browser APP",
              body: "Welcome to the app!",
              decoration: const PageDecoration(
                pageColor: Colors.white,
              ),
              image: const CircleAvatar(
                radius: 120,
                backgroundImage: AssetImage("assets/images/firstimg.png"),
              ),
            ),
            PageViewModel(
              title: "this is a web app",
              body: "here you can use multiple web sites and there features.",
              decoration: const PageDecoration(
                pageColor: Colors.white,
              ),
              image: const CircleAvatar(
                radius: 130,
                backgroundImage: AssetImage("assets/images/secondimg.png"),
              ),
            ),
            PageViewModel(
              title: "Web view app ",
              body: "Have a web type of experience here!",
              decoration: const PageDecoration(),
              image: const CircleAvatar(
                radius: 130,
                backgroundImage: AssetImage("assets/images/thirdimg.png"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
