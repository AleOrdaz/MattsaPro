import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../config/theme/app_theme.dart';
import '../../../../../shared/shared.dart';
import '../../../liftings.dart';
import 'widgets/newexpansioncustomref.dart';

class ActividadesScreen extends ConsumerWidget {
  final String liftingId;
  static const name = "actividades_lifting";
  const ActividadesScreen({super.key, required this.liftingId});

  void showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Levantamiento Actualizado')));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityState = ref.watch(activityProvider(liftingId));

    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold (
      backgroundColor: AppTheme.whiteMattsaLight,
      appBar: CustomAppBar(title: "Actividades"),
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      body: activityState.isLoading
          ? const FullScreenLoading()
          : _ActividadesView(lifting: activityState.lifting!),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppTheme.blueMattsa,
          onPressed: () {
            ref.read(activityFormProvider(activityState.lifting!).notifier)
                .onFormSubmit().then((value) {
              if (value == -1) return;
              showSnackbar(context);
              context.push('/lifting/firts/report/${activityState.lifting!.idLifting}');
            });

            // if (customerState.lifting == null) return;

            // ref
            //     .read(customerFormProvider(customerState.lifting!).notifier)
            //     .onFormSubmit()
            //     .then((value) {
            //   if (value==-1) return;
            //   showSnackbar(context);
            //   context.push('/lifting/status/$value');
            // });
          },
          label: const Text(
            "Guardar y ver PDF de levantamiento",
            style: TextStyle(color: AppTheme.whiteMattsaLight, fontWeight: FontWeight.bold),
          ),
          icon: const Icon(Icons.picture_as_pdf, color: AppTheme.whiteMattsaLight,)),
    );
  }
}

class _ActividadesView extends ConsumerWidget {
  final Lifting lifting;
  const _ActividadesView({required this.lifting});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityForm = ref.watch(activityFormProvider(lifting));

    final sent = activityForm.isFormValid;
    return activityForm.isloading ? const FullScreenLoading() : Padding(
      padding: const EdgeInsets.only(top: 30),
      child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10),
                child:ExpansionCustomRef(
                      color: Colors.white,
                      colorwords: Colors.black,
                      getlistitems: [
                        SemaforoAuxS(
                            idSem: 1,
                            items: activityForm.informacion,
                            nameServ: 'prueba',
                          fecha: lifting.fechaUpdate!,
                        )
                      ],
                      bodywidget: Text("hola"),
                    ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10),
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: AppTheme.grayMattsa,
                    ),
                    borderRadius: BorderRadius.circular(20.0), //<-- SEE HERE
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Comentarios',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      CustomLiftingField(
                        maxLines: 8,
                        isBottomField: true,
                        isTopField: true,
                        label: '',
                        initialValue: activityForm.comentario.value,
                        onChanged: ref
                            .read(activityFormProvider(lifting).notifier)
                            .onTitleChanged,
                        errorMessage: activityForm.comentario.errorMessage,
                      ),
                    ],
                  )
                ),
              ),
            ],
          ),
        ),
    );
  }
}
