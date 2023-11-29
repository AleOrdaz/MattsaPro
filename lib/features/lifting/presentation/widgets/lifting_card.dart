import 'package:flutter/material.dart';

import '../../../../shared/shared.dart';
import '../../domain/domain.dart';

class LiftingCard extends StatelessWidget {
  final Lifting lifting;
  const LiftingCard({super.key, required this.lifting});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: ListTile(
        title: Center(child: SingleChildScrollView(child: Text(lifting.nameLifting,style: TextStyle(fontWeight: FontWeight.bold),))),
        subtitle: Column(
          children: [
            Text(lifting.namecustomer??'sin customer'),
            getContainerSatus(lifting.idStatus, 2),

          ],
        ),
      ),
    );
  }
}


class CustomCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final int status;

  const CustomCard({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        margin: EdgeInsets.only(top: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              //top: -4,
              //right: -4,
              child: Container(
                margin: EdgeInsets.only(bottom: 4),
                width: MediaQuery.of(context).size.width,
                height: 30,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    topLeft: Radius.circular(20.0),

                  ),
                ),
                child: getContainerSatus(status, 1),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 28,bottom: 16,left: 16,right: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Text(
                            title.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 4),
                      ],
                    ),
                  ),
                  Icon(icon, size: 24, color: Colors.amberAccent),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
