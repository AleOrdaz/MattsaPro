import 'package:appmattsa/features/auth/domain/domain.dart';
import 'package:appmattsa/features/lifting/liftings.dart';
import 'package:appmattsa/features/lifting/presentation/screens/serviceslifting/signaturePage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

import '../../../../../../shared/shared.dart';

final customerFormProvider = StateNotifierProvider.autoDispose
    .family<CustomerFormNotifier, CustomerFormState, Lifting>((ref, lifting) {
  final createUpdateCallback =
      ref.watch(productsProvider.notifier).createOrUpdateProduct;
  final User user;
  //TODO: createdUpdateCallBack
  final productsRepository = ref.watch(productsRepositoryProvider);
  return CustomerFormNotifier(
    lifting: lifting,
    liftingRepository: productsRepository,
    onSubmitCallback: createUpdateCallback,
  );
});

class CustomerFormNotifier extends StateNotifier<CustomerFormState> {
  final LiftingRepository liftingRepository;
  final Future<int> Function(Map<String, dynamic> customerLike)?
      onSubmitCallback;

  CustomerFormNotifier({
    required this.liftingRepository,
    this.onSubmitCallback,
    required Lifting lifting,
  }) : super(CustomerFormState(
          idLifting: lifting.id.toString(),
          idZone: lifting.idArea,
          idCliente: lifting.idCustomer,
          idDireccion: lifting.idDomicilio,
          idHorno: lifting.idOven,
          idServicio: lifting.idService,
          idPart: lifting.idPart,
          idKam: singleton.idUser,
        )) {
    zoneCharge();
    serviceCharge();
    chargeLastlifting(lifting);
  }

  Future<int> onFormSubmit() async {
    if (onSubmitCallback == null) {
      state = state.copyWith(
        isFormValid: true,
      );
      return -1;
    }

    if (state.idCliente == -1 || state.idCliente == null ||
        state.idHorno == -1 || state.idHorno == null ||
        state.idZone == -1 || state.idZone == null ||
        state.idDireccion == -1 || state.idDireccion == null ||
        state.idServicio == -1 || state.idServicio == null ||
        state.idPart == -1 || state.idPart == null || !state.name.isValid) {
      state = state.copyWith(
        isFormValid: true,
      );
      return -1;
    }

    final customerLike = {
      'id': (state.idLifting == '-1') ? null : state.idLifting,
      'id_custumer': state.idCliente,
      'id_oven': state.idHorno,
      'id_area': state.idZone,
      'id_domicilio': state.idDireccion,
      'service_type': state.idServicio,
      'id_line': state.idPart,
      'name': state.name.value,
      'id_kam': singleton.idUser
    };

    state = state.copyWith(
      isPosting: true,
    );

    final res = await onSubmitCallback!(customerLike);
    state = state.copyWith(
      isPosting: false,
    );

    return res;
  }

  void onZoneChange(String? idzone) async {
    //TODO:verificacion de validacion de si se encuentra dentro los elementos en el onchage
    if (idzone == null) return;
    //TODO:una vez validado ahora si paso a cargar y reiniciar

    ///TODO:VALIDAR INITIAL VALUES CUANDO CAMBIAS POR QUE LO INTENTA COLOCAR Y YA NO EXISTE
    state = state.copyWith(
      isloadingcustomer: false,
      idZone: int.parse(idzone),
    );
    int idz = state.idZone ?? -1;
    final clientes = await liftingRepository.getCustomerZone(idz, "token");

    state = state.copyWith(
      isloadingcustomer: true,
      clientes: clientes,
      direcciones: [],
      hornos: [],
      idCliente: -1,
      idDireccion: -1,
      idHorno: -1,
    );

    //TODO:solicitar los customers
  }

  String? validate(String p) {
    if (p == "Zone") {
      if (state.idZone == -1) return "Campo obligatorio";
    }
    if (p == "customer") {
      if (state.idCliente == -1) return "Campo obligatorio";
    }
    if (p == "equipos") {
      if (state.idHorno == -1) return "Campo obligatorio";
    }
    if (p == "direcciones") {
      if (state.idDireccion == -1) return "Campo obligatorio";
    }
    if (p == "servicio") {
      if (state.idServicio == -1) return "Campo obligatorio";
    }
    if (p == "partes") {
      if (state.idPart == -1) return "Campo obligatorio";
    }
    return null;
  }

  Future zoneCharge() async {
    if (state.isloadingzone) return;

    final zones = await liftingRepository.getZones("token");
    state = state.copyWith(
      isloadingzone: true,
    );

    state = state.copyWith(
      zones: zones,
    );
  }

  void onCustomerChange(String? idcustomer) async {
    if (idcustomer == null) return;
    state = state.copyWith(
      isloadinghorno: false,
      isloadingdirection: false,
      idCliente: int.parse(idcustomer),
    );

    int auxcliente = state.idCliente ?? -1;

    final ovens = await liftingRepository.getAllOvens(auxcliente, "token");
    final direction = await liftingRepository.getDirection(auxcliente, "token");

    state = state.copyWith(
      isloadinghorno: true,
      isloadingdirection: true,
      direcciones: direction,
      hornos: ovens,
      idDireccion: -1,
      idHorno: -1,
    );

    // int idd = state.idDireccion ?? -1;
  }

  void chargeLastlifting(Lifting lift) async {
    if (lift.idArea == -1 || lift.idArea == null) {
      state = state.copyWith(
        isloadingcustomer: true,
        isloadingdirection: true,
        isloadinghorno: true,
        isloadingparts: true,
      );
      return;
    }

    state = state.copyWith(
        isloadingcustomer: false,
        isloadingdirection: false,
        isloadinghorno: false,
        isloadingparts: false,
        name: Title.dirty(lift.nameLifting));
    int idz = lift.idArea;
    final clientes = await liftingRepository.getCustomerZone(idz, "token");

    int auxcliente = lift.idCustomer ?? -1;

    final ovens = await liftingRepository.getAllOvens(auxcliente, "token");

//TODO:AQUI AGREGAR LA CARGA DE LA PARTE
    final parts = await liftingRepository.getOvenparts(lift.idOven ?? -1);

    final direction = await liftingRepository.getDirection(auxcliente, "token");

    state = state.copyWith(
      isloadingcustomer: true,
      isloadingdirection: true,
      isloadinghorno: true,
      isloadingparts: true,
      parts: parts,
      clientes: clientes,
      hornos: ovens,
      direcciones: direction,
    );
  }

  void onTitleChanged(String value) {
    state = state.copyWith(
      name: Title.dirty(value),
    );
  }

  void serviceCharge() async {
    if (state.isloadingservice) return;

    final services = await liftingRepository.getAllServices("token");
    state = state.copyWith(
      isloadingservice: true,
    );

    state = state.copyWith(
      servicios: services,
    );
  }

  void onDirectionChange(String? iddirection) {
    int aux = int.parse(iddirection ?? "-1");
    state = state.copyWith(idDireccion: aux);
  }

  void onHornoChange(String? idhorno) async {
    int aux = int.parse(idhorno ?? "-1");
    state = state.copyWith(idHorno: aux, isloadingparts: false);

    final parts = await liftingRepository.getOvenparts(aux);

    state = state.copyWith(isloadingparts: true, parts: parts);
  }

  void onPartChange(String? idPart) {
    int aux = int.parse(idPart ?? "-1");
    state = state.copyWith(idPart: aux);
  }

  void onServiceChange(String? idservice) {
    int aux = int.parse(idservice ?? "-1");
    state = state.copyWith(idServicio: aux);
  }
}

class CustomerFormState {
  final Title name;
  final bool isloadingservice;
  final bool isloadinghorno;
  final bool isloadingdirection;
  final bool isloadingcustomer;
  final bool isloadingzone;
  final bool isloadingparts;
  final bool isFormValid;
  final bool isPosting;
  final String? idLifting;
  final List<ZoneC>? zones;
  final List<Customer>? clientes;
  final List<Direccion>? direcciones;
  final List<Oven>? hornos;
  final List<Service>? servicios;
  final List<Linea>? parts;
  final int? idZone;
  final int? idCliente;
  final int? idDireccion;
  final int? idHorno;
  final int? idServicio;
  final int? idPart;
  final int? idKam;

  CustomerFormState(
      {this.name = const Title.dirty(''),
      this.isloadingservice = false,
      this.isPosting = false,
      this.isloadingdirection = false,
      this.isloadingparts = false,
      this.isloadinghorno = false,
      this.isloadingcustomer = false,
      this.isloadingzone = false,
      this.zones = const [],
      this.clientes = const [],
      this.direcciones = const [],
      this.hornos = const [],
      this.servicios = const [],
      this.parts = const [],
      this.isFormValid = false,
      this.idLifting,
      this.idZone,
      this.idCliente,
      this.idDireccion,
      this.idHorno,
      this.idPart,
      this.idServicio,
      this.idKam});

  CustomerFormState copyWith({
    Title? name,
    bool? isloadingservice,
    bool? isloadingdirection,
    bool? isloadinghorno,
    bool? isPosting,
    bool? isloadingcustomer,
    bool? isloadingzone,
    bool? isloadingparts,
    bool? isFormValid,
    String? idLifting,
    List<ZoneC>? zones,
    List<Customer>? clientes,
    List<Direccion>? direcciones,
    List<Oven>? hornos,
    List<Service>? servicios,
    List<Linea>? parts,
    int? idZone,
    int? idCliente,
    int? idDireccion,
    int? idHorno,
    int? idServicio,
    int? idPart,
    int? idKam,
  }) =>
      CustomerFormState(
        name: name ?? this.name,
        isPosting: isPosting ?? this.isPosting,
        isloadingservice: isloadingservice ?? this.isloadingservice,
        isloadinghorno: isloadinghorno ?? this.isloadinghorno,
        isloadingdirection: isloadingdirection ?? this.isloadingdirection,
        isloadingcustomer: isloadingcustomer ?? this.isloadingcustomer,
        isloadingzone: isloadingzone ?? this.isloadingzone,
        isloadingparts: isloadingparts ?? this.isloadingparts,
        isFormValid: isFormValid ?? this.isFormValid,
        idLifting: idLifting ?? this.idLifting,
        zones: zones ?? this.zones,
        clientes: clientes ?? this.clientes,
        direcciones: direcciones ?? this.direcciones,
        hornos: hornos ?? this.hornos,
        servicios: servicios ?? this.servicios,
        parts: parts ?? this.parts,
        idZone: idZone ?? this.idZone,
        idCliente: idCliente ?? this.idCliente,
        idDireccion: idDireccion ?? this.idDireccion,
        idHorno: idHorno ?? this.idHorno,
        idServicio: idServicio ?? this.idServicio,
        idPart: idPart ?? this.idPart,
        idKam: idKam ?? this.idKam
      );
}
