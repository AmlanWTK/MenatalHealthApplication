import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void _skip() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const SignUpScreen()),
    );
  }

  void _getStarted() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const SignUpScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      OnboardingPage(
        imagePath: 'https://i.imgur.com/V7YQvWe.jpeg',
        title: 'Welcome to SereneSpace',
        subtitle: 'Take a step towards better mental health. We are here to support you on your journey to emotional well-being.',
      ),
      OnboardingPage(
        imagePath: 'https://i.imgur.com/SN2CL0V.jpeg',
        title: 'Track Your Mood',
        subtitle: 'Easily monitor your emotions daily. Understand your feelings, and take control of your mental well-being.',
      ),
      OnboardingPage(
        imagePath: 'https://i.imgur.com/DGMHhR1.png',
        title: 'Access Valuable resources',
        subtitle: 'Explore a vast library of resources. Empower yourself with knowledge to foster positive mental health.',
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: pages,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (index) => Container(
                  margin: const EdgeInsets.all(4),
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? Colors.lightBlue
                        : Colors.grey.shade300,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: _skip,
                    child: const Text('Skip', style: TextStyle(color: Colors.lightBlue)),
                  ),
                  _currentPage == 2
                      ? ElevatedButton(
                          onPressed: _getStarted,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlue,
                          ),
                          child: const Text('Get Started'),
                        )
                      : ElevatedButton(
                          onPressed: _nextPage,
                          style: ElevatedButton.styleFrom(
                            //backgroundColor: Colors.lightBlue,
                          ),
                          child: const Text('Next'),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;

  const OnboardingPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 6,
            child: Image.network(imagePath),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 20),
                Center(
                  child: Image.network('https://i.imgur.com/u4BEsxG.jpeg', height: 200),
                ),
                const SizedBox(height: 20),
                const Text('Sign Up', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text('Create a new account', style: TextStyle(fontSize: 16, color: Colors.black54)),
                const SizedBox(height: 30),
                const TextField(
                  decoration: InputDecoration(hintText: 'Full Name', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 15),
                const TextField(
                  decoration: InputDecoration(hintText: 'Email or Phone Number', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 15),
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'Password', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (val) {}),
                    const Text('I agree to terms and conditions')
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.lightBlue,
                  ),
                  child: const Text('Create Account'),
                ),
                const SizedBox(height: 15),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                    child: const Text('Already have an account? Login', style: TextStyle(color: Colors.lightBlue)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 20),
                Center(
                  child: Image.network('https://i.imgur.com/QsU0URD.jpeg', height: 200),
                ),
                const SizedBox(height: 20),
                const Text.rich(
                  TextSpan(
                    text: 'Welcome ',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text: 'Back!',
                        style: TextStyle(color: Colors.lightBlue),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text('Continue your calmness journey', style: TextStyle(fontSize: 16, color: Colors.black54)),
                const SizedBox(height: 30),
                const TextField(
                  decoration: InputDecoration(hintText: 'example@gmail.com', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 15),
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'Password', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 10),
                const Text('Forgot Password?', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.lightBlue,
                  ),
                  child: const Text('Log in'),
                ),
                const SizedBox(height: 15),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const SignUpScreen()),
                      );
                    },
                    child: const Text("Doesn't have an account? Signup", style: TextStyle(color: Colors.lightBlue)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
