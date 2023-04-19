import 'package:coffe_app/common/constants/coffee_colors.dart';
import 'package:coffe_app/common/constants/coffee_padding.dart';
import 'package:coffe_app/common/constants/router_constants.dart';
import 'package:coffe_app/common/constants/text_const.dart';
import 'package:coffe_app/common/widgets/app_bar_widget.dart';
import 'package:coffe_app/common/widgets/background_decoration.dart';
import 'package:coffe_app/locator.dart';
import 'package:coffe_app/main.dart';
import 'package:coffe_app/network/models/coffee.dart';
import 'package:coffe_app/network/services/coffee/coffee_services.dart';
import 'package:coffe_app/ui/base/base_view.dart';
import 'package:coffe_app/ui/coffe_detail/view_model/coffee_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class CoffeeDetailView extends StatefulWidget {
  final Coffee? coffee;
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
        onModelReady: (p0) => p0.getCoffee(widget.coffee!.id!, widget.coffee!.coffeeSize!),
        builder: (context, value, widget) => value.busy
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                appBar: const CustomAppBar(),
                body: Stack(
                  fit: StackFit.expand,
                  clipBehavior: Clip.none,
                  children: [
                    _buildBackground(),
                    Padding(
                        padding: const EdgeInsets.all(25),
                        child: Column(
                          verticalDirection: VerticalDirection.up,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: _coffeeButton(context, value),
                            ),
                            const SizedBox(
                              height: 100,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _coffeeIconsAndSize(context, value),
                                const SizedBox(
                                  height: 20,
                                ),
                                _coffeSizeChoiceList(context, value),
                              ],
                            ),
                            _alignPrice(context, value),
                            const Spacer(),
                            _description(context),
                            const SizedBox(
                              height: 20,
                            ),
                            _coffeeName(
                              size,
                              context,
                            )
                          ],
                        )),
                    _positionedImage(size, value)
                  ],
                ),
              ),
        //  onModelReady: (p0) => p0.getCoffee(widget.coffee!.id!),
        model: CoffeeDetailViewModel(
          coffeeServices: locator<CoffeeServices>(),

          // listCoffee: Provider.of<CheckoutViewModel>(context).order!.coffeeList,
        ));
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
          value.addList();
          Navigator.pushNamed(context, RouteConst.sweetTreatsView, arguments: value.coffee);
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

  Row _coffeeIconsAndSize(BuildContext context, CoffeeDetailViewModel model) {
    return Row(
      children: [
        const Icon(
          FeatherIcons.coffee,
          color: CoffeeColors.kTitleColor,
          size: 30,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          model.coffee?.coffeeSize == 'M'
              ? "Medium"
              : model.coffee?.coffeeSize == 'L'
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
                  model.getCoffee(
                      model.coffee!.id!, sizeCoffe); // Kahvelerin hangi boyuttda olduğuna göre fiyatı belirtiyor.
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: CoffeePading.instance.mediumHorizontalLowVertical,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: model.coffee?.coffeeSize == sizeCoffe ? CoffeeColors.kTitleColor : Colors.transparent,
                    border: Border.all(
                      color: model.coffee?.coffeeSize != sizeCoffe ? CoffeeColors.kTitleColor : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: _animatedTextCoffeeSize(context, model, sizeCoffe),
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
          color: model.coffee?.coffeeSize != sizeCoffe ? CoffeeColors.kTitleColor : Colors.white),
      child: Text(
        sizeCoffe,
      ),
    );
  }

  Align _alignPrice(BuildContext context, CoffeeDetailViewModel model) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        "${model.coffee?.coffeeSize == 'M' ? widget.coffee?.mediumPrice : model.coffee?.coffeeSize == 'L' ? widget.coffee?.largePrice : widget.coffee!.smallPrice}",
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
            scale: model.coffee?.coffeeSize == 'M'
                ? 1.36
                : model.coffee?.coffeeSize == 'L'
                    ? 1.5
                    : 1.2,
            curve: Curves.easeOutBack,
            alignment: Alignment.center,
            child: Image.asset(
              "assets/coffee/GLASS-1.png",
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
          flex: 1,
          child: BackgroundDecoration(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [CoffeeColors.kBrownColor.withOpacity(.7), CoffeeColors.kBrownColor.withOpacity(0.0)]),
        ),
        Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [CoffeeColors.kBrownColor.withOpacity(0.5), CoffeeColors.kBrownColor.withOpacity(0.0)])),
            ))
      ],
    );
  }
}
