import 'package:appmattsa/config/config.dart';
import 'package:appmattsa/features/lifting/presentation/screens/processlifting/widgets/dropdownconsumer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../shared/shared.dart';
import '../../../../../shared/widgets/dropdown_lifting_field_color.dart';
import '../../../liftings.dart';
import '../../presentations.dart';

class StatusScreen extends ConsumerWidget {
  static const name = "status_lifting";
  final String idLifting;
  const StatusScreen({super.key, required this.idLifting});

  void showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Estatus de levantamiento actualizado')));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusState = ref.watch(statusProvider(idLifting));

    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      backgroundColor: AppTheme.whiteMattsaLight,
      appBar: CustomAppBar(title: "Condición actual",),
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      body: statusState.isLoading
          ? const FullScreenLoading()
          : _StatusViewer(
              lifting: statusState.lifting!,
              tap:() {
                ref
                .read(StatusFormProvider(statusState.lifting!).notifier)
                .onsubmit()
                .then((value) {
              if (value) {
                showSnackbar(context);
                context.push('/lifting/evidence/${statusState.lifting!.idLifting}');
              }
            });
              },
            ),
      // floatingActionButton: FloatingActionButton(
      //     onPressed: () {
      //       ref
      //           .read(StatusFormProvider(statusState.lifting!).notifier)
      //           .onsubmit()
      //           .then((value) {
      //         if (value) {
      //           showSnackbar(context);
      //           context.push('/lifting/evidence/${statusState.lifting!.idLifting}');
      //         }
      //       });
      //     },
      //     child: const Icon(Icons.save_as_outlined)),
    );
  }
}

class _StatusViewer extends ConsumerWidget {
  final Lifting lifting;
  final void Function()? tap;
  const _StatusViewer({
    required this.lifting,
    this.tap
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusForm = ref.watch(StatusFormProvider(lifting));
    final statusFormNotifier = ref.watch(StatusFormProvider(lifting).notifier);
    return statusForm.isLoading
        ? const FullScreenLoading()
        : Stack(
          children: [Column(
            children: [
              /*Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top:10
                  ),
                  child: buttonNext("Condición actual",
                      Icons.note_alt_sharp, context, "/mainlifting", 20),
                ),*/
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(bottom: 80),
                    itemCount: statusForm.clases!.length,
                    itemBuilder: (context, index) {
                      final dropdownValue = ValueNotifier<String>('');
                      final dropdownData = statusForm.clases![index];
                      return DropdownConsumer(
                        statusfromstate: statusFormNotifier,
                        name: dropdownData.name,
                        index: dropdownData.idClase,
                        idClase: dropdownData.idClase,
                        errorMessage: statusForm.isFormValid
                            ? ref
                                .read(StatusFormProvider(lifting).notifier)
                                .validate(dropdownData.idClase)
                            : null,
                      );
                    }),
              ),
            ],
          ),
              Positioned(
            left: 20,
            right: 20,
            bottom: 8,
            child: !statusForm.isPosting? buttonNextTwo(
              "Siguiente",
              Icons.arrow_forward_ios_outlined,
              context,
              "/mainlifting",
              20,
              tap
            ): Center(child: CircularProgressIndicator()),
          )
              
              ]
        );
  }
}
