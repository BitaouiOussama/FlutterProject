import 'package:flutter/material.dart';
import 'package:test_project/services/auth-service.dart';

// ignore: must_be_immutable
class SignupPage extends StatelessWidget {
   SignupPage({super.key});
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
   final TextEditingController passwordController = TextEditingController();
//      TextEditingController confirm_password_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            height: MediaQuery.of(context).size.height - 50,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const SizedBox(height: 60.0),

                    const Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Create your account",
                      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    // TextField(
                    //   controller: userNameController,
                    //   decoration: InputDecoration(
                    //       hintText: "Username",
                    //       border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(18),
                    //           borderSide: BorderSide.none),
                    //       fillColor: Colors.purple.withOpacity(0.1),
                    //       filled: true,
                    //       prefixIcon: const Icon(Icons.person)),
                    // ),

                    const SizedBox(height: 20),

                    TextFormField(
                       controller: emailController ,
                      decoration: InputDecoration(
                          hintText: "Email",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none),
                          fillColor: Colors.purple.withOpacity(0.1),
                          filled: true,
                          prefixIcon: const Icon(Icons.email)),
                    ),

                    const SizedBox(height: 20),

                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: "Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        fillColor: Colors.purple.withOpacity(0.1),
                        filled: true,
                        prefixIcon: const Icon(Icons.password),
                      ),
                      obscureText: true,
                    ),

                    const SizedBox(height: 20),

                    // TextField(
                    //   decoration: InputDecoration(
                    //     hintText: "Confirm Password",
                    //     border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(18),
                    //         borderSide: BorderSide.none),
                    //     fillColor: Colors.purple.withOpacity(0.1),
                    //     filled: true,
                    //     prefixIcon: const Icon(Icons.password),
                    //   ),
                    //   obscureText: true,
                    // ),
                  ],
                ),
                Container(
                    padding: const EdgeInsets.only(top: 3, left: 3),

                    child: ElevatedButton(
                      onPressed: () async {
                        await AuthService().singup(email: emailController.text,
                         password: passwordController.text,
                         context: context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.purple,
                      ),
                      child: const Text(
                        "Sign up",
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Already have an account?"),
                    TextButton(
                        onPressed: () {
                        Navigator.pushNamed(context, '/login');

                        },
                        child: const Text("Login", style: TextStyle(color: Colors.purple),)
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );

  }
}
