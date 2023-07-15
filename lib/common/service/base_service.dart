import '../../network/init/network_manager.dart';

abstract class BaseService {
  var coreDio = NetworkManager.instance!.coreDio;
}
