// import 'package:flutter/material.dart';
// import 'package:test_project/menu.dart';

// class RegisterForm extends StatelessWidget {
//    RegisterForm({super.key});
//   TextEditingController name_controller = TextEditingController();
//    TextEditingController email_controller = TextEditingController();
//     TextEditingController password_controller = TextEditingController();
//      TextEditingController confirm_password_controller = TextEditingController();


//   @override
//   Widget build(BuildContext context) {
//     return 
//             Scaffold(
              
//               appBar: AppBar(
//                 title: const Text('Register Form'),
//               ),
//               endDrawer: const Menu() ,
//               body:  Form(
//                 child:Column(
//                   children: [
//                     TextFormField(
//                       controller: name_controller ,
//                       onChanged: (value) {
//                         print(value);
//                       },
//                       decoration: InputDecoration(icon: Icon(Icons.person), labelText: 'Name'),
//                     ),

//                     SizedBox(height:50.0),
//                        TextFormField(
//                       controller: email_controller ,
//                       onChanged: (value) {
//                         print(value);
//                       },
//                       validator: (value) {
                        
//                         return '';
//                       },
//                       decoration: InputDecoration(icon: Icon(Icons.mail), labelText: 'Email'),
//                     ),
//                       TextFormField(
//                       controller: password_controller ,
//                       onChanged: (value) {
//                         print(value);
//                       },
//                       decoration: InputDecoration(icon: Icon(Icons.password), labelText: 'Password'),
//                     ),
//                       TextFormField(
//                       controller: confirm_password_controller ,
//                       onChanged: (value) {
//                         print(value);
//                       },
//                       decoration: InputDecoration(icon: Icon(Icons.password), labelText: 'Confirm Password'),
//                     ),
//                     ElevatedButton(onPressed: (){},
//                      child:  Text('Register') )
//                   ],
//                 ) 
//                 ),
              
//             );
//   }
// }

import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
   SignupPage({super.key});
      TextEditingController namecontroller = TextEditingController();
 TextEditingController emailcontroller = TextEditingController();
//     TextEditingController password_controller = TextEditingController();
//      TextEditingController confirm_password_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                    TextField(
                      decoration: InputDecoration(
                          hintText: "Username",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none),
                          fillColor: Colors.purple.withOpacity(0.1),
                          filled: true,
                          prefixIcon: const Icon(Icons.person)),
                    ),

                    const SizedBox(height: 20),

                    TextFormField(


                       controller: emailcontroller ,
//                       onChanged: (value) {
//                         print(value);
//                       },
//                       validator: (value) {
                        
//                         return '';
//                       },
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

                    TextField(
                      decoration: InputDecoration(
                        hintText: "Confirm Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        fillColor: Colors.purple.withOpacity(0.1),
                        filled: true,
                        prefixIcon: const Icon(Icons.password),
                      ),
                      obscureText: true,
                    ),
                  ],
                ),
                Container(
                    padding: const EdgeInsets.only(top: 3, left: 3),

                    child: ElevatedButton(
                      onPressed: () {
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.purple,
                      ),
                    )
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Already have an account?"),
                    TextButton(
                        onPressed: () {
                        Navigator.pushNamed(context, '/register');

                        },
                        child: const Text("Login", style: TextStyle(color: Colors.purple),)
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
