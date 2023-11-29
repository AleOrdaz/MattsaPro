import 'package:appmattsa/config/config.dart';
import 'package:flutter/material.dart';
class CardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2, // Sombreado
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Título de la tarjeta',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10), // Espacio entre título y lista
            Divider(height: 1), // Línea separadora
            SizedBox(height: 10), // Espacio entre línea y lista
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildLink('Enlace 1', 'https://www.enlace1.com'),
                buildLink('Enlace 2', 'https://www.enlace2.com'),
                buildLink('Enlace 3', 'https://www.enlace3.com'),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget buildLink(String title, String url) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: InkWell(
        onTap: () {
          // Acción al hacer clic en el enlace
        },
        child: Text(
          title,
          style: TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}

class ExpandableCard extends StatefulWidget {
  final IconData data;
  final String title;
  final Widget body;
  ExpandableCard({required this.title, required this.body,required this.data});
  @override
  _ExpandableCardState createState() => _ExpandableCardState();
}
class _ExpandableCardState extends State<ExpandableCard> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isExpanded = _isExpanded ? false : true;
        });
      },
      child: Card(
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(widget.data),
              title: Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 19,
                  color: AppTheme.blueMattsa,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                  _isExpanded ? Icons.expand_less : Icons.expand_more,
                ),
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
              ),
            ),
            if (_isExpanded) widget.body,
          ],
        ),
      ),
    );
  }
}