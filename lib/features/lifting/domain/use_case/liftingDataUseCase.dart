import 'dart:io';

import 'package:appmattsa/features/lifting/domain/models/entregables.dart';
import 'package:appmattsa/features/lifting/domain/models/ot.dart';

import '../domain.dart';

abstract class LiftingDataUseCase {
  LiftingDataUseCase();

  Future<List<Clase>> getAllClases();

  Future<int> createSemaforo(int clase, int semaforo, int idlifting);

  Future<List<Semaforo>> getSemaforoLift(int idlifting);

  Future<List<Clase>> getClassSemaforo(int idlifting, int idSemaforo);

  Future<String> uploadImage(
      File imageFile, int idLifting, int idClass, String comentario);
  Future<String> uploadImageafter(
      File imageFile, int idLifting, int idClass, String comentario);

  Future<List<Liftingevidence>> getEvidences(int idLifting, int idClass);

  Future<List<Lifting>> getLiftings();

  Future<List<LiftingSemaforo>> getSemaforoLiftLink(int idlifting);

  Future<List<NewExt>> getAllLift(int idlifting);

  Future<List<NewExt>> getAllLiftAfter(int idlifting);

  Future<int> updateComentarioevidence(int idEvidence, String comentario);

  Future<List<SemaforoAux>> getAllLiftSemaforo(int idlifting);

  Future<int> setCommentAct(int idlifting, String comentario);

  Future<List<Lifting>> getLiftingsnextPage(
      int limit, int offset, String token, int idUser);

  Future<Lifting> getLift(int idlifting, String token, int idUser);

  Future<List<Customer>> getAllCustomer(String token);

  Future<List<Customer>> getCustomerZone(int idZone, String zone);

  Future<List<ZoneC>> getZones(String token);

  Future<List<Direccion>> getDirection(int idCustomer, String token);

  Future<List<Oven>> getAllOvens(int id, String token);

  Future<String> gettypeoven(int id, String token);

  Future<List<Service>> getAllServices(String token);

  Future<Lifting> createUpdateProduct(Map<String, dynamic> productLike);

  Future<List<Clase>> getClasesOven(int idOven, String token);

  Future<List<Semaforo>> getSemaforo(String token);

  Future<bool> createUpdateStatus(
      Map<String, dynamic> statusLike, String token);

  Future<List<Lifting>> getServicesnextPage(
      int limit, int offset, String token, int idUser);


  Future<List<OtDocument>> getDocumentot(int liftingid);

  Future<List<Entregable>> getEntregables(int liftingid);

  Future<List<OtDocument>> getDocumentremision(int liftingid);

  Future<List<Linea>> getOvenparts(int idOven);

  Future<bool> updatestate(int idlifting, String token, int idUser);
}
