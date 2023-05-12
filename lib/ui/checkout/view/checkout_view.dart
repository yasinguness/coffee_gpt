import 'package:coffe_app/common/constants/coffee_colors.dart';
import 'package:coffe_app/common/constants/text_const.dart';
import 'package:coffe_app/common/widgets/app_bar_widget.dart';
import 'package:coffe_app/common/widgets/background_decoration.dart';
import 'package:coffe_app/locator.dart';
import 'package:coffe_app/main.dart';
import 'package:coffe_app/network/models/product/product.dart';
import 'package:coffe_app/network/models/order/order.dart';
import 'package:coffe_app/network/services/order/order_service.dart';
import 'package:coffe_app/ui/base/base_view.dart';
import 'package:coffe_app/ui/checkout/view_model/checkout_view_model.dart';
import 'package:flutter/material.dart';

class CheckoutView extends StatefulWidget {
  final ProductModel? treat;
  final ProductModel? coffee;
  const CheckoutView({super.key, this.treat, this.coffee});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> with RouteAware {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BaseView<CheckoutViewModel>(
      routeObserver: routeObserver,
      onDispose: () => routeObserver.unsubscribe(this),
      builder: (context, value, wtg) {
        return value.busy
            ? const Center(child: CircularProgressIndicator())
            : Scaffold(
                appBar: const CustomAppBar(),
                body: Stack(
                  alignment: Alignment.center,
                  children: [
                    _buildBackground(),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _myOrders(context),
                          SizedBox(
                            height: size.height * 0.04,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  _coffeCard(size, context, value, index),
                                  const Divider(
                                    thickness: 1,
                                  ),
                                  SizedBox(
                                    height: size.height * 0.01,
                                  ),
                                  if (widget.treat != null) _treatCard(size, context, value),
                                  if (widget.treat != null) const Divider(thickness: 1)
                                ],
                              );
                            },
                            //itemCount: value.order?.coffeeList?.length,
                          ),
                          const Spacer(),
                          _checkoutButton(value)
                          /* coffee.price + (treat?.price ?? 0)).toStringAsFixed(2) */
                        ],
                      ),
                    )
                  ],
                ),
              );
      },
      model: CheckoutViewModel(
        orderServices: locator<OrderService>(),
        coffee: widget.coffee!,
        treat: widget.treat,
        order: OrderModel(),
        listTreat: <ProductModel>[],
        listCoffee: <ProductModel>[],
      ),
      //onModelReady: (p0) => p0.getCoffeePrice(),
    );
  }

  Container _treatCard(Size size, BuildContext context, CheckoutViewModel value) {
    return Container(
      height: size.height * 0.1,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.transparent),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_treatImage(size), _treatNameAndQuantity(context, value, size), _treatPrice(context, size)],
      ),
    );
  }

  Container _coffeCard(Size size, BuildContext context, CheckoutViewModel value, int index) {
    return Container(
      height: size.height * 0.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_coffeImage(size), _coffeeNameAndQuantity(context, value, index), _coffePrice(value, context)],
      ),
    );
  }

  Expanded _coffeeNameAndQuantity(BuildContext context, CheckoutViewModel value, int index) {
    return Expanded(
        flex: 3,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [_coffeName(context, value, index), _quantity(value)]));
  }

  Expanded _treatNameAndQuantity(BuildContext context, CheckoutViewModel value, Size size) {
    return Expanded(
      flex: 3,
      child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        _treatName(context),
        _quantity(value),
      ]),
    );
  }

  Expanded _quantity(CheckoutViewModel model) {
    return Expanded(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: model.decrementCounter,
            child: Container(
              decoration: BoxDecoration(
                  color: CoffeeColors.kTitleColor,
                  borderRadius: BorderRadius.circular(8),
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
              model.counter.toString(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          GestureDetector(
            onTap: model.incrementCounter,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                  color: CoffeeColors.kTitleColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: CoffeeColors.kTitleColor, width: 2)),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  Text _myOrders(BuildContext context) {
    return Text(
      TextConst.orderText,
      style: Theme.of(context).textTheme.headline1,
    );
  }

  Expanded _coffeImage(Size size) {
    return Expanded(
      flex: 1,
      child: Container(
        height: 50,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: Hero(
            tag: "nameCoffee", //CoffeImageTag
            child: Image.asset(
              "assets/coffee/GLASS-2.png",
              fit: BoxFit.contain,
            )),
      ),
    );
  }

  Expanded _treatImage(Size size) {
    return Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: Image.asset(
          "assets/treat/TREAT_0.png",
          fit: BoxFit.contain,
          width: 50,
          height: 50,
        ),
      ),
    );
  }

  Expanded _coffePrice(CheckoutViewModel model, BuildContext context) {
    return Expanded(
      flex: 1,
      child: Text(
        "${model.price} TL",
        style: Theme.of(context).textTheme.subtitle1!.copyWith(
            fontSize: 16,
            letterSpacing: 1,
            fontWeight: FontWeight.w600,
            color: CoffeeColors.kTitleColor.withOpacity(.8)),
      ),
    );
  }

  Text _coffeName(BuildContext context, CheckoutViewModel model, int index) {
    return Text(
      /* model.order!.coffeeList![index].name! */ " asd",
      style: Theme.of(context)
          .textTheme
          .subtitle1!
          .copyWith(fontSize: 18, letterSpacing: 1, fontWeight: FontWeight.w800, color: CoffeeColors.kTitleColor),
    );
  }

  Expanded _treatName(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Text(widget.treat!.name!,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(fontSize: 18, letterSpacing: 1, fontWeight: FontWeight.w700, color: CoffeeColors.kTitleColor)),
    );
  }

  Expanded _treatPrice(BuildContext context, Size size) {
    return Expanded(
      flex: 1,
      child: Text("${widget.treat!.price!} TL",
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
              fontSize: 16,
              letterSpacing: 1,
              fontWeight: FontWeight.w600,
              color: CoffeeColors.kTitleColor.withOpacity(.8))),
    );
  }

  ElevatedButton _checkoutButton(
    CheckoutViewModel model,
  ) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: CoffeeColors.kTitleColor,
          padding: const EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          model.postOrder();
        },
        child: const Text("Checkout Price"));
  }
}

_buildBackground() {
  return Column(
    children: [
      Expanded(
        flex: 1,
        child: BackgroundDecoration(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [CoffeeColors.kBrownColor.withOpacity(.3), CoffeeColors.kBrownColor.withOpacity(0.1)]),
      ),
      Expanded(
        flex: 1,
        child: BackgroundDecoration(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [CoffeeColors.kBrownColor.withOpacity(.3), CoffeeColors.kBrownColor.withOpacity(0.1)]),
      ),
    ],
  );
}
