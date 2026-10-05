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
                  dropdownMenuEntries: [
                    DropdownMenuEntry(value: 0, label: '0'),
                    DropdownMenuEntry(value: 1, label: '1'),
                    DropdownMenuEntry(value: 2, label: '2'),
                    DropdownMenuEntry(value: 3, label: '3'),
                    DropdownMenuEntry(value: 4, label: '4'),
                    DropdownMenuEntry(value: 5, label: '5')
                  ],
                )
              ],
            )
          ],
        )
      ),
    );
  }
}
