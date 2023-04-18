import 'package:administration_course/constants/style.dart';
import 'package:administration_course/data/model/user.dart';
import 'package:administration_course/data/provider/user_provider.dart';
import 'package:administration_course/widgets/form/form_button.dart';
import 'package:administration_course/widgets/form/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ProfileEditFormPage extends StatefulWidget {
  static const String routeName = '/profile_edit';
  const ProfileEditFormPage({super.key, required this.data});
  final User data;

  @override
  State<ProfileEditFormPage> createState() => _ProfileEditFormPageState();
}

class _ProfileEditFormPageState extends State<ProfileEditFormPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.data.idUser != '') {
      setData();
    }
    super.initState();
  }

  void setData() {
    _usernameController.text = widget.data.username;
    _passwordController.text = widget.data.password;
    _nameController.text = widget.data.name;
    _emailController.text = widget.data.email;
  }

  Future<void> goUpdate(
      String username, String password, String name, String email) async {
    debugPrint(
        'ADD User => User: $username, password: $password, name: $name, email: $email');
    final dataUser = User(
        idUser: widget.data.idUser,
        username: username,
        password: password,
        name: name,
        email: email,
        loginStatus: widget.data.loginStatus);
    if (_formKey.currentState!.validate()) {
      await Provider.of<UserProvider>(context, listen: false)
          .updateUser(dataUser);
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Berhasil menyimpan perubahan profil pengguna"),
        backgroundColor: Colors.green,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text("Gagal menyimpan perubahan profil pengguna"),
        backgroundColor: Colors.red.shade300,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding * 1.5, vertical: defaultPadding),
          children: [
            Container(
                alignment: Alignment.centerLeft,
                child: const Icon(Icons.person,
                    color: Colors.deepPurple, size: 45)),
            const Text(
              "User",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text("Edit data User pada formulir di bawah ini"),
            const SizedBox(
              height: 20,
            ),
            Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MyFormTextfield(
                      myController: _nameController,
                      myFieldName: "Nama Lengkap",
                      myIcon: Icons.person,
                      myPrefixIconColor: Colors.deepPurple.shade300,
                      myValidationNote: "Please enter some text",
                      isCurrency: false,
                      myMaxLine: 1,
                      myKeyboardType: TextInputType.name,
                    ),
                    MyFormTextfield(
                      myController: _usernameController,
                      myFieldName: "Username",
                      myIcon: Icons.account_circle,
                      myPrefixIconColor: Colors.deepPurple.shade300,
                      myValidationNote: "Please enter some text",
                      isCurrency: false,
                      myMaxLine: 1,
                      myKeyboardType: TextInputType.text,
                    ),
                    MyFormTextfield(
                      myController: _emailController,
                      myFieldName: "Email",
                      myIcon: Icons.email,
                      myPrefixIconColor: Colors.deepPurple.shade300,
                      myValidationNote: "Please enter some text",
                      isCurrency: false,
                      myMaxLine: 1,
                      myKeyboardType: TextInputType.streetAddress,
                    ),
                    MyFormTextfield(
                      myController: _passwordController,
                      myFieldName: "Password",
                      myIcon: Icons.lock,
                      myPrefixIconColor: Colors.deepPurple.shade300,
                      myValidationNote: "Please enter some text",
                      isCurrency: false,
                      myMaxLine: 1,
                      myKeyboardType: TextInputType.phone,
                    ),
                    MyFormButton(
                      onPress: () {
                        goUpdate(
                            _usernameController.text,
                            _passwordController.text,
                            _nameController.text,
                            _emailController.text);
                      },
                      textButton: 'simpan',
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
