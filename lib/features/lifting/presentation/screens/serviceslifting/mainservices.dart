import 'package:appmattsa/config/theme/app_theme.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../shared/shared.dart';
import '../../../liftings.dart';

/*class MainServicesScreen extends StatelessWidget {
  const MainServicesScreen({super.key});
  static const name = "servicelifint";

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      backgroundColor: AppTheme.whiteMattsaLight,
      appBar: CustomAppBar(title: "Servicios",),
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      body: const _LiftingsView(),
    );
  }
}*/

class MainServicesScreen extends ConsumerStatefulWidget {
  const MainServicesScreen({super.key});
  static const name = "servicelifint";

  @override
  _LiftingsViewState createState() => _LiftingsViewState();
}

class _LiftingsViewState extends ConsumerState {
  final ScrollController scrollController = ScrollController();
  String searchValue = '';
  var search = [];
  bool _showWidget = true;

  Future<List<String>> _fetchSuggestions(String searchValue) async {
    await Future.delayed(const Duration(milliseconds: 750));

    List<String> drivers = [];
    search = [];
    final productsState = ref.watch(productsProvider);

    for(int i = 0; i < productsState.products.length; i++) {
      var product = productsState.products[i];
      String namecustomer = product.namecustomer ?? "Sin asignacion de cliente";

      drivers.add('${product.nameLifting}');

      if(product.nameLifting.toUpperCase().contains(searchValue.toUpperCase())) {
        search.add('${product.id}#${product.nameLifting}#$namecustomer#${product
            .idStatus}');
      }
    }

    return drivers.where((element) {
      return element.toLowerCase().contains(searchValue.toLowerCase());
    }).toList();
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 6)).then((value) {
      setState(() {
        _showWidget = false;
      });
    });

    scrollController.addListener(() {
      if ((scrollController.position.pixels + 400) >=
          scrollController.position.maxScrollExtent) {
        ref.read(servicesProvider.notifier).loadNextPage();

        //TODO:CARGAR SIGUIENTE PAGINA DE LIFTINGS PARA INFINITE SCROLL
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productsState = ref.watch(servicesProvider);
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
        backgroundColor: AppTheme.whiteMattsaLight,
        appBar: EasySearchBar(
          backgroundColor: AppTheme.blueMattsa,
          foregroundColor: AppTheme.whiteMattsaLight,
          title: const Text(
            'Servicios',
            style: TextStyle(color: AppTheme.whiteMattsaLight, fontSize: 20),
            textAlign: TextAlign.center,
          ),
          onSearch: (value) => setState(() => searchValue = value),
          asyncSuggestions: (value) async =>
          await _fetchSuggestions(value),
        ), //
        //CustomAppBar(title: "Servicios",),
        drawer: SideMenu(scaffoldKey: scaffoldKey),
        body: productsState.products.isNotEmpty ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: !searchValue.isNotEmpty ? productsState.products.isNotEmpty ? ListView.builder(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              itemCount: productsState.products.length,
              itemBuilder: (context, index) {
                final product = productsState.products[index];

                return GestureDetector(
                    onTap: () {
                      setState(() {
                        context.push('/services/panel/${product.id}');
                      });
                    },
                    child: LiftingCard(lifting: product));
              }) :
          const Center(
            child: Text(
              "No hay datos por mostrar...",
              style: TextStyle(fontSize: 20, color: AppTheme.redMattsa),
            ),
          ) :
          search.isNotEmpty ? ListView.builder(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              itemCount: search.length,
              itemBuilder: (context, index) {
                var product = [];
                if (search.length > index) {
                  product = search[index].split('#');
                }

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      context.push('/services/panel/${product[0]}');
                    });
                  },
                  child: Card(
                    color: AppTheme.whiteMattsaLight,
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    elevation: 2,
                    child: ListTile(
                      title: Center(
                        child: SingleChildScrollView(
                          child: getContainerSatus(int.parse(product[3]), 2),
                        ),
                      ),
                      subtitle: Column(
                        children: [
                          Text(product[1],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(product[2]??'sin customer'),
                        ],
                      ),
                    ),
                  ),
                );
              }) :
          const Center(
            child: Text(
              "No se encontraron datos por mostrar...",
              style: TextStyle(fontSize: 20, color: AppTheme.redMattsa),
            ),
          ),
        ) : _showWidget ? const FullScreenLoading() :
      const Center(
        child:Text(
            "No hay información",
            style: TextStyle(color: AppTheme.grayMattsa, fontSize: 16),
          ),
      ),
    );
  }
}