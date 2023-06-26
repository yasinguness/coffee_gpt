import 'package:auto_route/auto_route.dart';
import '../../../common/constants/coffee_colors.dart';
import '../../../common/constants/scrool.dart';
import '../../../common/provider/basket_provider.dart';
import '../../../locator.dart';
import '../../../network/models/order_product/order_product.dart';
import '../../../network/models/product/product.dart';
import '../../../network/services/product/product_services.dart';
import '../../../router/app_router.dart';
import '../../base/base_view.dart';
import '../view_model/treats_view_model.dart';
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
  late ProductModel model;

  void _navigationListener() {
    setState(() {
      _currentPosition = _treatsController.page!;
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

    model = widget.productModel!;
  }

  @override
  void dispose() {
    super.dispose();

    _treatsController.removeListener(_navigationListener);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var basket = Provider.of<BasketProvider>(context);

    return BaseView<TreatsViewModel>(
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
                            height: size.height * 0.008, // 15 value
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
                  Transform.scale(
                    alignment: Alignment.bottomCenter,
                    scale: 1.8,
                    child: _treatsList(value),
                  ),
                  _elevatedButton(size, value, basket),
                ],
              ),
        onModelReady: (p0) => p0.fetchTreats(),
        model: TreatsViewModel(
            productServices: locator<ProductServices>(),
            basketProvider: Provider.of<BasketProvider>(context),
            sweet: OrderProductModel()));
  }

  Align _treatsPrice(BuildContext context, TreatsViewModel treat) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Text(
          "${treat.treats![treat.index!].price} TL",
          style: Theme.of(context).textTheme.displayMedium,
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
            padding: const EdgeInsets.only(right: 20),
            child: Text(
              treat.treats![index].name!,
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.headlineMedium,
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
        tag: "name${model.id!.toString()}", //CoffeImageTag
        child: Transform.scale(
          scale: 1.36,
          child: Image.network(
            "${model.image}",
            fit: BoxFit.contain,
          ),
        ));
  }

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
        final double scale = 1 - distance * 0.38;
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
            child: Image.network(
              "${treat.treats![index - 1].image}",
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

  Positioned _elevatedButton(Size size, TreatsViewModel model, BasketProvider basket) {
    return Positioned(
        right: size.width * 0.2,
        bottom: size.height * 0.25,
        child: ElevatedButton(
          onPressed: () {
            model.sweet!.product = model.treats![model.index!];
            model.sweet!.currentPrice = model.treats![model.index!].price;
            model.sweet!.selectedSize = "M";
            model.addToBasket();
            context.router.push(const CheckoutRoute());
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
