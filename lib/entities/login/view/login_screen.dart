import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:zanatlija_app/navigation/routes.dart';
import 'package:zanatlija_app/utils/common_widgets.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailPhoneNumberController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailPhoneNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).colorScheme.background,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/hammerWrench.png',
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.height * 0.2,
            ),
            const SizedBox(
              height: 40,
            ),
            Column(
              children: [
                CommonTextField(
                    'Email ili broj telefona', _emailPhoneNumberController),
                CommonTextField(
                  'Sifra',
                  _passwordController,
                  obscureText: true,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            CommonActionButton(
              title: 'Prijavi se',
              onAction: () {},
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () =>
                  AutoRouter.of(context).replaceNamed(kRegistrationRoute),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Nemaš nalog?',
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Registruj se',
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).primaryColorDark),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
