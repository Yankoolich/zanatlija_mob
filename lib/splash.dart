import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:zanatlija_app/navigation/routes.dart';
import 'package:zanatlija_app/utils/app_mixin.dart';

@RoutePage()
class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with AppMixin {
  bool _showSplashLogo = true;

  @override
  void initState() {
    wait(const Duration(seconds: 1)).then((value) {
      setState(() {
        _showSplashLogo = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: animatedChildSwitcher(
          currentChild: _showSplashLogo
              ? Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Theme.of(context).colorScheme.background,
                  child: Image.asset(
                    'assets/logo.png',
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.height * 0.3,
                  ),
                )
              : _StartingWidget()),
    );
  }
}

class _StartingWidget extends StatelessWidget {
  TextStyle _getRowTextStyle() => const TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 36,
      );

  Widget _buildTextRow(BuildContext context,
      {required String leftText,
      required String rightText,
      bool? isPrimaryColorDark}) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: [
          Text(
            leftText,
            style: _getRowTextStyle().copyWith(color: Colors.black),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            rightText,
            style: _getRowTextStyle().copyWith(
                fontWeight: isPrimaryColorDark == true
                    ? FontWeight.bold
                    : FontWeight.w900,
                color: isPrimaryColorDark == true
                    ? Theme.of(context).primaryColorDark
                    : Theme.of(context).primaryColorLight),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/hammerWrench.png',
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.height * 0.3,
            ),
            Column(
              children: [
                _buildTextRow(context,
                    leftText: 'Nadji',
                    rightText: 'zanat',
                    isPrimaryColorDark: true),
                _buildTextRow(context,
                    leftText: 'Ponudi',
                    rightText: 'zanat',
                    isPrimaryColorDark: true),
                _buildTextRow(
                  context,
                  leftText: 'Budi',
                  rightText: 'ZANATLIJA!',
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                AutoRouter.of(context).replaceNamed(kLoginRoute);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).cardColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ).copyWith(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        20), // Change this value to control the radius
                  ),
                ),
              ),
              child: const Text('Započni pretragu'),
            ),
          ],
        ),
      ),
    );
  }
}
