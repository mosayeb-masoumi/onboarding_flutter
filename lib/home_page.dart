
import 'package:flutter/material.dart';
import 'package:onboarding_project/onboarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar:AppBar(
        actions: [
          IconButton(onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            prefs.setBool("showHome" , false);
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>  OnBoardingPage()));
          }, icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Text("Home"),
      ),
    );
  }
}
