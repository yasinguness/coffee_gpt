import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseView<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T value, Widget? widget) builder;
  final T model;
  final Widget? child;
  final Function(T)? onModelReady;
  final VoidCallback? onDispose;
  final Function(T viewmodel)? onBackAction;
  final Function(T viewmodel)? didPopNext;
  final Function(T viewmodel, AppLifecycleState state)? onAppLifecycleChanged;
  final bool enableFocusControl;
  final RouteObserver<ModalRoute<void>>? routeObserver;

  const BaseView(
      {super.key,
      required this.builder,
      required this.model,
      this.child,
      this.onModelReady,
      this.onDispose,
      this.onBackAction,
      this.didPopNext,
      this.onAppLifecycleChanged,
      this.enableFocusControl = true,
      this.routeObserver});

  @override
  State<BaseView<T>> createState() => _BaseViewState();
}

class _BaseViewState<T extends ChangeNotifier> extends State<BaseView<T>> with WidgetsBindingObserver, RouteAware {
  late T model;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    model = widget.model;
    if (widget.onModelReady != null) {
      widget.onModelReady!(model);
    }
  }

  @override
  void dispose() {
    widget.routeObserver?.unsubscribe(this);
    if (widget.onDispose != null) {
      widget.onDispose!.call();
    }
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant BaseView<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.routeObserver?.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    widget.onAppLifecycleChanged?.call(widget.model, state);
  }

  @override
  void didPopNext() {
    super.didPopNext();
    if (widget.didPopNext != null) {
      widget.didPopNext!.call(widget.model);
    }
  }

  void changeFocus() {
    if (widget.enableFocusControl) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  Widget _willPopScopeWrapper({required Widget child}) {
    if (widget.onBackAction == null) {
      return child;
    } else {
      return WillPopScope(
        child: child,
        onWillPop: () async {
          return widget.onBackAction!.call(widget.model);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) => model,
      child: _willPopScopeWrapper(
          child: GestureDetector(onTap: changeFocus, child: Consumer<T>(builder: widget.builder, child: widget.child))),
    );
  }
}
