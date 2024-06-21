import 'package:flutter/material.dart';
import 'package:insa_report/screens/login_screen.dart';
import 'package:insa_report/screens/signup_screen.dart';
import 'package:insa_report/widgets/copy_right.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Center(
                  child: Image.asset(
                    "assets/images/logo/logo.png",
                    width: MediaQuery.of(context).size.width / 2,
                  ),
                ),
                const Center(
                  child: Padding(
                    
                    padding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
                    child: Text(
                      "ተቋማዊ ደህንነትን መጠበቅ የሁሉም የተቋሙ ማህበረሰብ የጋራ ሃላፊነት ነው !!! \n ይህ የጥቆማ መስጫ ስርዐት ሚስጥራዊነቱ የተጠበቀ እና ሚስጥራዊነቱ የተረጋገጠ በመሆኑ ያለዎትን ማንኛውም የደህንነት ስጋትና ከስተት ጥቆማዎችን መስጠት ይችላሉ ።",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 23, 64, 98)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 18.0,
                ),
                Center(
                  child: Container(
                      constraints: const BoxConstraints(maxWidth: 320),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()));
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context).colorScheme.primary),
                                overlayColor: MaterialStateProperty.all<Color?>(
                                  Colors.white.withOpacity(0.18),
                                ),
                              ),
                              icon: const Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                                child: Icon(
                                  Icons.login,
                                  color: Colors.white,
                                ),
                              ),
                              label: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 12.0),
                                child: Text(
                                  "Login",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                          const SizedBox(
                            height: 12,
                          ),
                          OutlinedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpScreen()));
                              },
                              style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all<Color?>(
                                  Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.3),
                                ),
                                side: MaterialStateProperty.all<BorderSide>(
                                  BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(.65),
                                      width: 1.1),
                                ),
                              ),
                              icon: const Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                                child: Icon(
                                  Icons.app_registration,
                                  // color: Colors.white,
                                ),
                              ),
                              label: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 12.0),
                                child: Text(
                                  "Sign up",
                                ),
                              )),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          const CopyRight()
                        ],
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
