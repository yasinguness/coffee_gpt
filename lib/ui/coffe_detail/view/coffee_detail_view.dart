import 'package:coffe_app/common/constants/coffee_colors.dart';
import 'package:coffe_app/common/constants/coffee_padding.dart';
import 'package:coffe_app/common/constants/router_constants.dart';
import 'package:coffe_app/common/constants/text_const.dart';
import 'package:coffe_app/common/provider/basket_provider.dart';
import 'package:coffe_app/common/provider/coffe_provider.dart';
import 'package:coffe_app/common/widgets/app_bar_widget.dart';
import 'package:coffe_app/common/widgets/background_decoration.dart';
import 'package:coffe_app/locator.dart';
import 'package:coffe_app/main.dart';
import 'package:coffe_app/network/models/order_product/order_product.dart';
import 'package:coffe_app/network/models/product/product.dart';
import 'package:coffe_app/network/services/product/product_services.dart';
import 'package:coffe_app/ui/base/base_view.dart';
import 'package:coffe_app/ui/coffe_detail/view_model/coffee_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';

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
        routeObserver: routeObserver,
        onDispose: () => routeObserver.unsubscribe(this),
        //onModelReady: (p0) => p0.getCoffee(widget.coffee!.id!, widget.coffee!.size!),
        builder: (context, value, widget) => value.busy
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                appBar: const CustomAppBar(),
                body: Stack(
                  fit: StackFit.expand,
                  clipBehavior: Clip.none,
                  children: [_buildBackground(), _coffeBody(context, value, size), _positionedImage(size, value)],
                ),
              ),
        model: CoffeeDetailViewModel(
            orderProductModel: OrderProductModel(),
            coffeeServices: locator<ProductServices>(),
            basketProvider: Provider.of<BasketProvider>(context),
            coffeeProvider: Provider.of<CoffeeProvider>(context)));
  }

  Padding _coffeBody(BuildContext context, CoffeeDetailViewModel value, Size size) {
    return Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Column(
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
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
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
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                width: double.infinity,
                child: _coffeeButton(context, value),
              ),
            ),
          ],
        ));
  }

  Row _quantity(CoffeeDetailViewModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => model.decrementCounter(),
          child: Container(
            decoration: BoxDecoration(
                color: CoffeeColors.kTitleColor,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: CoffeeColors.kTitleColor, width: 2)),
            child: const Icon(
              Icons.remove,
              color: Colors.white,
            ),
          ),
        ),
        //TODO:Artır butonunu basıldığında buton kayıyor**
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Text(
            model.coffeeProvider!.productQuantity < 1 ? "1" : model.coffeeProvider!.productQuantity.toString(),
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        GestureDetector(
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
        )
      ],
    );
  }

  ElevatedButton _coffeeButton(BuildContext context, CoffeeDetailViewModel value) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: CoffeeColors.kTitleColor,
          alignment: Alignment.centerLeft,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          value.orderProductModel!.product = widget.coffee!;
          value.addToBasket();
          Navigator.pushNamed(context, RouteConst.sweetTreatsView, arguments: widget.coffee);
        },
        child: _elevatedButtonText(context));
  }

  Row _elevatedButtonText(BuildContext context) {
    return Row(
      children: [
        Text(
          TextConst.addToCard,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: CoffeeColors.white),
        ),
        const SizedBox(
          width: 5,
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
              .subtitle1!
              .copyWith(fontSize: 18, fontWeight: FontWeight.w400, color: CoffeeColors.kTitleColor),
        )
      ],
    );
  }

  Row _coffeSizeChoiceList(BuildContext context, CoffeeDetailViewModel model) {
    return Row(
      children: ['S', 'M', 'L']
          .map((sizeCoffe) => GestureDetector(
                onTap: () {
                  //model.coffeeProvider!.orderProduct?.selectedSize = sizeCoffe;
                  model.coffeeProvider!.selectedSize(widget.coffee!, sizeCoffe);
                  model.orderProductModel!.selectedSize = sizeCoffe;
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    padding: CoffeePading.instance.mediumHorizontalLowVertical,
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
      style: Theme.of(context).textTheme.subtitle1!.copyWith(
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
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }

  Text _description(BuildContext context) {
    return Text(
      widget.coffee!.description!,
      textAlign: TextAlign.left,
      style: Theme.of(context).textTheme.subtitle1!.copyWith(
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
            style: Theme.of(context).textTheme.headline1!,
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
