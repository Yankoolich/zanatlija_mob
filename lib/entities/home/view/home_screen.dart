// ignore_for_file: prefer_const_constructors

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:zanatlija_app/data/models/craft.dart';
import 'package:zanatlija_app/data/models/user.dart';
import 'package:zanatlija_app/entities/home/bloc/craft_cubit.dart';
import 'package:zanatlija_app/entities/home/view/widgets/analytics_widget.dart';
import 'package:zanatlija_app/entities/home/view/widgets/craft_widget.dart';
import 'package:zanatlija_app/entities/login/bloc/user_bloc.dart';
import 'package:zanatlija_app/navigation/routes.dart';
import 'package:zanatlija_app/utils/app_mixin.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AppMixin {
  late User _user;
  @override
  void initState() {
    _user = BlocProvider.of<UserBloc>(context).state.user!;
    BlocProvider.of<CraftCubit>(context).getCraftListFromDatabase(_user);
    super.initState();
  }

  int _currentIndex = 1;
  List<Craft> _craftList = [];
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  String formatDate(DateTime date) {
    var formatter = DateFormat('EEE, d MMMM y', 'sr_RS');

    return _capitalizeFirstLetterOfEachWord(formatter.format(date));
  }

  String _capitalizeFirstLetterOfEachWord(String text) {
    if (text.isEmpty) return text;
    return text.split(' ').map((word) {
      if (word.isNotEmpty) {
        return word[0].toUpperCase() + word.substring(1).toLowerCase();
      }
      return word;
    }).join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentIndex != 1
          ? null
          : AppBar(
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.calendar_month_sharp),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    formatDate(DateTime.now()),
                    style: TextStyle(
                      color: Color(0xff515151),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
              backgroundColor: Theme.of(context).backgroundColor,
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications_none_outlined),
                  onPressed: () {},
                ),
              ],
            ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Pretraga',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Početna',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        backgroundColor: Theme.of(context).backgroundColor,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Color(0xff888888),
        enableFeedback: false,
        onTap: onTabTapped,
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).cardColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
              ),
              padding: EdgeInsets.all(32),
              child: Image.asset(
                'assets/hammerWrench.png',
                color: Colors.white,
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.height * 0.15,
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              title: const Text(
                'Dodaj zanat',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                // Close the drawer
                Navigator.pop(context);
                AutoRouter.of(context).pushNamed(kAddCraftRoute);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.info,
                color: Colors.white,
              ),
              title: const Text(
                'Posalji predlog',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                // Close the drawer
                Navigator.pop(context);
              },
            ),
            // Add more ListTiles as needed
          ],
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).backgroundColor,
        child: BlocListener<CraftCubit, CraftState>(
          listener: (context, state) {
            hideLoadingDialog(context);
            if (state is CraftStateError) {
              showSnackbarWithTitle(state.error, context);
            } else if (state is CraftLoadingState) {
              showLoadingDialog(context);
            } else if (state is CraftDownloadSuccess) {
              setState(() {
                _craftList = state.crafts;
              });
            }
          },
          child: _currentIndex == 1
              ? _Home(_user, _craftList)
              : _currentIndex == 2
                  ? _MyProfile(_user)
                  : SizedBox(),
        ),
      ),
    );
  }
}

class _Home extends StatelessWidget {
  final User user;
  final List<Craft> crafts;
  const _Home(this.user, this.crafts, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'Pretrazi zanate koji ti trebaju ovde',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff1E1E1E)),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor, shape: BoxShape.circle),
                height: MediaQuery.of(context).size.height * 0.075,
                width: MediaQuery.of(context).size.height * 0.075,
                child: Icon(
                  Icons.search,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.all(4.0),
            child: AnalyticsWidget(crafts),
          ),
          Spacer(),
          Text(
            'Lista zanata',
            style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w600,
                color: Color(0xff1E1E1E)),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: crafts.isNotEmpty
                ? SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (final craft in crafts) CraftWidget(craft)
                      ],
                    ),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height * 0.235,
                    child: Center(
                      child: Text('Lista je prazna'),
                    ),
                  ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}

class _MyProfile extends StatelessWidget {
  final User user;
  const _MyProfile(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    final imageSize = MediaQuery.of(context).size.height * 0.2;
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).cardColor,
        child: Padding(
          padding: EdgeInsets.only(top: 30),
          child: Column(
            children: [
              Text(
                'Moj profil',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 32,
                    color: Colors.white),
              ),
              SizedBox(
                height: imageSize / 2,
              ),
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40))),
                      child: Container(
                        margin: EdgeInsets.only(top: imageSize / 2),
                        child: Column(
                          children: [
                            Text(
                              user.nameSurname,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 28,
                                  color: Colors.black),
                            ),
                            Text(
                              user.location,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color: Color(0xff808080)),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Moji poslovi',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 24,
                                                  color: Color(0xff1E1E1E)),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(4),
                                              child: user.myJobs != null &&
                                                      user.myJobs!.isNotEmpty
                                                  ? SingleChildScrollView(
                                                      physics:
                                                          BouncingScrollPhysics(),
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: Row(
                                                        children: [
                                                          for (final item
                                                              in user.myJobs!)
                                                            CraftWidget(item)
                                                        ],
                                                      ),
                                                    )
                                                  : SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.235,
                                                      child: Center(
                                                          child: Text(
                                                              'Lista je prazna')),
                                                    ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Sačuvani zanati',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 24,
                                                  color: Color(0xff1E1E1E)),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(4),
                                              child: user.savedCrafts != null &&
                                                      user.savedCrafts!
                                                          .isNotEmpty
                                                  ? SingleChildScrollView(
                                                      physics:
                                                          BouncingScrollPhysics(),
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: Row(
                                                        children: [
                                                          for (final item
                                                              in user
                                                                  .savedCrafts!)
                                                            CraftWidget(item)
                                                        ],
                                                      ),
                                                    )
                                                  : SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.235,
                                                      child: Center(
                                                        child: Text(
                                                            'Lista je prazna'),
                                                      ),
                                                    ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0, -1.35),
                      child: Image.asset(
                        'assets/userProfileFill.png',
                        height: MediaQuery.of(context).size.height * 0.2,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
