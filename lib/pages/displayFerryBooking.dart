import 'package:ferry_booking/models/ferryPlaces.dart';
import 'package:ferry_booking/pages/bookingFerryPage.dart';
import 'package:ferry_booking/pages/login_screen.dart';
import 'package:flutter/material.dart';

import '../database/ferrytickets_helper.dart';
import '../models/user.dart';
import '../models/ferryticket.dart';
import '../widgets/viewFerry.dart';
import '../database/userSession.dart';



class displayFerryBooking extends StatefulWidget {
  const displayFerryBooking({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  _DisplayPageState createState() => _DisplayPageState();
}

class _DisplayPageState extends State<displayFerryBooking> {
  final FerryTicketDatabase _ferryTicketDatabase = FerryTicketDatabase();

  Future<void> _onFerryTicketDelete(FerryTicket ferryTicket) async {
    await _ferryTicketDatabase.deleteFerryTicket(
      ferryTicket.book_id!,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ferry Tickets'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text('Ferry Tickets'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FerryBuilder(
                future: _ferryTicketDatabase
                    .getFerryUserTicket(userSaveSession.getUserID() as int),
                onDelete: _onFerryTicketDelete,
                onEdit: (value) {
                  Navigator.of(context)
                      .push(
                        MaterialPageRoute(
                          builder: (_) => order_page(),
                          fullscreenDialog: true,
                        ),
                      )
                      .then((_) => setState(() {}));
                }),
          ],
        ),
        floatingActionButton:
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                    builder: (context) => const order_page(),
                    fullscreenDialog: true,
                  ))
                  .then((_) => setState(() {}));
            },
            heroTag: 'addFerryTicket',
            child: const Icon(Icons.add_circle_rounded),
          ),
          const SizedBox(height: 12.0),
        ]),
      ),
    );
  }
}