import 'package:flutter/material.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/constants.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.name,
                  style: listingTitleStyle,
                ),
                const SizedBox(width: 16),
                Text(
                  '(${movie.ageRating})',
                  style: listingDesciptionStyle,
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                movie.imagePath,
                width: 80,
                height: 160,
                fit: BoxFit.cover,
                ),
                const SizedBox(width: 16),
                Text(
                  movie.description,
                  style: listingDesciptionStyle,
                )
              ],
            ),
            Text(
              'BOOK TICKETS',
              style: listingDesciptionStyle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sunday 4 Oct 2026\t15:00',
                  style: listingDesciptionStyle,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('BOOK NOW')
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}