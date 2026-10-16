import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';
import 'package:southsea_cinema/models/movie.dart';

class MovieListing extends StatefulWidget {
  final Movie movie;
  
  const MovieListing({
    super.key,
    required this.movie,
  });

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
      body: SingleChildScrollView(
        child: 
        Container(
            color: cinemaBackground,
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        widget.movie.name,
                        style: listingTitleStyle
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '(${widget.movie.ageRating})',
                      style: ageRatingStyle,
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                    widget.movie.imagePath,
                    width: 120,
                    height: 200,
                    fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        widget.movie.description,
                        style: listingDesciptionStyle,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'Southsea Cinema Room',
                  style: listingDesciptionStyle,
                ),
                Text(
                  'Thursday 22 October 2026, 18:00',
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
                LayoutBuilder(builder: ((context, constraints) {
                  if (constraints.maxWidth < 400) { // Doesn't consider padding - 400 = width of container, not page
                    return Column(
                      spacing: 20,
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
                    );
                  }
                  else {
                    return Row(
                      spacing: 20,
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
                      );
                    }
                  })
                ),
                const SizedBox(height: 10),
                FilledButton(
                  onPressed: _addToBasket,
                  child: Text('Add to order')
                ),
                Visibility(
                  visible: _addedToBasket,
                  child: Text(_confirmText, style: listingDesciptionStyle)
                ),
              ],
            ),
          ),
        )
      );
  }

  void _addToBasket() {
    setState(() {
      _addedToBasket = true;
      _confirmText = 'Added $_ticketsSelected ${_ticketsSelected == 1 ? 'ticket' : 'tickets'} to basket!';
    });
  }
}
