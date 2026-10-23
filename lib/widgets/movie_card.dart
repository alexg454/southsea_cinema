import 'package:flutter/material.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/views/movie_listing.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cinemaSurface,
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    movie.name,
                    style: listingTitleStyle,
                  ),
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
                  width: 120,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    movie.description,
                    style: listingDesciptionStyle,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'BOOK TICKETS',
                  style: listingDesciptionStyle,
                ),
                Text(
                  movie.formattedPrice,
                  style: listingDesciptionStyle,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sunday 4 Oct 2026\t15:00',
                  style: listingDesciptionStyle,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return MovieListing(movie: movie);
                          },
                        ),
                      );
                    },
                    child: const Text('BOOK NOW')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
