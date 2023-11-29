import 'dart:io';

import 'package:appmattsa/features/lifting/domain/domain.dart';
import 'package:appmattsa/features/lifting/domain/models/entregables.dart';
import 'package:appmattsa/features/lifting/domain/models/ot.dart';

import '../infractructure.dart';

class LiftingRepository_impl extends LiftingRepository {
  final LiftingDataUseCase useCase;

  LiftingRepository_impl({LiftingDataUseCase? useCase})
      : useCase = useCase ?? LiftingApi();

  @override
  Future<int> createSemaforo(int clase, int semaforo, int idlifting) {
    return useCase.createSemaforo(clase, semaforo, idlifting);
  }

  @override
  Future<List<Clase>> getAllClases() {
    return useCase.getAllClases();
  }

  @override
  Future<List<NewExt>> getAllLift(int idlifting) {
    return useCase.getAllLift(idlifting);
  }

  @override
  Future<List<SemaforoAux>> getAllLiftSemaforo(int idlifting) {
    return useCase.getAllLiftSemaforo(idlifting);
  }

  @override
  Future<List<Clase>> getClassSemaforo(int idlifting, int idSemaforo) {
    // TODO: implement getClassSemaforo
    throw UnimplementedError();
  }

  @override
  Future<List<Liftingevidence>> getEvidences(int idLifting, int idClass) {
    // TODO: implement getEvidences
    throw UnimplementedError();
  }

  @override
  Future<List<Lifting>> getLiftings() {
    // TODO: implement getLiftings
    throw UnimplementedError();
  }

  @override
  Future<List<Semaforo>> getSemaforoLift(int idlifting) {
    // TODO: implement getSemaforoLift
    throw UnimplementedError();
  }

  @override
  Future<List<LiftingSemaforo>> getSemaforoLiftLink(int idlifting) {
    return useCase.getSemaforoLiftLink(idlifting);
  }

  @override
  Future<int> setCommentAct(int idlifting, String comentario) {
    return useCase.setCommentAct(idlifting, comentario);
  }

  @override
  Future<int> updateComentarioevidence(int idEvidence, String comentario) {
    return useCase.updateComentarioevidence(idEvidence, comentario);
  }

  @override
  Future<String> uploadImage(
      File imageFile, int idLifting, int idClass, String comentario) {
    return useCase.uploadImage(imageFile, idLifting, idClass, comentario);
  }

  @override
  Future<List<Lifting>> getLiftingsnextPage(
      int limit, int offset, String token, int idUser) {
    return useCase.getLiftingsnextPage(limit, offset, token, idUser);
  }

  @override
  Future<Lifting> getLift(int idlifting, String token, int idUser) {
    return useCase.getLift(idlifting, token, idUser);
  }

  @override
  Future<List<Customer>> getAllCustomer(String token) {
    return useCase.getAllCustomer(token);
  }

  @override
  Future<List<Oven>> getAllOvens(int id, String token) {
    return useCase.getAllOvens(id, token);
  }

  @override
  Future<List<Service>> getAllServices(String token) {
    return useCase.getAllServices(token);
  }

  @override
  Future<List<Customer>> getCustomerZone(int idZone, String token) {
    return useCase.getCustomerZone(idZone, token);
  }

  @override
  Future<List<Direccion>> getDirection(int idCustomer, String token) {
    return useCase.getDirection(idCustomer, token);
  }

  @override
  Future<List<ZoneC>> getZones(String token) {
    return useCase.getZones(token);
  }

  @override
  Future<String> gettypeoven(int id, String token) {
    return useCase.gettypeoven(id, token);
  }

  @override
  Future<Lifting> createUpdateProduct(Map<String, dynamic> productLike) {
    return useCase.createUpdateProduct(productLike);
  }

  @override
  Future<List<Clase>> getClasesOven(int idOven, String token) {
    return useCase.getClasesOven(idOven, token);
  }

  @override
  Future<List<Semaforo>> getSemaforo(String token) {
    return useCase.getSemaforo(token);
  }

  @override
  Future<bool> createUpdateStatus(
      Map<String, dynamic> statusLike, String token) {
    return useCase.createUpdateStatus(statusLike, token);
  }

  @override
  Future<List<Lifting>> getServicesnextPage(
      int limit, int offset, String token, int idUser) {
    return useCase.getServicesnextPage(limit, offset, token, idUser);
  }

  @override
  Future<List<OtDocument>> getDocumentot(int liftingid) {
    return useCase.getDocumentot(liftingid);
  }

  @override
  Future<List<NewExt>> getAllLiftAfter(int idlifting) {
    return useCase.getAllLiftAfter(idlifting);
  }

  @override
  Future<String> uploadImageafter(
      File imageFile, int idLifting, int idClass, String comentario) {
    return useCase.uploadImageafter(imageFile, idLifting, idClass, comentario);
  }

  @override
  Future<List<Linea>> getOvenparts(int idOven) {
    return useCase.getOvenparts(idOven);
  }

  @override
  Future<List<OtDocument>> getDocumentremision(int liftingid) {
    return useCase.getDocumentremision(liftingid);
  }

  @override
  Future<List<Entregable>> getEntregables(int liftingid) {
    return useCase.getEntregables(liftingid);
  }

  @override
  Future<bool> updatestate(int idlifting, String token, int idUser) {
    return useCase.updatestate(idlifting, token, idUser);
  }
}
