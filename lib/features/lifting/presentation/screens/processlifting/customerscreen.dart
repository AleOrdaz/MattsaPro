import 'package:appmattsa/config/config.dart';
import 'package:appmattsa/shared/widgets/replacehelpformflied.dart';
import 'package:appmattsa/singleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../shared/shared.dart';
import '../../../liftings.dart';
import '../serviceslifting/signaturePage.dart';

class CustomerScreen extends ConsumerWidget {
  final String liftingId;
  static const name = "customer_lifting";
  const CustomerScreen({super.key, required this.liftingId});

  void showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Levantamiento Actualizado')));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customerState = ref.watch(customerProvider(liftingId));

    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      backgroundColor: AppTheme.whiteMattsaLight,
      appBar: CustomAppBar(title: "Nuevo levantamiento"),
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      body: customerState.isLoading
          ? const FullScreenLoading()
          : _CustomerView(lifting: customerState.lifting!,tap: () {

            if (customerState.lifting == null) return;

            ref.read(customerFormProvider(customerState.lifting!).notifier)
                .onFormSubmit().then((value) {
              if (value==-1) return;
              showSnackbar(context);
              context.push('/lifting/status/$value');
            });

          },),
      // customerForm.isloadingzone ?

      // CustomDropdownField(
      //   dropdownItems: getzones(customerForm.zones!),
      //   // initialValue: "prueba",
      //   label: "customers",
      //   onChanged: (String? po) {
      //      String f = "Fer";
      //   },
      // ): CircularProgressIndicator(),
      // floatingActionButton: FloatingActionButton(
      //     onPressed: () {

      //       if (customerState.lifting == null) return;

      //       ref
      //           .read(customerFormProvider(customerState.lifting!).notifier)
      //           .onFormSubmit()
      //           .then((value) {
      //         if (value==-1) return;
      //         showSnackbar(context);
      //         context.push('/lifting/status/$value');
      //       });

      //     },
      //     child: const Icon(Icons.save_as_outlined)),
    );
  }
}

class _CustomerView extends ConsumerWidget {
  final Lifting lifting;
  final void Function()? tap;
  const _CustomerView({required this.lifting, this.tap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customerForm = ref.watch(customerFormProvider(lifting));

    final sent = customerForm.isFormValid;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                /*Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: buttonNext("Creacion de cliente",
                      Icons.adf_scanner_rounded, context, "/mainlifting", 20),
                ),*/
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 15),
                  child: CustomTextFormFieldReplace(
                    borderRadius: 8, 
                    label: 'Nombre',
                    initialValue: singleton.nuevoLevantamineto ? "" : customerForm.name.value,
                    onChanged: ref
                        .read(customerFormProvider(lifting).notifier)
                        .onTitleChanged,
                    errorMessage: customerForm.isFormValid == true
                        ? customerForm.name.errorMessage
                        : null,
                  ),
                ),
                customerForm.isloadingzone
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 15),
                        child: CustomDropdownField(
                          isBottomField: true,
                          isTopField: true,
                          valor: 34,
                          dropdownItems: getzones(customerForm.zones!),
                          // initialValue: "prueba",
                          label: "Zonas",
                          initialValue: customerForm.idZone != null &&
                                  customerForm.idZone != -1
                              ? customerForm.idZone.toString()
                              : null,
                          onChanged: ref
                              .read(customerFormProvider(lifting).notifier)
                              .onZoneChange,
                          errorMessage: customerForm.isFormValid == true
                              ? ref
                                  .read(
                                      customerFormProvider(lifting).notifier)
                                  .validate("Zone")
                              : null,
                        ),
                      )
                    : CircularProgressIndicator(),
                customerForm.isloadingcustomer
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 15),
                        child: CustomDropdownField(
                          isBottomField: true,
                          isTopField: true,
                          valor: 28,
                          dropdownItems: getcustomers(customerForm.clientes!),
                          // initialValue: "prueba",
                          initialValue: customerForm.idCliente != null &&
                                  customerForm.idCliente != -1
                              ? customerForm.idCliente.toString().length > 30 ?
                              '${customerForm.idCliente.toString().substring(0, 28)}...' :
                          customerForm.idCliente.toString() : null,
                          label: "Clientes",
                          onChanged: ref
                              .read(customerFormProvider(lifting).notifier)
                              .onCustomerChange,
                          errorMessage: customerForm.isFormValid == true
                              ? ref
                                  .read(
                                      customerFormProvider(lifting).notifier)
                                  .validate("customer")
                              : null,
                        ),
                      )
                    : CircularProgressIndicator(),
                customerForm.isloadinghorno
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 15),
                        child: CustomDropdownField(
                          isBottomField: true,
                          isTopField: true,
                          valor: 34,
                          dropdownItems: getovens(customerForm.hornos!),
                          initialValue: customerForm.idHorno != null &&
                                  customerForm.idHorno != -1
                              ? customerForm.idHorno.toString()
                              : null,
                          label: "Equipos",
                          onChanged: ref
                              .read(customerFormProvider(lifting).notifier)
                              .onHornoChange,
                          errorMessage: customerForm.isFormValid
                              ? ref
                                  .read(
                                      customerFormProvider(lifting).notifier)
                                  .validate("equipos")
                              : null,
                        ),
                      )
                    : CircularProgressIndicator(),

                customerForm.isloadingparts
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 15),
                        child: CustomDropdownField(
                          isBottomField: true,
                          isTopField: true,
                          valor: 34,
                          dropdownItems: getparts(customerForm.parts!),
                          initialValue: customerForm.idPart != null &&
                                  customerForm.idPart != -1
                              ? customerForm.idPart.toString()
                              : null,
                          label: "Partes",
                          onChanged: ref
                              .read(customerFormProvider(lifting).notifier)
                              .onPartChange,
                          errorMessage: customerForm.isFormValid
                              ? ref
                                  .read(
                                      customerFormProvider(lifting).notifier)
                                  .validate("partes")
                              : null,
                        ),
                      )
                    : CircularProgressIndicator(),
                customerForm.isloadingdirection
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 15),
                        child: CustomDropdownField(
                          isBottomField: true,
                          isTopField: true,
                          valor: 30,
                          dropdownItems:
                              getdirection(customerForm.direcciones!),
                          initialValue: customerForm.idDireccion != null &&
                                  customerForm.idDireccion != -1
                              ? customerForm.idDireccion.toString()
                              : null,
                          label: "Dirección",
                          onChanged: ref
                              .read(customerFormProvider(lifting).notifier)
                              .onDirectionChange,
                          errorMessage: customerForm.isFormValid == true
                              ? ref
                                  .read(
                                      customerFormProvider(lifting).notifier)
                                  .validate("direcciones")
                              : null,
                        ),
                      )
                    : CircularProgressIndicator(),
                customerForm.isloadingservice
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 15),
                        child: CustomDropdownField(
                          isBottomField: true,
                          isTopField: true,
                          valor: 34,
                          dropdownItems: getservices(customerForm.servicios!),
                          initialValue: customerForm.idServicio != null &&
                                  customerForm.idServicio != -1
                              ? customerForm.idServicio.toString()
                              : null,
                          label: "Servicios",
                          onChanged: ref
                              .read(customerFormProvider(lifting).notifier)
                              .onServiceChange,
                          errorMessage: customerForm.isFormValid == true
                              ? ref
                                  .read(
                                      customerFormProvider(lifting).notifier)
                                  .validate("servicio")
                              : null,
                        ),
                      )
                    : CircularProgressIndicator(),
                SizedBox(
                  height: 200,
                )
              ],
            ),
          ),
          
          Positioned(
            left: 20,
            right: 20,
            bottom: 8,
            child: !customerForm.isPosting? buttonNextTwo(
              "Siguiente",
              Icons.arrow_forward_ios_outlined,
              context,
              "/mainlifting",
              20,
              tap
            ): const Center(child: CircularProgressIndicator()),
          )
        ],
      ),
    );
  }
}

// class CustomerScreen extends ConsumerStatefulWidget {
//   final String liftingId;
//   static const name = "customer_lifting";
//   const CustomerScreen({super.key, required this.liftingId});

//   @override
//   CustomerScreenState createState() => CustomerScreenState();
// }

// class CustomerScreenState extends ConsumerState<CustomerScreen> {
//   @override
//   void initState() {
//     super.initState();
//     ref.read(customerProvider(widget.liftingId).notifier);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final scaffoldKey = GlobalKey<ScaffoldState>();
//     return Scaffold(
//       appBar: CustomAppBar(),
//       drawer: SideMenu(scaffoldKey: scaffoldKey),
//       body: Center(
//         child: Text(widget.liftingId),
//       ),
//     );
//   }
// }
