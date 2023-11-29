import 'package:appmattsa/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../shared/shared.dart';
import '../../../liftings.dart';
import 'widgets/widgets.dart';

class EvidenceScreen extends ConsumerWidget {
  const EvidenceScreen({super.key, required this.idLifting});
  static const name = "evidence_lifting";
  final String idLifting;

  void showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Evidencia actualizada')));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final evidenceState = ref.watch(evidenceProvider(idLifting));
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      backgroundColor: AppTheme.whiteMattsaLight,
      appBar: CustomAppBar(title: "Evidencias"),
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      body: evidenceState.isLoading
          ? const FullScreenLoading()
          : _EvidenceScreen(
              lifting: evidenceState.lifting!,
            ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppTheme.blueMattsa,
          onPressed: () async {
            showSnackbar(context);
            context.push('/lifting/actividades/${evidenceState.lifting!.id}');
            // ref.read(StatusFormProvider(statusState.lifting!).notifier).onsubmit();
          },
          label: const Text(
            "Guardar Evidencias",
            style: TextStyle(color: AppTheme.whiteMattsaLight, fontWeight: FontWeight.bold),
          ),
          icon: const Icon(Icons.save_as_outlined, color: AppTheme.whiteMattsaLight,),
      ),
    );
  }
}

class _EvidenceScreen extends ConsumerWidget {
  final Lifting lifting;
  const _EvidenceScreen({
    required this.lifting,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final evidenceForm = ref.watch(EvidenceFormProvider(lifting));
    final evidenceFormNotifier =
        ref.watch(EvidenceFormProvider(lifting).notifier);

    return evidenceForm.isLoading ? const FullScreenLoading() : ListView.builder(
      padding: EdgeInsets.only(bottom: 80),
        itemCount: evidenceForm.evidencecompleta!.length,
        itemBuilder: (context, index) {
        final s = evidenceForm.evidencecompleta![index];
        final au = auxiliar();
        au.idSemaforo = s.sem.idSemaforo;
        return Column(
          children: [
            SemaforoSection(
              color: getColor(s.sem.idSemaforo.toString()),
              description: s.sem.description,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ExpansionCustomNew(
                evidence: evidenceForm,
                evidencenotifier: evidenceFormNotifier,
                colorwords: Colors.black,
                color: Colors.white,
                getlistitems: s.myclase!,
              ),
            ),
          ],
        );
      });
  }
}
