import 'package:coffe_app/network/services/api.dart';
import 'package:coffe_app/ui/treats/view_model/treats_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [...independentServices, ...dependentServices, ...uiConsumableProviders];
List<SingleChildWidget> independentServices = [Provider.value(value: Api())];

List<SingleChildWidget> dependentServices = [];
List<SingleChildWidget> uiConsumableProviders = [
  StreamProvider(create: (context) => Provider.of<TreatsViewModel>(context).streamInd, initialData: null)
];
