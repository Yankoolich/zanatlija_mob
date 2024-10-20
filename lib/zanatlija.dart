import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zanatlija_app/entities/login/bloc/bloc/user_bloc.dart';
import 'package:zanatlija_app/navigation/router.dart';
import 'package:zanatlija_app/utils/app_mixin.dart';
import 'package:zanatlija_app/utils/theme.dart';

class ZanatlijaApp extends StatefulWidget {
  const ZanatlijaApp({super.key});

  @override
  State<ZanatlijaApp> createState() => _ZanatlijaAppState();
}

class _ZanatlijaAppState extends State<ZanatlijaApp> with AppMixin {
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
        title: 'Zanatlija',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        builder: (context, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(value: BlocProvider.of<UserBloc>(context)),
            ],
            child: child!,
          );
        });
  }
}
