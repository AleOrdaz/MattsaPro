import '../../domain/domain.dart';

class CustomerApi extends CustomerDataUseCase{
  @override
  Future<int> createClient(int idCustomer, int idOven, int idDireccion, String service, String name, int idArea) {
    // TODO: implement createClient
    throw UnimplementedError();
  }

  @override
  Future<List<Customer>> getAllCustomer() {
    // TODO: implement getAllCustomer
    throw UnimplementedError();
  }

  @override
  Future<List<Customer>> getCustomerZone(int idZone) {
    // TODO: implement getCustomerZone
    throw UnimplementedError();
  }

  @override
  Future<List<Direccion>> getDirection(int idCustomer) {
    // TODO: implement getDirection
    throw UnimplementedError();
  }

  @override
  Future<List<ZoneC>> getZones() {
    // TODO: implement getZones
    throw UnimplementedError();
  }

  @override
  List<Customer> getone() {
    // TODO: implement getone
    throw UnimplementedError();
  }

  @override
  Future<int> updateClient(int idCustomer, int idOven, int idDireccion, String service, String name, int idArea, int idLifting) {
    // TODO: implement updateClient
    throw UnimplementedError();
  }

}