import 'package:coffe_app/common/constants/coffee_colors.dart';
import 'package:coffe_app/common/constants/router_constants.dart';
import 'package:coffe_app/common/constants/scrool.dart';
import 'package:coffe_app/common/provider/basket_provider.dart';
import 'package:coffe_app/locator.dart';
import 'package:coffe_app/main.dart';
import 'package:coffe_app/network/models/product/product.dart';
import 'package:coffe_app/network/services/product/product_services.dart';
import 'package:coffe_app/ui/base/base_view.dart';
import 'package:coffe_app/ui/treats/view_model/treats_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';

class TreatsListView extends StatefulWidget {
  final ProductModel? productModel;
  const TreatsListView({super.key, this.productModel});

  @override
  State<TreatsListView> createState() => _TreatsListViewState();
}

class _TreatsListViewState extends State<TreatsListView> with RouteAware {
  late final PageController _treatsController;
  late final PageController _headingController;
  late double _currentPosition;
  late int _currentHeading;
  void _navigationListener() {
    setState(() {
      _currentPosition = _treatsController.page!;
      // print(_currentPosition);
      if (_currentPosition.round() != _currentHeading) {
        _currentHeading = _currentPosition.round();
        _headingController.animateToPage(_currentHeading,
            duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _treatsController = PageController(viewportFraction: 0.4, initialPage: 2);
    _headingController = PageController(viewportFraction: 1, initialPage: 2);
    _currentPosition = _treatsController.initialPage.toDouble();
    _currentHeading = _headingController.initialPage;
    _treatsController.addListener(_navigationListener);
  }

  @override
  void dispose() {
    _treatsController.removeListener(_navigationListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var basket = Provider.of<BasketProvider>(context);

    return BaseView<TreatsViewModel>(
        routeObserver: routeObserver,
        onDispose: () => routeObserver.unsubscribe(this),
        builder: (context, value, widget) => value.busy
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                clipBehavior: Clip.none,
                children: [
                  Align(
                    alignment: Alignment.bottomCenter + const Alignment(0, -1.2),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          _treatsPrice(context, value),
                          SizedBox(
                            height: size.height * 0.02, // 15 value
                          ),
                          _treatsNameList(value)
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: -size.width * 0.52,
                    width: size.width,
                    height: size.height * 0.7,
                    child: _coffeImage(),
                  ),
/*                   Align(
                    alignment: Alignment.bottomRight,
                    child: _treatsCalori(context, value),
                  ), */
                  Transform.scale(
                    alignment: Alignment.bottomCenter,
                    scale: 2.0,
                    child: _treatsList(value),
                  ),
                  _elevatedButton(size, value, basket),
                ],
              ),
        onModelReady: (p0) => p0.fetchTreats(),
        model: TreatsViewModel(
            productServices: locator<ProductServices>(),
            basketProvider: Provider.of<BasketProvider>(context))); //TODO:Neden provider of context yapıyoruz.
  }

  Align _treatsPrice(BuildContext context, TreatsViewModel treat) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Text(
          "${treat.treats![treat.index!].price} TL",
          style: Theme.of(context).textTheme.headline2,
          textAlign: TextAlign.right,
        ),
      ),
    );
  }

  SizedBox _treatsNameList(TreatsViewModel treat) {
    return SizedBox(
      height: 80,
      child: PageView.builder(
        itemBuilder: (context, index) {
          treat.index = index;
          return Padding(
            padding: const EdgeInsets.only(left: 220, right: 20),
            child: Text(
              treat.treats![index].name!,
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.headline4,
            ),
          );
        },
        physics: const NeverScrollableScrollPhysics(),
        controller: _headingController,
        itemCount: treat.treats!.length,
      ),
    );
  }

  Hero _coffeImage() {
    return Hero(
        tag: "nameCoffee", //CoffeImageTag
        child: Transform.scale(
          scale: 1.36,
          child: Image.asset(
            "assets/coffee/GLASS-1.png",
            fit: BoxFit.contain,
          ),
        ));
  }

/*   SafeArea _treatsCalori(BuildContext context, TreatsViewModel treat) {
    return SafeArea(
        child: Padding(
      padding: CoffeePading.instance.highHorizontalMediumVertical,
      child: Text(
        treat.treats![treat.index!].colories!,
        style: Theme.of(context).textTheme.headline5,
        textAlign: TextAlign.right,
      ),
    ));
  } */

  PageView _treatsList(TreatsViewModel treat) {
    return PageView.builder(
      itemBuilder: (context, index) {
        if (index == 0) {
          // HEADINGS HERE Would be great
          return const SizedBox.shrink();
        }
        // we need to know how much index is far from the current page to scale it
        final double distance = (_currentPosition - index + 1).abs();
        final isNotOnScreen = (_currentPosition - index + 1) > 0;
        final double scale = 1 - distance * .38;
        final double translateY =
            (1 - scale).abs() * MediaQuery.of(context).size.height / 1.5 + 25 * (distance - 1).clamp(0.0, 1);
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * .1),
          child: Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..translate(0.0, !isNotOnScreen ? 0.0 : translateY)
              ..scale(!isNotOnScreen ? 1.0 : scale),
            alignment: Alignment.bottomRight,
            child: Image.asset(
              "assets/treat/TREAT_1.png",
              fit: BoxFit.fitHeight,
            ),
          ),
        );
      },
      controller: _treatsController,
      scrollDirection: Axis.vertical,
      itemCount: treat.treats!.length + 1,
      scrollBehavior: WindowsScrollBehaviour(),
    );
  }

  Positioned _elevatedButton(Size size, TreatsViewModel treat, BasketProvider basket) {
    return Positioned(
        right: size.width * 0.2,
        bottom: size.height * 0.25,
        child: ElevatedButton(
          onPressed: () {
            treat.addToBasket(treat.treats![treat.index!]);
            Navigator.pushNamed(context, RouteConst.checkoutView, arguments: widget.productModel);
          },
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            elevation: 10,

            // padding: EdgeInsets.zero,
            backgroundColor: Colors.white,
            padding: const EdgeInsets.all(8),
          ),
          child: const Icon(
            FeatherIcons.plus,
            color: CoffeeColors.kTitleColor,
            size: 32,
          ),
        ));
  }
}
