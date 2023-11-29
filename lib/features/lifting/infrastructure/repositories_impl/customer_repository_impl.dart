import 'package:appmattsa/features/lifting/domain/domain.dart';

import '../infractructure.dart';

class CustomerRepository_impl extends CustomerRepository {
  final CustomerDataUseCase useCase;
  CustomerRepository_impl({CustomerDataUseCase? useCase})
      : useCase = useCase ?? CustomerApi();

  @override
  Future<int> createClient(int idCustomer, int idOven, int idDireccion,
      String service, String name, int idArea) {
    return useCase.createClient(
        idCustomer, idOven, idDireccion, service, name, idArea);
  }

  @override
  Future<List<Customer>> getAllCustomer() {
    return useCase.getAllCustomer();
  }

  @override
  Future<List<Customer>> getCustomerZone(int idZone) {
    return getCustomerZone(idZone);
  }

  @override
  Future<List<Direccion>> getDirection(int idCustomer) {
    return getDirection(idCustomer);
  }

  @override
  Future<List<ZoneC>> getZones() {
    return getZones();
  }

  @override
  List<Customer> getone() {
    return getone();
  }

  @override
  Future<int> updateClient(int idCustomer, int idOven, int idDireccion,
      String service, String name, int idArea, int idLifting) {
    return useCase.updateClient(
        idCustomer, idOven, idDireccion, service, name, idArea, idLifting);
  }
}
