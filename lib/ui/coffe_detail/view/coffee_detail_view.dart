import 'package:coffe_app/common/constants/coffee_colors.dart';
import 'package:coffe_app/common/constants/router_constants.dart';
import 'package:coffe_app/network/models/coffee.dart';
import 'package:coffe_app/ui/base/base_view.dart';
import 'package:coffe_app/ui/coffe_detail/view_model/coffee_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';

class CoffeeDetailView extends StatefulWidget {
  final Coffee? coffee;
  const CoffeeDetailView({super.key, this.coffee});

  @override
  State<CoffeeDetailView> createState() => _CoffeeDetailViewState();
}

class _CoffeeDetailViewState extends State<CoffeeDetailView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BaseView<CoffeeDetailModel>(
        onModelReady: (p0) => p0.getCoffee(widget.coffee!.id!),
        builder: (context, value, widget) => value.busy
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                appBar: _appBar(context),
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
                              child: _coffeeButton(context),
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
        model: CoffeeDetailModel(api: Provider.of(context)));
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              FeatherIcons.shoppingBag,
              color: CoffeeColors.black,
              size: 30,
            ))
      ],
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context, "fromHome");
          },
          icon: const Icon(
            FeatherIcons.chevronLeft,
            color: CoffeeColors.black,
            size: 30,
          )),
    );
  }

  ElevatedButton _coffeeButton(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: CoffeeColors.kTitleColor,
          //padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          alignment: Alignment.centerLeft,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(context, RouteConst.sweetTreatsView, arguments: widget.coffee);
        },
        child: _elevatedButtonText(context));
  }

  Row _elevatedButtonText(BuildContext context) {
    return Row(
      children: [
        Text(
          "Add to cart",
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

  Row _coffeeIconsAndSize(BuildContext context, CoffeeDetailModel model) {
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
          model.sizeCoffee == 'M'
              ? "Medium"
              : model.sizeCoffee == 'L'
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

  Row _coffeSizeChoiceList(BuildContext context, CoffeeDetailModel model) {
    return Row(
      children: ['S', 'M', 'L']
          .map((sizeCoffe) => GestureDetector(
                onTap: () {
                  model.updateCoffeeSize(sizeCoffe);
                  print(model.sizeCoffee);
                  print("${model.isMedium}+ :medium");
                  print(model.isSmall);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: model.sizeCoffee == sizeCoffe ? CoffeeColors.kTitleColor : Colors.transparent,
                    border: Border.all(
                      color: model.sizeCoffee != sizeCoffe ? CoffeeColors.kTitleColor : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: _animatedTextCoffeeSize(context, model, sizeCoffe),
                ),
              ))
          .toList(),
    );
  }

  AnimatedDefaultTextStyle _animatedTextCoffeeSize(BuildContext context, CoffeeDetailModel model, String sizeCoffe) {
    return AnimatedDefaultTextStyle(
      duration: const Duration(milliseconds: 300),
      style: Theme.of(context).textTheme.subtitle1!.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: model.sizeCoffee != sizeCoffe ? CoffeeColors.kTitleColor : Colors.white),
      child: Text(
        sizeCoffe,
      ),
    );
  }

  Align _alignPrice(BuildContext context, CoffeeDetailModel model) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        "${model.sizeCoffee == 'M' ? widget.coffee!.mediumPrice : model.sizeCoffee == 'L' ? widget.coffee!.largePrice : widget.coffee!.smallPrice}",
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

  Positioned _positionedImage(Size size, CoffeeDetailModel model) {
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
            scale: model.sizeCoffee == 'M'
                ? 1.36
                : model.sizeCoffee == 'L'
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
          child: Container(
              decoration: BoxDecoration(
            gradient: LinearGradient(
              end: Alignment.topRight,
              begin: Alignment.bottomLeft,
              stops: const [0.0, .50],
              colors: [CoffeeColors.kBrownColor.withOpacity(.7), CoffeeColors.kBrownColor.withOpacity(0.0)],
            ),
          )),
        ),
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [CoffeeColors.kBrownColor.withOpacity(0.5), CoffeeColors.kBrownColor.withOpacity(0.0)])),
          ),
        )
      ],
    );
  }
}
