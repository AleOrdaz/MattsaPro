import 'dart:convert';

import 'package:appmattsa/config/config.dart';
import 'package:appmattsa/features/lifting/presentation/widgets/widgets.dart';
import 'package:dropdown_below/dropdown_below.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../../../shared/shared.dart';
import '../../../../singleton.dart';
import '../providers/mainlifting/liftingsprovider.dart';

/*class MainLiftingScreen extends StatelessWidget {
  const MainLiftingScreen({super.key});
  static const name = "mainlifint";

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: EasySearchBar(
        backgroundColor: AppTheme.blueMattsa,
        foregroundColor: AppTheme.whiteMattsaLight,
        title: const Text(''
          //'Lista de Conductores', style: TextStyle(color: AppTheme.whiteMattsaLight),
        ),
        onSearch: (value) => setState(() => searchValue = value),
        /*actions: [
                IconButton(
                  icon: const Icon(Icons.exit_to_app),
                  onPressed: () {
                    //dialogConfirmExit(context, singleton, sharedPreferences);
                  },
                ),
              ],*/
        asyncSuggestions: (value) async =>
        await _fetchSuggestions(value),
      ), //CustomAppBar(title: "Levantamientos",),
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      body: const _LiftingsView(),
      // floatingActionButton: FloatingActionButton(
      //   mini: false,
      //   onPressed: () {
      //     context.push('/lifting/customer/new');
      //   },
      //   child: Container(
      //     decoration: BoxDecoration(
      //         gradient: LinearGradient(colors: [
      //           AppTheme.blueMattsa,
      //           AppTheme.grayMattsaLight,
      //           AppTheme.blueMattsa,
      //         ]),
      //         borderRadius: BorderRadius.circular(30)),
      //     child: Padding(
      //         padding:
      //             const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      //         child: SizedBox(
      //           width: 120,
      //           child: Row(
      //             mainAxisSize: MainAxisSize.min,
      //             children: [
      //               Icon(Icons.add,size: 24,),
      //               SizedBox(width: 8),
      //               Text('Nuevo Levantamiento'),
      //             ],
      //           ),
      //         )),
      //   ),
      // )

      floatingActionButton: FloatingActionButton.extended(
        label: const Text(
          'Nuevo\nLevantamiento',
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(Icons.add, color: Colors.white),
        backgroundColor: AppTheme.blueMattsa,
        onPressed: () {
          context.push('/lifting/customer/new');
        },
      ),
    );
  }
}*/

class MainLiftingScreen extends ConsumerStatefulWidget {
  const MainLiftingScreen({super.key});
  static const name = "mainlifint";

  @override
  _LiftingsViewState createState() => _LiftingsViewState();
}

class UsersEmails {
  final int id;
  final String name;
  final String email;

  UsersEmails({
    required this.id,
    required this.name,
    required this.email,
  });
}

class _LiftingsViewState extends ConsumerState {
  final ScrollController scrollController = ScrollController();
  Singleton singleton = Singleton();
  String searchValue = '';
  var search = [];
  bool _showWidget = true;

  Future<List<String>> _fetchSuggestions(String searchValue) async {
    await Future.delayed(const Duration(milliseconds: 750));

    List<String> drivers = [];
    final productsState = ref.watch(productsProvider);
    search = [];

    for(int i = 0; i < productsState.products.length; i++) {
      var product = productsState.products[i];

      String namecustomer = product.namecustomer ?? "Sin asignacion de customer";

      drivers.add('${product.nameLifting}-$namecustomer');
      print(searchValue.toUpperCase());
      print(product.nameLifting.toUpperCase());
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
    getUserEmail();

    Future.delayed(const Duration(seconds: 6)).then((value) {
      setState(() {
        _showWidget = false;
      });
    });

    scrollController.addListener(() {
      if ((scrollController.position.pixels + 400) >=
          scrollController.position.maxScrollExtent) {

        ref.read(productsProvider.notifier).loadNextPage();

        //TODO:CARGAR SIGUIENTE PAGINA DE LIFTINGS PARA INFINITE SCROLL
      } else {
        ref.watch(productsProvider);
        //print(scrollController.position.pixels);
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
    final productsState = ref.watch(productsProvider);
    final scaffoldKey = GlobalKey<ScaffoldState>();

    singleton.viewSubMenu ?
        SchedulerBinding.instance.addPostFrameCallback((_) {
          singleton.viewSubMenu = false;
          //AlertDialogSubMenu(context);
        })
    : Container();

    return MaterialApp(
      title: 'Mattsa Pro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.indigo
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: EasySearchBar(
          elevation: 10,
          backgroundColor: AppTheme.blueMattsa,
          foregroundColor: AppTheme.whiteMattsaLight,
          searchBackgroundColor: AppTheme.whiteMattsaLight,
          title: Text(!singleton.showMenuMainPage ? 'Levantamientos' : 'Menú Principal',
            style: const TextStyle(color: AppTheme.whiteMattsaLight, fontSize: 20),
            textAlign: TextAlign.center,
          ),
          onSearch: (value) => setState(() => searchValue = value),
          asyncSuggestions: (value) async => await _fetchSuggestions(value),
        ), //CustomAppBar(title: "Levantamientos",),
        drawer: SideMenu(scaffoldKey: scaffoldKey),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 75, left: 10, right: 10),
              child: Column(
                children: [
                  singleton.showMenuMainPage ?
                  const Text('Selecciona una opción a visualizar', style: TextStyle(fontSize: 22),) : Container(),
                  singleton.showMenuMainPage ? const SizedBox(height: 30,) : Container(),
                  singleton.showMenuMainPage ?
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: SizedBox(
                      height: 65,
                      child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.blueMattsa,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          singleton.showMenuMainPage = false;
                          context.push('/mainlifting');
                        });
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.list, color: AppTheme.whiteMattsaLight,),
                          SizedBox(width: 25,),
                          Text(
                            " Levantamientos ",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.whiteMattsaLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ),
                  ) : Container(),
                  singleton.showMenuMainPage ? const SizedBox(height: 50,) : Container(),
                  singleton.showMenuMainPage ?
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: SizedBox(
                      height: 65,
                      child: ElevatedButton(
                          style:  ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              singleton.showMenuMainPage = false;
                              context.push('/servicelifint');
                            });
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.list_alt_rounded, color: AppTheme.whiteMattsaLight,),
                              SizedBox(width: 25,),
                              Text(
                                " Servicios ",
                                style: TextStyle(
                                  fontSize:20,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.whiteMattsaLight,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ),
                  ) : Container(),
                  !singleton.showMenuMainPage ? Expanded(
                    child: !searchValue.isNotEmpty ?
                    productsState.products.isNotEmpty ?
                    ListView.builder(
                      controller: scrollController,
                      physics: const BouncingScrollPhysics(),
                      itemCount: productsState.products.length,
                      itemBuilder: (context, index) {
                        final product = productsState.products[index];

                        return GestureDetector(
                          onTap: (){
                            
                            if(product.idStatus==1) {
                              context.push('/lifting/customer/${product.id}');
                            }

                            if(product.idStatus==2){
                              context.push('/lifting/status/${product.id}');
                            }

                            if(product.idStatus==3){
                              context.push('/lifting/evidence/${product.id}');
                            }
                            if(product.idStatus==4){
                              context.push('/lifting/actividades/${product.id}');
                            }
                            if(product.idStatus==5){
                              context.push('/lifting/firts/report/${product.id}');
                            }
                            ref.read(productsProvider.notifier).loadPage();
                          },
                          child: CustomCard(
                            title: product.nameLifting,
                            subtitle: product.namecustomer ?? "Sin asignacion de customer",
                            description: product.namecustomer ?? "Sin asignacion de customer",
                            status: product.idStatus,
                            icon: Icons.folder,
                          ),
                        );
                      },
                    ) :
                    Center(
                      child: _showWidget ? const CircularProgressIndicator() :
                      const Text(
                        "No hay información",
                        style: TextStyle(color: AppTheme.grayMattsa, fontSize: 16),
                      ),
                    ) :
                    ListView.builder(
                      controller: scrollController,
                      physics: const BouncingScrollPhysics(),
                      itemCount: search.length,
                      itemBuilder: (context, index) {

                        print("search.length");
                        print(search.length);
                        var product = [];
                        if (search.length > index) {
                          product = search[index].split('#');
                        }
                        return search.length > index ?  GestureDetector(
                          onTap: (){
                            if(product[3]=='1') {
                              context.push('/lifting/customer/${product[0]}');
                            }

                            if(product[3]=='2'){
                              context.push('/lifting/status/${product[0]}');
                            }

                            if(product[3]=='3'){
                              context.push('/lifting/evidence/${product[0]}');
                            }
                          },
                          child: CustomCard(
                            title: product[1],
                            subtitle: product[2],
                            description: product[2],
                            status: int.parse(product[3]),
                            icon: Icons.folder_delete,
                          ),
                        ) :
                        Container();
                      },
                    ),
                  ) : Container(),
                ],
              ),
            ),
            !singleton.showMenuMainPage ? Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: FloatingActionButton.extended(
                  label: const Text(
                    ' Nuevo Levantamiento ',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  icon: const Icon(Icons.add, color: Colors.white),
                  backgroundColor: AppTheme.blueMattsa,
                  onPressed: () {
                    singleton.nuevoLevantamineto = true;
                    context.push('/lifting/customer/new');
                  },
                ),
              ),
            ) : Container(),
          ],
        ),
        /*floatingActionButton: FloatingActionButton.extended(
        label: const Text(
          'Nuevo Levantamiento',
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(Icons.add, color: Colors.white),
        backgroundColor: AppTheme.blueMattsa,
        onPressed: () {
          context.push('/lifting/customer/new');
        },
      ),*/
      ),
    );
  }

  Future<String> getUserEmail() async {
    var url = 'https://mattsa.artendigital.mx/api/get/users/team/sales';
    var response = await http.get(Uri.parse(url));
    print(url);
    print(response.body);
    if (response.body.isNotEmpty) {
      var resp = json.decode(response.body);
      singleton.userEmail = [];
      print('=======TOKEN=========');
      for(int i = 0; i < resp['data'].length; i++) {
        singleton.userEmail.add(
            UsersEmails(
            id: resp['data'][i]['id'],
            name: '${resp['data'][i]['paternal_name']} ${resp['data'][i]['maternal_name']} '
                '${resp['data'][i]['name']}', email: resp['data'][i]['email']));

        singleton.userEmailSinId.add(
            '${resp['data'][i]['paternal_name']} ${resp['data'][i]['maternal_name']} '
                '${resp['data'][i]['name']}-${resp['data'][i]['email']}');
      }
      return "0";
    }
    else {
      print("error en la consulta");
      var error = jsonDecode(response.body);
      print(error['error']['code']);
      return "1";
    }
  }

  AlertDialogSubMenu(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext contextDialog){
        final size = MediaQuery.of(context).size;
        return Dialog(
          backgroundColor: AppTheme.whiteMattsaLight,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15, top: 65, right: 15, bottom: 10,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: [
                              Flexible(
                                fit: FlexFit.tight,
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: RichText(
                                    text: const TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Selecciona la vista que deseas ver: \n',
                                          style: TextStyle(
                                            color: AppTheme.blueMattsa,
                                            fontSize: 16,
                                          ),
                                        ),
                                        TextSpan(
                                          text: "",
                                          style: TextStyle(
                                            fontSize: 17,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15.0,),
                          const Divider(color: AppTheme.grayMattsa,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    singleton.viewSubMenu = false;
                                    context.push('/servicelifint');
                                  });
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: AppTheme.redMattsa,
                                  primary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  '  Servicios  ',
                                  style: TextStyle(color: Colors.white, fontSize: 16),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    singleton.viewSubMenu = false;
                                    Navigator.of(contextDialog).pop(true);
                                  });
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: AppTheme.blueMattsa,
                                  primary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  '  Levantamiento  ',
                                  style: TextStyle(color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: -60,
                child: CircleAvatar(
                  backgroundColor: AppTheme.whiteMattsaLight,
                  radius: 60,
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: size.height * 0.4,
                    alignment: Alignment.center,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}



class CustomDropdown extends StatefulWidget {
  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  List<String> _items = [
    'Opción 1',
    'Opción 2',
    'Opción 3',
    'Opción 4',
  ];

  String? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: DropdownBelow<String>(

        boxDecoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.red
        ),
        itemWidth: 200,
        itemTextstyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.black
        ),
        boxTextstyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.black
        ),
        boxPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        boxWidth: 500,
        boxHeight: 50,
        hint: Text(
          'Seleccionar opción',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        value: _selectedItem,
        items: _items.map((String value) {
          return DropdownMenuItem<String>(
            child: Text(value),
            value: value,
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedItem = newValue;
          });
        },
      ),
    );
  }
}


// class CustomCard extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final String description;
//   final IconData icon;
//   final int status;

//   const CustomCard({
//     required this.title,
//     required this.subtitle,
//     required this.description,
//     required this.icon,
//     required this.status,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       padding: EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16.0),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 4),
               
               
//                 Text(
//                   description,
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey[600],
//                   ),
//                 ),
//                  SizedBox(height: 4),
//                  getContainerSatus(status),
//               ],
//             ),
//           ),
//           Icon(icon, size: 24, color: Colors.amberAccent),
//         ],
//       ),
//     );
//   }
// }
