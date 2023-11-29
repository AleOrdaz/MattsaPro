import 'package:appmattsa/config/theme/app_theme.dart';
import 'package:flutter/material.dart';

class PageMenu extends StatefulWidget {
  const PageMenu({super.key});
  static const name = "pagemainlifint";

  @override
  State<PageMenu> createState() => _PageMenuState();
}

class _PageMenuState extends State<PageMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.whiteMattsaLight,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(AppTheme.redMattsa),
                  ),
                  onPressed: () {
                    setState(() {

                    });
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Enviar ",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.whiteMattsaLight,
                        ),
                      ),
                      Icon(Icons.send, color: AppTheme.whiteMattsaLight,),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(AppTheme.redMattsa),
                  ),
                  onPressed: () {
                    setState(() {
                    });
                  },
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Enviar ",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.whiteMattsaLight,
                        ),
                      ),
                      Icon(Icons.send, color: AppTheme.whiteMattsaLight,),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
