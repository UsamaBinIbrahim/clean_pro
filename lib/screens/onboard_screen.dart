import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:gif/gif.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen>
    with SingleTickerProviderStateMixin {
  late GifController _gifController;

  @override
  void initState() {
    super.initState();
    _gifController = GifController(vsync: this);
  }

  @override
  void dispose() {
    _gifController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: 'Welcome to CleanPro',
          body: 'Make your day cleaner',
          image: Center(
            child: Image.asset(
              'images/clean_pro_logo_removebg.png',
              height: 250,
            ),
          ),
        ),
        PageViewModel(
          title: 'Best Cleaning Services',
          body: 'Check plenty of services that fit your needs',
          image: Center(
            child: Gif(
              controller: _gifController,
              image: AssetImage('images/clean_hand_animation.gif'),
              autostart: Autostart.no,
              onFetchCompleted: () {
                _gifController.reset();
                _gifController.forward();
              },
            ),
          ),
        ),
        PageViewModel(
          title: 'User-Friendly Booking',
          body: 'Book your next services in few button clicks',
          image: Gif(
            height: 250,
            fit: BoxFit.cover,
            controller: _gifController,
            image: AssetImage('images/checkmark_animation.gif'),
            autostart: Autostart.no,
            onFetchCompleted: () {
              _gifController.reset();
              _gifController.forward();
            },
          ),
        ),
      ],
      showSkipButton: true,
      showNextButton: true,
      skip: const Text('Skip'),
      next: const Text('Next'),
      done: const Text('Done'),
      onDone: () {
        Navigator.of(context).pushReplacementNamed('/main');
      },
      onSkip: () {
        Navigator.of(context).pushReplacementNamed('/main');
      },
    );
  }
}
