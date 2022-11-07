import 'package:flutter/material.dart';
import 'package:onboarding_project/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() {
              isLastPage = index == 2;
            });
          },
          children: [
            Container(
              color: Colors.red,
              child: Center(child: Text("Page 1")),
            ),
            Container(
              color: Colors.green,
              child: Center(child: Text("Page 2")),
            ),
            Container(
              color: Colors.blue,
              child: Center(child: Text("Page 3")),
            ),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
              onPressed: () async {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>  HomePage()));

                final prefs = await SharedPreferences.getInstance();
                prefs.setBool("showHome" , true);
              },
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)
                ),
                primary: Colors.white,
                backgroundColor: Colors.teal.shade700,
                minimumSize: Size.fromHeight(80)
              ),
              child: const Text(
                "Get Started",
                style: TextStyle(fontSize: 24),
              ))
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      controller.jumpToPage(2);
                    },
                    child: Text("SKIP"),
                  ),
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      effect: const WormEffect(
                          spacing: 16,
                          dotColor: Colors.blueGrey,
                          activeDotColor: Colors.red),
                      onDotClicked: (index) {
                        controller.animateToPage(index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      },
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        controller.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut);
                      },
                      child: Text("NEXT"))
                ],
              ),
            ),
    );
  }
}
