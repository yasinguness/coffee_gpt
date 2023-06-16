import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class CoffeeLoader extends StatefulWidget {
  const CoffeeLoader({super.key});

  @override
  State<CoffeeLoader> createState() => _CoffeeLoaderState();
}

class _CoffeeLoaderState extends State<CoffeeLoader> {
  Artboard? _artboard;
  RiveAnimationController? _controller;
  SMIInput<int>? _progressInput;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadRiveFile();
  }

  Future<void> _loadRiveFile() async {
    final bytes = await DefaultAssetBundle.of(context).load("assets/rive/coffee_loader.riv");
    final file = RiveFile.import(bytes);
    _artboard = file.mainArtboard;
    var controller = StateMachineController.fromArtboard(_artboard!, "State Machine");
    if (controller != null) {
      _artboard!.addController(controller);

      _progressInput = controller.findInput<int>('numLoader');
    }
    //_controller = SimpleAnimation('animation_name');
    setState(() {
      for (var i = 0; i < 100; i++) {
        _progressInput?.value++;
        print(_progressInput?.value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _artboard != null
        ? Container(
            color: Colors.transparent,
            child: Rive(
              artboard: _artboard!,
              fit: BoxFit.fitHeight,
            ))
        : const CircularProgressIndicator();
  }
}
