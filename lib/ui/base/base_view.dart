import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseView<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T value, Widget? widget) builder;
  final T model;
  final Widget? child;
  final Function(T)? onModelReady;
  const BaseView({super.key, required this.builder, required this.model, this.child, this.onModelReady});

  @override
  State<BaseView<T>> createState() => _BaseViewState();
}

class _BaseViewState<T extends ChangeNotifier> extends State<BaseView<T>> {
  late T model;
  @override
  void initState() {
    model = widget.model;
    if (widget.onModelReady != null) {
      widget.onModelReady!(model);
    }
    super.initState();
  }

  @override
  void dispose() {
    print('I have been disposed!!');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) => model,
      child: Consumer<T>(builder: widget.builder, child: widget.child),
    );
  }
}
