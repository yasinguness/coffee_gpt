import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffe_app/common/constants/coffee_colors.dart';
import 'package:coffe_app/common/constants/scrool.dart';
import 'package:coffe_app/common/widgets/app_bar_widget.dart';
import 'package:coffe_app/common/widgets/background_decoration.dart';
import 'package:coffe_app/locator.dart';
import 'package:coffe_app/network/services/product/product_services.dart';
import 'package:coffe_app/router/app_router.dart';
import 'package:coffe_app/ui/base/base_view.dart';
import 'package:coffe_app/ui/coffeeGpt/view/chat_screen.dart';
import 'package:coffe_app/ui/coffee_list/view_model/coffee_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

@RoutePage()
class CoffeeListView extends StatefulWidget {
  const CoffeeListView({super.key});

  @override
  State<CoffeeListView> createState() => _CoffeeListViewState();
}

class _CoffeeListViewState extends State<CoffeeListView> with RouteAware, TickerProviderStateMixin {
  late final AnimationController _controller;

  late PageController _coffeeController;
  late PageController _headingController;
  late double _currentPosition;
  late int _currentHeading;

  void _navigationListener() {
    setState(() {
      _currentPosition = _coffeeController.page!;
      if (_currentPosition.round() != _currentHeading) {
        _currentHeading = _currentPosition.round();
        _headingController.animateToPage(_currentHeading,
            duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
    );

    _coffeeController = PageController(viewportFraction: 0.4, initialPage: 4);
    _headingController = PageController(viewportFraction: 1, initialPage: 4);
    _currentPosition = _coffeeController.initialPage.toDouble();
    _currentHeading = _headingController.initialPage;
    _coffeeController.addListener(() {
      _navigationListener();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();

    _coffeeController.removeListener(_navigationListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BaseView<CoffeListViewModel>(
      onModelReady: (p0) => p0.fetchCoffees(),
      model: CoffeListViewModel(coffeeServices: locator<ProductServices>()),
      builder: (context, value, widget) =>
          value.busy ? const Center(child: CircularProgressIndicator()) : _scaffold(size, value, context),
    );
  }

  Scaffold _scaffold(Size size, CoffeListViewModel value, BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Stack(
        children: [_backgroundAlign(size), _coffeListBuilder(value), _backgroundDecoration(size, value)],
      ),
    );
  }

  BackgroundDecoration _backgroundDecoration(Size size, CoffeListViewModel value) {
    return BackgroundDecoration(
      height: size.height * 0.3,
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: const [0.6, 1],
      colors: [
        Colors.white,
        Colors.white.withOpacity(0.0),
      ],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [_coffeNameBuilder(size, value), _buildOverlays()],
      ),
    );
  }

  FloatingActionButton _fabButton(BuildContext context) {
    return FloatingActionButton.large(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return const ChatScreenView();
            },
          );
        },
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: LottieBuilder.asset(
          "assets/lottie/question.json",
          width: 75,
          animate: true,
          reverse: false,
          repeat: true,
          controller: _controller,
          onLoaded: (composition) {
            // Configure the AnimationController with the duration of the
            // Lottie file and start the animation.
            _controller
              ..duration = composition.duration
              ..forward();
          },
        ));
  }

  SizedBox _coffeNameBuilder(Size size, CoffeListViewModel value) {
    return SizedBox(
      height: size.height * 0.30,
      child: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: _headingController,
        itemCount: value.coffees!.length + 1,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          value.index = index;
          if (index == value.coffees!.length) {
            return const SizedBox.shrink();
          }
          return Column(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [_name(value, index, context), _price(value, index, context)],
          );
        },
      ),
    );
  }

  Hero _name(CoffeListViewModel value, int index, BuildContext context) {
    return Hero(
        tag: "name2${value.coffees![index].id.toString()}",
        child: Text(
          value.coffees![index].name.toString(),
          style: Theme.of(context).textTheme.displayLarge,
          textAlign: TextAlign.center,
        ));
  }

  AnimatedSwitcher _price(CoffeListViewModel value, int index, BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Text(
        "${value.coffees![index].price} TL",
        style: Theme.of(context).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.w500, fontSize: 26),
      ),
    );
  }

  Transform _coffeListBuilder(CoffeListViewModel value) {
    return Transform.scale(
      alignment: Alignment.bottomCenter,
      scale: 2.6,
      child: PageView.builder(
        controller: _coffeeController,
        itemCount: value.coffees!.length + 1,
        clipBehavior: Clip.none,
        scrollDirection: Axis.vertical,
        scrollBehavior: WindowsScrollBehaviour(),
        itemBuilder: (context, index) {
          if (index == 0) {
            return const SizedBox.shrink();
          }
          final double distance = (_currentPosition - index + 1).abs();
          final isNotOnScreen = (_currentPosition - index + 1) > 0;
          final double scale = 1 - distance * .345 * (isNotOnScreen ? 1 : -1);
          final double translateY =
              (1 - scale).abs() * MediaQuery.of(context).size.height / 1.5 + 20 * (distance - 1).clamp(0.0, 1);
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1),
            child: Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..translate(0.0, !isNotOnScreen ? 0.0 : translateY)
                  ..scale(scale),
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    var currentUser = value.coffees![index - 1];
                    print(context.router.stack);
                    context.router.push(CoffeeDetailRoute(coffee: currentUser));
                    //Navigator.pushNamed(context, RouteConst.coffeeDetailView, arguments: currentUser);
                  },
                  child: _coffeeImage(value, index),
                )),
          );
        },
      ),
    );
  }

  Hero _coffeeImage(CoffeListViewModel value, int index) {
    return Hero(
      flightShuttleBuilder: (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) {
        late Widget hero;
        if (flightDirection == HeroFlightDirection.push) {
          hero = fromHeroContext.widget;
        } else {
          hero = toHeroContext.widget;
        }
        return hero;
      },
      tag: "name${value.coffees![index - 1].id.toString()}",
      child: CachedNetworkImage(
        imageUrl: "${value.coffees![index - 1].image}",
        fit: BoxFit.fitHeight,
      ),
    );
  }

  Widget _backgroundAlign(Size size) {
    return _bottomCenterAlign(size); /*  _leftCenterAlign(), _rightBottomAlign(size) */
  }

  Align _bottomCenterAlign(Size size) {
    return Align(
      alignment: Alignment.bottomCenter + const Alignment(0, .5),
      child: Container(
        width: size.width,
        height: size.height * 0.4,
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.brown, blurRadius: 90, spreadRadius: 60, offset: Offset.zero),
          ],
          shape: BoxShape.rectangle,
        ),
      ),
    );
  }

  Expanded _buildOverlays() {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                CoffeeColors.kBrownColor.withRed(170).withOpacity(0),
                CoffeeColors.kBrownColor.withOpacity(0.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
