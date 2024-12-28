import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 255, 147, 147),
                Colors.white
              ])
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CircleAvatar(
                  radius: 40.0,
                  child: Text(''),
                ),
                Text(
                  FirebaseAuth.instance.currentUser!.email!.toString(),
                  style: GoogleFonts.raleway(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                     
                    )
                  ),
                ),
              ],
            ),
          ),
          ExpansionTile(
            subtitle: const Text('Fashion Mnist Classification'),
            childrenPadding: const EdgeInsets.only(left: 20.0),
            title: const Text('Image Classification Model'),
            leading: const Icon(Icons.image),
            children: const [
              ListTile(title: Text('ANN Model')),
              ListTile(title: Text('CNN Model')),
            ],
          ),
          ListTile(
            leading: const Icon(Icons.money),
            title: const Text('Stock Price Prediction'),
          ),
          ListTile(
            leading: const Icon(Icons.voice_chat),
            title: const Text('Vocal Assistant(LLM)'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/vocal');
            },
          ),
          ListTile(
            leading: const Icon(Icons.image),
            title: const Text('RAG'),
          ),
        ],
      ),
    );
  }
}