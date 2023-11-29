import 'package:appmattsa/config/config.dart';
import 'package:appmattsa/features/lifting/presentation/providers/evidenceliftingafter/evidence_provider.dart';
import 'package:appmattsa/features/lifting/presentation/providers/evidenceliftingafter/forms/evidence_form_provider.dart';
import 'package:appmattsa/features/lifting/presentation/screens/processlifting/widgets/newexpansion%20copy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../shared/shared.dart';

import '../../../liftings.dart';
import 'widgets/widgets.dart';

class EvidenceScreenAfter extends ConsumerWidget {
  const EvidenceScreenAfter({super.key, required this.idLifting});
  static const name = "evidence_lifting_after";
  final String idLifting;

  void showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Evidencia actualizada')));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final evidenceState = ref.watch(evidenceProviderafter(idLifting));
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
        onPressed: () {
          showSnackbar(context);
          context.push('/servicelifint');
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
    final evidenceForm = ref.watch(EvidenceFormProviderAfter(lifting));
    final evidenceFormNotifier =
        ref.watch(EvidenceFormProviderAfter(lifting).notifier);

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
                child: ExpansionCustomNewT(
                  evidence: evidenceForm,
                  evidencenotifier: evidenceFormNotifier,
                  colorwords: Colors.black,
                  color: Colors.white,
                  getlistitems: s.myclase!,
                ),
              )
            ],
          );
        });
  }
}
