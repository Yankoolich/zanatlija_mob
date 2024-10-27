// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i9;
import 'package:zanatlija_app/data/models/craft.dart' as _i8;
import 'package:zanatlija_app/entities/home/view/add_craft_screen.dart' as _i1;
import 'package:zanatlija_app/entities/home/view/home_screen.dart' as _i2;
import 'package:zanatlija_app/entities/home/view/view_craft_screen.dart' as _i6;
import 'package:zanatlija_app/entities/initial/view/initial_page_screen.dart'
    as _i3;
import 'package:zanatlija_app/entities/login/view/login_screen.dart' as _i4;
import 'package:zanatlija_app/entities/login/view/registration_screen.dart'
    as _i5;

abstract class $AppRouter extends _i7.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    AddCraft.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AddCraft(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomePage(),
      );
    },
    InitialRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.InitialPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.LoginPage(),
      );
    },
    RegistrationRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.RegistrationPage(),
      );
    },
    ViewCraft.name: (routeData) {
      final args = routeData.argsAs<ViewCraftArgs>();
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.ViewCraft(
          args.craft,
          key: args.key,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.AddCraft]
class AddCraft extends _i7.PageRouteInfo<void> {
  const AddCraft({List<_i7.PageRouteInfo>? children})
      : super(
          AddCraft.name,
          initialChildren: children,
        );

  static const String name = 'AddCraft';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i7.PageRouteInfo<void> {
  const HomeRoute({List<_i7.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i3.InitialPage]
class InitialRoute extends _i7.PageRouteInfo<void> {
  const InitialRoute({List<_i7.PageRouteInfo>? children})
      : super(
          InitialRoute.name,
          initialChildren: children,
        );

  static const String name = 'InitialRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i4.LoginPage]
class LoginRoute extends _i7.PageRouteInfo<void> {
  const LoginRoute({List<_i7.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i5.RegistrationPage]
class RegistrationRoute extends _i7.PageRouteInfo<void> {
  const RegistrationRoute({List<_i7.PageRouteInfo>? children})
      : super(
          RegistrationRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegistrationRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i6.ViewCraft]
class ViewCraft extends _i7.PageRouteInfo<ViewCraftArgs> {
  ViewCraft({
    required _i8.Craft craft,
    _i9.Key? key,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          ViewCraft.name,
          args: ViewCraftArgs(
            craft: craft,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ViewCraft';

  static const _i7.PageInfo<ViewCraftArgs> page =
      _i7.PageInfo<ViewCraftArgs>(name);
}

class ViewCraftArgs {
  const ViewCraftArgs({
    required this.craft,
    this.key,
  });

  final _i8.Craft craft;

  final _i9.Key? key;

  @override
  String toString() {
    return 'ViewCraftArgs{craft: $craft, key: $key}';
  }
}
