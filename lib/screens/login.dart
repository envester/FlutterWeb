import 'package:flutter/material.dart';
import 'package:flutter_app/screens/constants.dart';
import 'package:flutter_app/services/AuthService.dart';

class LogIn extends StatefulWidget {
  final Function onSignUpSelected;

  const LogIn({super.key, required this.onSignUpSelected});

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _authService = AuthService();

  Future<void> _submitForm() async {
    bool isLoggedIn = await _authService.login(
        emailController.text.toString(), passwordController.text.toString());
    if (isLoggedIn) {
      print('You are successfully logged in');
    } else {
      print('The email address or password is incorrect');
    }
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.all(size.height > 770
          ? 64
          : size.height > 670
              ? 32
              : 16),
      child: Center(
        child: Card(
          elevation: 4,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: size.height *
                (size.height > 770
                    ? 0.7
                    : size.height > 670
                        ? 0.8
                        : 0.9),
            width: 500,
            color: Colors.white,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "LOG IN",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const SizedBox(
                        width: 30,
                        child: Divider(
                          color: kPrimaryColor,
                          thickness: 2,
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Form(
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Email',
                                labelText: 'Email',
                                suffixIcon: Icon(
                                  Icons.mail_outline,
                                ),
                              ),
                              controller: emailController,
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Password',
                                labelText: 'Password',
                                suffixIcon: Icon(
                                  Icons.lock_outline,
                                ),
                              ),
                              controller: passwordController,

                              //controller: passwordController,
                            ),
                            const SizedBox(
                              height: 64,
                            ),
                            TextButton(
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        kPrimaryColor),
                              ),
                              onPressed: _submitForm,
                              child: const Text('Log In'),
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "You do not have an account?",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          GestureDetector(
                            onTap: () {
                              widget.onSignUpSelected();
                            },
                            child: Row(
                              children: const [
                                Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: kPrimaryColor,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
