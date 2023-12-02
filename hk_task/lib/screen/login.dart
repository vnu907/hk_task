import 'package:flutter/material.dart';
import 'package:hk_task/controller/custom_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final key = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  bool _isVisible = false;
  final controller = CustomController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding:
            const EdgeInsets.only(left: 24, right: 24, top: 18, bottom: 18),
        child: SingleChildScrollView(
          child: Form(
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    'assets/loginImage.jpg',
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Login',
                    style:
                        TextStyle(fontSize: 36, fontWeight: FontWeight.w500)),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Field Required";
                    }
                    return null;
                  },
                  controller: email,
                  decoration: const InputDecoration(
                      alignLabelWithHint: true,
                      isDense: true,
                      hintText: 'Enter ID',
                      prefixIcon: Icon(Icons.alternate_email)),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: password,
                  keyboardType: TextInputType.text,
                  obscureText: !_isVisible,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Field Required";
                    } else if (value.length < 4) {
                      return 'Password should be minimum 4 characters long';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      alignLabelWithHint: true,
                      isDense: true,
                      hintText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        splashColor: Colors.transparent,
                        onPressed: () {
                          setState(() {
                            _isVisible = !_isVisible;
                          });
                        },
                        icon: _isVisible
                            ? Icon(
                                Icons.visibility_outlined,
                                color: Theme.of(context).primaryColor,
                              )
                            : const Icon(Icons.visibility_off_outlined,
                                color: Colors.black38),
                        color: Theme.of(context).iconTheme.color,
                      )),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.blueAccent),
                      )),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    onPressed: () async {
                      if (key.currentState!.validate()) {
                        await controller.login(
                            email.text.trim(), password.text.trim(), context);
                      }
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'OR',
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 235, 235, 235),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    onPressed: () {},
                    child: Row(
                      children: [
                        Image.asset('assets/google.jpg', height: 28),
                        const SizedBox(width: 60),
                        const Text('Login with Google',
                            style: TextStyle(color: Colors.black54))
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    child: const Text('New to Logistics? Register'),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
