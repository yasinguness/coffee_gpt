import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../common/constants/coffee_colors.dart';
import '../../../common/constants/coffee_padding.dart';
import '../../../common/constants/text_const.dart';
import '../../../common/widgets/app_bar_widget.dart';
import '../../../common/widgets/background_decoration.dart';
import '../../../network/models/product/product.dart';
import '../../../router/app_router.dart';
import 'treats_list_view.dart';

@RoutePage()
class SweetTreatsView extends StatefulWidget {
  final ProductModel? produtModel;
  const SweetTreatsView({
    super.key,
    this.produtModel,
  });

  @override
  State<SweetTreatsView> createState() => _SweetTreatsViewState();
}

class _SweetTreatsViewState extends State<SweetTreatsView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Stack(
        children: [
          _buildBackground(),
          TreatsListView(productModel: widget.produtModel!),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: CoffeePading.instance.high,
              child: SizedBox(
                height: size.height * 0.25,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(flex: 1, child: _coffeNameText(context)),
                    Expanded(flex: 1, child: _questionText(context)),
                    Expanded(flex: 2, child: _noThanksButton()),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Hero _coffeNameText(BuildContext context) {
    return Hero(
        tag: "name${widget.produtModel!.name!.toString()}", //CoffeNameTag
        child: Text(
          widget.produtModel!.name!,
          style: Theme.of(context).textTheme.displayLarge,
          textAlign: TextAlign.right,
        ));
  }

  Text _questionText(BuildContext context) {
    return Text(
      TextConst.instance.treatText,
      textAlign: TextAlign.right,
      style: Theme.of(context).textTheme.displayLarge!.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: CoffeeColors.kTitleColor.withOpacity(0.5),
          ),
    );
  }

  Align _noThanksButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () {
          context.router.push(const CheckoutRoute());
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: CoffeeColors.kTitleColor,
          padding: CoffeePading.instance.highHorizontalHighVertical,
          alignment: Alignment.centerLeft,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        child: Text(TextConst.instance.noThanks),
      ),
    );
  }
}

_buildBackground() {
  return Column(
    children: [
      Expanded(
        flex: 1,
        child: BackgroundDecoration(
            end: Alignment.topLeft,
            begin: Alignment.bottomRight,
            stops: const [0.0, .50],
            colors: [CoffeeColors.kBrownColor.withOpacity(.7), CoffeeColors.kBrownColor.withOpacity(0.0)]),
      ),
      Expanded(
        flex: 1,
        child: BackgroundDecoration(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: const [0.0, .4],
            colors: [CoffeeColors.kBrownColor.withOpacity(.5), CoffeeColors.kBrownColor.withOpacity(0.0)]),
      ),
    ],
  );
}
