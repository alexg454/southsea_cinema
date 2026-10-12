import 'package:southsea_cinema/models/movie.dart';

class MovieRepository {
  List<Movie> getMovies() {
    return const [
      Movie(
        id: 'spider-man_itsv',
        name: 'Spider-Man: Into the Spider Verse',
        ageRating: 'PG',
        description: 'After gaining superpowers from a spider bite, Miles Morales protects the city as Spider-Man. Soon, he meets alternate versions of himself and gets embroiled in an epic battle to save the multiverse.'
      ),
      Movie(
        id: 'tenet',
        name: 'Tenet',
        ageRating: '15',
        description: 'When a few objects that can be manipulated and used as weapons in the future fall into the wrong hands, a CIA operative, known as the Protagonist, must save the world.'
      )
    ];
  }
}