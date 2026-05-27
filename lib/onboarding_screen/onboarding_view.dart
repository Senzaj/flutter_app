import 'package:flutter/material.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key, required this.nextScreen});

  final Widget nextScreen;

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {

  final PageController _pageController = PageController();

  int _currentPage = 0;

  static const Map<int, Map<String, String>> onboardingData = {
    0: {
      'title': 'Welcome to test app!',
      'description': 'Discover infinite facebook™ repositoreies.'
    },
    1: {
      'title': 'Cute onboarding screen',
      'description': 'This is the second page of onboarding. Wait, there is one more page after this!'
    },
    2: {
      'title': 'Feed screen',
      'description': 'Next screen should be the scroll view. I hope so...'
    }
  };

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [ 
            SizedBox(
              height: 400,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (value) => setState(() => _currentPage = value),
                itemCount: onboardingData.length,
                itemBuilder: (context, index) {
                return OnboardingPage(
                  header: onboardingData[index]!['title']!,
                  description: onboardingData[index]!['description']!,
                );
              },
            ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: .center,
              children: [
                for (int i = 0; i < onboardingData.length; i++)
                  PageIndicator(isActive: i == _currentPage),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: .symmetric(horizontal: 16, vertical: 8),
              child: OnboardingButton(
                onPressed: nextPage,
                buttonText: switch (_currentPage) {
                  0 => 'Get started',
                  1 => 'Next',
                  2 => 'Finish',
                  _ => 'Next',
                }
              ),
            ),
          ],
        ),
      ),
    );
  }

  void nextPage() {
    if (_currentPage < onboardingData.length - 1){
      _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
    else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => widget.nextScreen),
      );
    }
  }
}

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key, required this.header, required this.description});

  final String header;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Text(
              header,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ]
        ),
      ),
    );
  }
}

class PageIndicator extends StatelessWidget {
  const PageIndicator({super.key, required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 12 : 8,
      height: isActive ? 12 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.blue : Colors.grey,
        shape: BoxShape.circle,
      )
    );
  }
}

class OnboardingButton extends StatelessWidget {
  const OnboardingButton({super.key, required this.onPressed, required this.buttonText});

  final Function() onPressed;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: 150,
      height: 40,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 16,
            color: Colors.blueGrey,
          ),
        ),
      ),
    );
  }
}
