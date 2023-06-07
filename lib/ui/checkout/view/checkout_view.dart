import 'package:auto_route/auto_route.dart';
import 'package:coffe_app/common/constants/coffee_colors.dart';
import 'package:coffe_app/common/constants/text_const.dart';
import 'package:coffe_app/common/provider/basket_provider.dart';
import 'package:coffe_app/common/provider/coffe_provider.dart';
import 'package:coffe_app/common/provider/customer_provider.dart';
import 'package:coffe_app/common/widgets/app_bar_widget.dart';
import 'package:coffe_app/common/widgets/background_decoration.dart';
import 'package:coffe_app/locator.dart';
import 'package:coffe_app/network/models/order/order.dart';
import 'package:coffe_app/network/services/order/order_service.dart';
import 'package:coffe_app/router/app_router.dart';
import 'package:coffe_app/ui/base/base_view.dart';
import 'package:coffe_app/ui/checkout/view_model/checkout_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> with RouteAware {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BaseView<CheckoutViewModel>(
      //routeObserver: routeObserver,
      //onDispose: () => routeObserver.unsubscribe(this),
      builder: (context, value, wtg) {
        return value.busy
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _scaffold(context, size, value);
      },
      model: CheckoutViewModel(
        model: OrderModel(),
        orderServices: locator<OrderService>(),
        basketProvider: Provider.of<BasketProvider>(context),
        coffeeProvider: Provider.of<CoffeeProvider>(context),
        customerProvider: Provider.of<CustomerProvider>(context),
      ),
      //onModelReady: (p0) => p0.getCoffeePrice(),
    );
  }

  Scaffold _scaffold(BuildContext context, Size size, CheckoutViewModel value) {
    return Scaffold(
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
                _orderList(size, value),
                const Spacer(),
                Text(value.basketProvider!.totalPrice.toString()),
                _checkoutButton(value)
                /* coffee.price + (treat?.price ?? 0)).toStringAsFixed(2) */
              ],
            ),
          )
        ],
      ),
    );
  }

  ListView _orderList(Size size, CheckoutViewModel value) {
    return ListView.builder(
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
          ],
        );
      },
      itemCount: value.basketProvider!.basketProducts?.length,
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
        children: [
          _coffeImage(size, value, index),
          _coffeeNameAndQuantity(context, value, index),
          _coffeeSizeAndPrice(value, index, context),
        ],
      ),
    );
  }

  Expanded _coffeeSizeAndPrice(CheckoutViewModel value, int index, BuildContext context) {
    return Expanded(
      flex: 3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (value.basketProvider!.basketProducts?[index].product!.isSweet == "sweet") ...[
            const Spacer(flex: 1),
            _coffePrice(value, context, index)
          ] else ...[
            _coffeSize(value, context, index),
            _coffePrice(value, context, index)
          ]
        ],
      ),
    );
  }

  Expanded _coffeeNameAndQuantity(BuildContext context, CheckoutViewModel value, int index) {
    return Expanded(
        flex: 6,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [_coffeName(context, value, index), _quantity(value, index)]));
  }

  Expanded _quantity(CheckoutViewModel model, int index) {
    return Expanded(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => model.basketProvider!.decreaseQuantity(index),
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
              model.basketProvider!.quantity![index].toString(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          GestureDetector(
            onTap: () => model.basketProvider!.increaseQuantity(index),
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
      style: Theme.of(context).textTheme.displayLarge,
    );
  }

  Expanded _coffeImage(Size size, CheckoutViewModel model, int index) {
    return Expanded(
      flex: 2,
      child: Container(
        height: 50,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: Hero(
            tag: "nameCoffee$index", //CoffeImageTag
            child: Image.network(
              "${model.basketProvider!.basketProducts![index].product!.image}",
              fit: BoxFit.contain,
            )),
      ),
    );
  }

  Expanded _coffePrice(CheckoutViewModel model, BuildContext context, int index) {
    return Expanded(
      flex: 1,
      child: Text(
        //TODO: Price olayını düzelt
        (model.basketProvider!.basketProducts![index].currentPrice).toString(),

        style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontSize: 16,
            letterSpacing: 1,
            fontWeight: FontWeight.w600,
            color: CoffeeColors.kTitleColor.withOpacity(.8)),
      ),
    );
  }

  Expanded _coffeSize(CheckoutViewModel model, BuildContext context, int index) {
    return Expanded(
      flex: 1,
      child: Text(
        //TODO: Price olayını düzelt
        model.basketProvider!.basketProducts![index].selectedSize == null
            ? model.basketProvider!.basketProducts![index].selectedSize = 'M'
            : model.basketProvider!.basketProducts![index].selectedSize.toString(),
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontSize: 16,
            letterSpacing: 1,
            fontWeight: FontWeight.w600,
            color: CoffeeColors.kTitleColor.withOpacity(.8)),
      ),
    );
  }

  Tooltip _coffeName(BuildContext context, CheckoutViewModel model, int index) {
    return Tooltip(
      message: model.basketProvider!.basketProducts![index].product!.name.toString(),
      child: Text(
        model.basketProvider!.basketProducts![index].product!.name.toString(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontSize: 18, letterSpacing: 1, fontWeight: FontWeight.w800, color: CoffeeColors.kTitleColor),
      ),
    );
  }

  ElevatedButton _checkoutButton(CheckoutViewModel model) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: CoffeeColors.kTitleColor,
          padding: const EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () async {
          bool isSc = await model.postOrder();
          if (isSc) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(snackBar);

              await Future.delayed(const Duration(seconds: 2), () {
                const CircularProgressIndicator();
                context.router.removeUntil((route) => false);
                context.router.push(const CoffeeListRoute());
                //push(coffeeList) eski hali
              });
            }
          } else {
            if (mounted) {}
            ScaffoldMessenger.of(context).showSnackBar(snackBar2);
          }
        },
        child: const Text("Checkout Price"));
  }
}

const snackBar = SnackBar(
  content: Text("Siparişiniz başarıyla oluşturuldu, ana sayfaya yönlendiriliyorsunuz !"),
  backgroundColor: CoffeeColors.kBrownColor,
);

final snackBar2 = SnackBar(
  content: const Text("Hata ! Sipariş oluşturulamadı"),
  backgroundColor: Colors.red,
  action: SnackBarAction(
    textColor: Colors.white,
    label: "Ana Sayfaya Dön",
    onPressed: () {
      // Buraya Butona Tıklayınca Yapılacak Olaylar Yazılacak.
    },
  ),
);

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
