import '../domain.dart';

abstract class CustomerDataUseCase {
  Future<List<Customer>> getAllCustomer();

  Future<List<Direccion>> getDirection(int idCustomer);

  List<Customer> getone();

  Future<List<Customer>> getCustomerZone(int idZone);

  Future<List<ZoneC>> getZones();

  Future<int> createClient(
      int idCustomer, int idOven, int idDireccion, String service, String name,int idArea);

  Future<int> updateClient(
      int idCustomer, int idOven, int idDireccion, String service, String name,int idArea,int idLifting);
}
