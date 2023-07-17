import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';

import '../../../common/util/coffee_colors.dart';
import '../../../common/util/coffee_padding.dart';
import '../../../common/constants/text_const.dart';
import '../../../common/provider/basket_provider.dart';
import '../../../common/provider/coffe_provider.dart';
import '../../../common/widgets/app_bar_widget.dart';
import '../../../common/widgets/background_decoration.dart';
import '../../../network/models/order_product/order_product.dart';
import '../../../network/models/product/product.dart';
import '../../../router/app_router.dart';
import '../../base/base_view.dart';
import '../view_model/coffee_detail_model.dart';

@RoutePage()
class CoffeeDetailView extends StatefulWidget {
  final ProductModel? coffee;
  const CoffeeDetailView({super.key, this.coffee});

  @override
  State<CoffeeDetailView> createState() => _CoffeeDetailViewState();
}

class _CoffeeDetailViewState extends State<CoffeeDetailView> with RouteAware {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BaseView<CoffeeDetailViewModel>(
        builder: (context, value, widget) => value.busy
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _scaffold(context, value, size),
        model: CoffeeDetailViewModel(
            orderProductModel: OrderProductModel(),
            basketProvider: Provider.of<BasketProvider>(context),
            coffeeProvider: Provider.of<CoffeeProvider>(context)));
  }

  Scaffold _scaffold(BuildContext context, CoffeeDetailViewModel value, Size size) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [_buildBackground(), _coffeBody(context, value, size), _positionedImage(size, value)],
      ),
    );
  }

  Padding _coffeBody(BuildContext context, CoffeeDetailViewModel value, Size size) {
    return Padding(
        padding: CoffeePadding.instance.veryHigh,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: _coffeeNameAndDescr(size, context),
            ),
            Expanded(
              flex: 4,
              child: _coffeeFeatures(context, value, size),
            ),
            Expanded(
              flex: 1,
              child: _button(value, context, size),
            ),
          ],
        ));
  }

  Column _coffeeNameAndDescr(Size size, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _coffeeName(
          size,
          context,
        ),
        SizedBox(
          height: size.height * 0.03,
        ),
        _description(context),
      ],
    );
  }

  Column _coffeeFeatures(BuildContext context, CoffeeDetailViewModel value, Size size) {
    return Column(
      children: [
        _alignPrice(context, value),
        SizedBox(
          height: size.height * 0.01,
        ),
        _coffeSizeChoiceList(context, value),
        SizedBox(
          height: size.height * 0.01,
        ),
        _coffeeIconsAndSize(context, value, size),
        SizedBox(
          height: size.height * 0.01,
        ),
        _quantity(value),
      ],
    );
  }

  SizedBox _button(CoffeeDetailViewModel value, BuildContext context, Size size) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: _buttonStyle(),
          onPressed: () {
            value.orderProductModel!.product = widget.coffee!;
            value.addToBasket();
            context.router.popAndPush(SweetTreatsRoute(produtModel: widget.coffee));
            //Navigator.pushNamed(context, RouteConst.sweetTreatsView, arguments: widget.coffee);
          },
          child: _elevatedButtonText(context, size)),
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: CoffeeColors.kTitleColor,
      alignment: Alignment.centerLeft,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Row _quantity(CoffeeDetailViewModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [_decrementContainer(model), _text(model), _incrementContainer(model)],
    );
  }

  Padding _text(CoffeeDetailViewModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Text(
        model.coffeeProvider!.productQuantity < 1 ? "1" : model.coffeeProvider!.productQuantity.toString(),
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }

  GestureDetector _incrementContainer(CoffeeDetailViewModel model) {
    return GestureDetector(
      onTap: () => model.incrementCounter(),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
            color: CoffeeColors.kTitleColor,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: CoffeeColors.kTitleColor, width: 2)),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  GestureDetector _decrementContainer(CoffeeDetailViewModel model) {
    return GestureDetector(
      onTap: () => model.decrementCounter(),
      child: Container(
        decoration: BoxDecoration(
            color: CoffeeColors.kTitleColor,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: CoffeeColors.kTitleColor, width: 2)),
        child: const Icon(
          Icons.remove,
          color: CoffeeColors.white,
        ),
      ),
    );
  }

  Row _elevatedButtonText(BuildContext context, Size size) {
    return Row(
      children: [
        Text(
          TextConst.instance.addToCard,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: CoffeeColors.white),
        ),
        SizedBox(
          width: size.width * 0.05,
        ),
        const Icon(
          FeatherIcons.chevronRight,
          size: 18,
        )
      ],
    );
  }

  Row _coffeeIconsAndSize(BuildContext context, CoffeeDetailViewModel model, Size size) {
    return Row(
      children: [
        const Icon(
          FeatherIcons.coffee,
          color: CoffeeColors.kTitleColor,
          size: 30,
        ),
        SizedBox(
          width: size.width * 0.01,
        ),
        Text(
          widget.coffee?.size == 'M'
              ? "Medium"
              : widget.coffee?.size == 'L'
                  ? "Large"
                  : "Small",
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontSize: 18, fontWeight: FontWeight.w400, color: CoffeeColors.kTitleColor),
        )
      ],
    );
  }

  Row _coffeSizeChoiceList(BuildContext context, CoffeeDetailViewModel model) {
    model.orderProductModel!.selectedSize = widget.coffee!.size;
    return Row(
      children: ['S', 'M', 'L']
          .map((sizeCoffe) => GestureDetector(
                onTap: () {
                  model.coffeeProvider!.selectedSize(widget.coffee!, sizeCoffe);
                  model.orderProductModel!.selectedSize = sizeCoffe;
                },
                child: Padding(
                  padding: CoffeePadding.instance.mediumJustRight,
                  child: Container(
                    padding: CoffeePadding.instance.mediumHorizontalLowVertical,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: widget.coffee?.size == sizeCoffe ? CoffeeColors.kTitleColor : Colors.transparent,
                      border: Border.all(
                        color: widget.coffee?.size != sizeCoffe ? CoffeeColors.kTitleColor : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: _animatedTextCoffeeSize(context, model, sizeCoffe),
                  ),
                ),
              ))
          .toList(),
    );
  }

  AnimatedDefaultTextStyle _animatedTextCoffeeSize(
      BuildContext context, CoffeeDetailViewModel model, String sizeCoffe) {
    return AnimatedDefaultTextStyle(
      duration: const Duration(milliseconds: 300),
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: widget.coffee?.size != sizeCoffe ? CoffeeColors.kTitleColor : Colors.white),
      child: Text(
        sizeCoffe,
      ),
    );
  }

  Align _alignPrice(BuildContext context, CoffeeDetailViewModel model) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        "${widget.coffee?.size == 'M' ? widget.coffee?.price : widget.coffee?.size == 'L' ? (widget.coffee?.price)!.toDouble() + 5 : (widget.coffee!.price)!.toDouble() - 5}",
        style: Theme.of(context).textTheme.displayLarge,
      ),
    );
  }

  Text _description(BuildContext context) {
    return Text(
      widget.coffee!.description!,
      textAlign: TextAlign.left,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            height: 1.5,
            color: CoffeeColors.kTitleColor.withOpacity(0.5),
          ),
    );
  }

  SizedBox _coffeeName(
    Size size,
    BuildContext context,
  ) {
    return SizedBox(
      width: size.width * 0.6,
      child: Hero(
          tag: "name2${widget.coffee!.id!.toString()}",
          child: Text(
            widget.coffee!.name!,
            style: Theme.of(context).textTheme.displayLarge!,
          )),
    );
  }

  Positioned _positionedImage(Size size, CoffeeDetailViewModel model) {
    return Positioned(
      left: size.width * 0.38,
      bottom: -size.height * 0.15,
      width: size.width,
      height: size.height * 0.7,
      child: IgnorePointer(
        ignoring: true,
        child: Hero(
          tag: "name${widget.coffee!.id!.toString()}",
          child: AnimatedScale(
            duration: const Duration(milliseconds: 400),
            scale: widget.coffee?.size == 'M'
                ? 1.36
                : widget.coffee?.size == 'L'
                    ? 1.5
                    : 1.2,
            curve: Curves.easeOutBack,
            alignment: Alignment.center,
            child: Image.network(
              "${widget.coffee!.image}",
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }

  Column _buildBackground() {
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: BackgroundDecoration(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [CoffeeColors.kBrownColor.withOpacity(.7), CoffeeColors.kBrownColor.withOpacity(0.0)]),
        ),
        Expanded(
            flex: 6,
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [CoffeeColors.kBrownColor.withOpacity(0.5), CoffeeColors.kBrownColor.withOpacity(0.0)])),
            ))
      ],
    );
  }
}
