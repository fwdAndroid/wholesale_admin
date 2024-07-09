import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wholesale_admin/utils/borderstyle.dart';
import 'package:wholesale_admin/utils/colors.dart';
import 'package:wholesale_admin/widgets/buttons.dart';
import 'package:wholesale_admin/widgets/input_text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    bool passwordVisible = false;

    @override
    void initState() {
      super.initState();
      passwordVisible = true;
    }

    // Toggles the password show status
    TextEditingController emailControler = TextEditingController();
    TextEditingController pass = TextEditingController();
    TextEditingController nameController = TextEditingController();
    return Scaffold(
      backgroundColor: colorWhite,
      body: Column(
        children: [
          Image.asset(
            "assets/logo.png",
            height: 280,
          ),
          const SizedBox(height: 10),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Email Address",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
          ),
          const SizedBox(height: 9),
          InputText(
            controller: emailControler,
            labelText: "example@gmail.com",
            keyboardType: TextInputType.visiblePassword,
            onChanged: (value) {},
            onSaved: (val) {},
            textInputAction: TextInputAction.done,
            isPassword: false,
            enabled: true,
          ),
          const SizedBox(height: 20),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Password",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
          ),
          const SizedBox(height: 9),
          TextFormField(
            controller: pass,
            obscureText: passwordVisible,
            decoration: InputDecoration(
              focusedBorder: AppStyles.focusedBorder,
              disabledBorder: AppStyles.focusBorder,
              enabledBorder: AppStyles.focusBorder,
              errorBorder: AppStyles.focusErrorBorder,
              focusedErrorBorder: AppStyles.focusErrorBorder,
              hintText: "Password",
              suffixIcon: IconButton(
                icon: Icon(
                    passwordVisible ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(
                    () {
                      passwordVisible = !passwordVisible;
                    },
                  );
                },
              ),
              alignLabelWithHint: false,
              filled: true,
            ),
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
          ),
          const SizedBox(height: 10),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Name",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
          ),
          const SizedBox(height: 9),
          InputText(
            controller: nameController,
            labelText: "example@gmail.com",
            keyboardType: TextInputType.visiblePassword,
            onChanged: (value) {},
            onSaved: (val) {},
            textInputAction: TextInputAction.done,
            isPassword: false,
            enabled: true,
          ),
          const SizedBox(height: 40),
          WonsButton(
            height: 50,
            width: 348,
            verticalPadding: 0,
            color: primary,
            child: const Text(
              "Log in",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
            onPressed: () async {
              FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: emailControler.text, password: pass.text);
              await FirebaseFirestore.instance.collection("admin").doc().set({
                "uid": FirebaseAuth.instance.currentUser!.uid,
                "email": emailControler.text,
                "password": pass.text,
                "name": nameController.text
              });
            },
          ),
        ],
      ),
    );
  }
}
