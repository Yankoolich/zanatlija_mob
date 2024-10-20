import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:zanatlija_app/entities/login/bloc/bloc/user_bloc.dart';
import 'package:zanatlija_app/entities/login/models/user.dart';
import 'package:zanatlija_app/navigation/routes.dart';
import 'package:zanatlija_app/utils/common_widgets.dart';
import 'package:zanatlija_app/utils/locations.dart';

@RoutePage()
class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _nameSurnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameSurnameController.dispose();
    _emailController.dispose();
    _locationController.dispose();
    _dateController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onRegistrationAction() {
    if (_nameSurnameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _locationController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _dateController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      return;
    }
    final bytes =
        utf8.encode(_passwordController.text); // Convert the password to bytes
    final digest = sha256.convert(bytes); // Hash the bytes
    final password = digest.toString();
    final user = User(
        nameSurname: _nameSurnameController.text,
        birthDateInMillis: DateFormat('dd/MM/yyyy')
            .parse(_dateController.text)
            .millisecondsSinceEpoch,
        email: _emailController.text,
        location: _locationController.text,
        password: password,
        phoneNumber: int.parse(_phoneController.text));
    BlocProvider.of<UserBloc>(context).add(CreateUserEvent(user));
    AutoRouter.of(context).replaceNamed(kLoginRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).colorScheme.background,
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/userProfile.png',
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.height * 0.1,
                ),
                const SizedBox(
                  height: 40,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonTextField('Ime i prezime', _nameSurnameController),
                    CommonTextField(
                      'Godina rodjenja',
                      _dateController,
                      isDatePicker: true,
                      disableCopyPaste: true,
                    ),
                    CommonTextField(
                      'Lokacija',
                      _locationController,
                      keyboardType: TextInputType.none,
                      locations: locations,
                      disableCopyPaste: true,
                    ),
                    CommonTextField(
                      'Email',
                      _emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    CommonTextField(
                      'Broj telefona',
                      _phoneController,
                      keyboardType: TextInputType.phone,
                    ),
                    CommonTextField(
                      'Šifra',
                      _passwordController,
                      obscureText: true,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CommonActionButton(
                  title: 'Registruj se',
                  onAction: _onRegistrationAction,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
