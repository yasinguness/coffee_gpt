// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    CheckoutRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CheckoutView(),
      );
    },
    ChatScreenRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ChatScreenView(),
      );
    },
    CoffeeListRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CoffeeListView(),
      );
    },
    CoffeeDetailRoute.name: (routeData) {
      final args = routeData.argsAs<CoffeeDetailRouteArgs>(
          orElse: () => const CoffeeDetailRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CoffeeDetailView(
          key: args.key,
          coffee: args.coffee,
        ),
      );
    },
    EntryRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const EntryView(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeView(),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginView(),
      );
    },
    SplashRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashView(),
      );
    },
    SweetTreatsRoute.name: (routeData) {
      final args = routeData.argsAs<SweetTreatsRouteArgs>(
          orElse: () => const SweetTreatsRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SweetTreatsView(
          key: args.key,
          produtModel: args.produtModel,
        ),
      );
    },
  };
}

/// generated route for
/// [CheckoutView]
class CheckoutRoute extends PageRouteInfo<void> {
  const CheckoutRoute({List<PageRouteInfo>? children})
      : super(
          CheckoutRoute.name,
          initialChildren: children,
        );

  static const String name = 'CheckoutRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ChatScreenView]
class ChatScreenRoute extends PageRouteInfo<void> {
  const ChatScreenRoute({List<PageRouteInfo>? children})
      : super(
          ChatScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatScreenRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CoffeeListView]
class CoffeeListRoute extends PageRouteInfo<void> {
  const CoffeeListRoute({List<PageRouteInfo>? children})
      : super(
          CoffeeListRoute.name,
          initialChildren: children,
        );

  static const String name = 'CoffeeListRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CoffeeDetailView]
class CoffeeDetailRoute extends PageRouteInfo<CoffeeDetailRouteArgs> {
  CoffeeDetailRoute({
    Key? key,
    ProductModel? coffee,
    List<PageRouteInfo>? children,
  }) : super(
          CoffeeDetailRoute.name,
          args: CoffeeDetailRouteArgs(
            key: key,
            coffee: coffee,
          ),
          initialChildren: children,
        );

  static const String name = 'CoffeeDetailRoute';

  static const PageInfo<CoffeeDetailRouteArgs> page =
      PageInfo<CoffeeDetailRouteArgs>(name);
}

class CoffeeDetailRouteArgs {
  const CoffeeDetailRouteArgs({
    this.key,
    this.coffee,
  });

  final Key? key;

  final ProductModel? coffee;

  @override
  String toString() {
    return 'CoffeeDetailRouteArgs{key: $key, coffee: $coffee}';
  }
}

/// generated route for
/// [EntryView]
class EntryRoute extends PageRouteInfo<void> {
  const EntryRoute({List<PageRouteInfo>? children})
      : super(
          EntryRoute.name,
          initialChildren: children,
        );

  static const String name = 'EntryRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomeView]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginView]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SplashView]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SweetTreatsView]
class SweetTreatsRoute extends PageRouteInfo<SweetTreatsRouteArgs> {
  SweetTreatsRoute({
    Key? key,
    ProductModel? produtModel,
    List<PageRouteInfo>? children,
  }) : super(
          SweetTreatsRoute.name,
          args: SweetTreatsRouteArgs(
            key: key,
            produtModel: produtModel,
          ),
          initialChildren: children,
        );

  static const String name = 'SweetTreatsRoute';

  static const PageInfo<SweetTreatsRouteArgs> page =
      PageInfo<SweetTreatsRouteArgs>(name);
}

class SweetTreatsRouteArgs {
  const SweetTreatsRouteArgs({
    this.key,
    this.produtModel,
  });

  final Key? key;

  final ProductModel? produtModel;

  @override
  String toString() {
    return 'SweetTreatsRouteArgs{key: $key, produtModel: $produtModel}';
  }
}
