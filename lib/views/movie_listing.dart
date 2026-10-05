import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

class MovieListing extends StatefulWidget {
  const MovieListing({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MovieListing();
  }
}

class _MovieListing extends State<MovieListing> {
  double _totalPrice = 7.50;
  int _ticketsSelected = 1;
  bool _addedToBasket = false;
  String _confirmText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle, style: cinemaHeaderStyle),
        backgroundColor: cinemaSurface,
        iconTheme: const IconThemeData(color: cinemaBrand),
        elevation: 0,
      ),
      drawer: const NavDrawer(),
      body: Container(
        color: cinemaBackground,
        padding: EdgeInsets.all(50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 25,
          children: [
            Text(
            'Spiderman: Into the Spider Verse (2018) (PG)',
            style: listingTitleStyle
            ),
            const SizedBox(height: 10),
            Text(
              'Southsea Cinema Room',
              style: listingDesciptionStyle,
            ),
            Text(
              'Thursday 22 October 2026, 18:00 - ends at 19:57',
              style: listingDesciptionStyle
            ),
            const SizedBox(height: 10),
            Text(
              'Please note that Discounts / Membership Benefits will be applied once you have selected your tickets',
              style: listingDesciptionStyle,
            ),
            Text(
              'Select Quantities (Up to 5 in total)',
              style: listingDesciptionStyle,
            ),
            const SizedBox(height: 10),
            Text(
              'Tickets',
              style: cinemaHeaderStyle
            ),
            Row(
              spacing: 25,
              children: <Widget>[
                DropdownMenu<int>(
                  initialSelection: 1,

                  onSelected: (int? value) {
                    if (value != null) {
                      setState(() {
                        _totalPrice = value * 7.50;
                        _ticketsSelected = value;
                        }
                      );
                    }
                  },

                  dropdownMenuEntries: [
                    DropdownMenuEntry(value: 1, label: '1'),
                    DropdownMenuEntry(value: 2, label: '2'),
                    DropdownMenuEntry(value: 3, label: '3'),
                    DropdownMenuEntry(value: 4, label: '4'),
                    DropdownMenuEntry(value: 5, label: '5')
                  ],
                ),
                Text(
                  'Adult (£${_totalPrice.toStringAsFixed(2)})',
                  style: listingDesciptionStyle
                )
              ],
            ),
            FilledButton(
              onPressed: _addToBasket,
              child: Text('Add to order')
            ),
            Visibility(
              visible: _addedToBasket,
              child: Text(_confirmText, style: listingDesciptionStyle)
            )
          ],
        )
      ),
    );
  }

  void _addToBasket() {
    setState(() {
      _addedToBasket = true;
      _confirmText = 'Added $_ticketsSelected ${_ticketsSelected == 1 ? 'ticket' : 'tickets'} to basket!';
    });
  }
}
