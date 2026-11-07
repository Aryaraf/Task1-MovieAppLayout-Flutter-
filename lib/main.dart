import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

void main() {
  runApp(const MovieApp());
}

/// ---------------------------------------------------------------------------
/// MODEL & DUMMY DATA
/// ---------------------------------------------------------------------------
class Movie {
  final String title;
  final String year;
  final String genre;
  final String description;
  final String posterUrl;

  const Movie({
    required this.title,
    required this.year,
    required this.genre,
    required this.posterUrl,
    this.description =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
  });
}

String _poster(String seed, {int w = 400, int h = 600}) =>
    'https://picsum.photos/seed/$seed/$w/$h';

final List<Movie> nowPlaying = [
  Movie(
    title: 'Deadpool & Wolverine',
    year: '2024',
    genre: 'Action',
    posterUrl: _poster('deadpool'),
  ),
  Movie(
    title: 'Inside Out 2',
    year: '2024',
    genre: 'Animation',
    posterUrl: _poster('insideout'),
  ),
  Movie(
    title: 'Twisters',
    year: '2024',
    genre: 'Adventure',
    posterUrl: _poster('twisters'),
  ),
  Movie(
    title: 'Alien: Romulus',
    year: '2024',
    genre: 'Sci-Fi',
    posterUrl: _poster('alien'),
  ),
];

final List<Movie> trending = [
  Movie(
    title: 'Bad Boys: Ride or Die',
    year: '2024',
    genre: 'Action',
    posterUrl: _poster('badboys'),
  ),
  Movie(
    title: 'Despicable Me 4',
    year: '2024',
    genre: 'Animation',
    posterUrl: _poster('despicable'),
  ),
  Movie(
    title: 'A Quiet Place',
    year: '2024',
    genre: 'Horror',
    posterUrl: _poster('quietplace'),
  ),
  Movie(
    title: 'Kingdom of the Planet of the Apes',
    year: '2024',
    genre: 'Sci-Fi',
    posterUrl: _poster('apes'),
  ),
  Movie(
    title: 'Furiosa',
    year: '2024',
    genre: 'Action',
    posterUrl: _poster('furiosa'),
  ),
];

final List<Movie> popular = [
  Movie(
    title: 'The Brothers Sun',
    year: '2024',
    genre: 'Drama',
    posterUrl: _poster('brotherssun'),
  ),
  Movie(
    title: 'Fallout',
    year: '2024',
    genre: 'Sci-Fi',
    posterUrl: _poster('fallout'),
  ),
  Movie(
    title: 'True Detective: Night Country',
    year: '2024',
    genre: 'Crime',
    posterUrl: _poster('nightcountry'),
  ),
  Movie(
    title: 'Shogun',
    year: '2024',
    genre: 'Drama',
    posterUrl: _poster('shogun'),
  ),
  Movie(
    title: 'Ripley',
    year: '2024',
    genre: 'Thriller',
    posterUrl: _poster('ripley'),
  ),
];

final List<Movie> topRated = [
  Movie(
    title: 'Beautiful Life',
    year: '2023',
    genre: 'Drama',
    posterUrl: _poster('beautifullife'),
  ),
  Movie(
    title: 'Anatomie d\'une Chute',
    year: '2023',
    genre: 'Drama',
    posterUrl: _poster('anatomie'),
  ),
  Movie(
    title: 'Perfect Days',
    year: '2023',
    genre: 'Drama',
    posterUrl: _poster('perfectdays'),
  ),
  Movie(
    title: 'Oppenheimer',
    year: '2023',
    genre: 'History',
    posterUrl: _poster('oppenheimer'),
  ),
  Movie(
    title: 'Past Lives',
    year: '2023',
    genre: 'Romance',
    posterUrl: _poster('pastlives'),
  ),
];

/// ---------------------------------------------------------------------------
/// APP
/// ---------------------------------------------------------------------------
class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return MaterialApp(
      title: 'Movie App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

/// ---------------------------------------------------------------------------
/// HOME PAGE
/// ---------------------------------------------------------------------------
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1C1C),
        centerTitle: true,
        title: const Text(
          'Now Playing',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              NowPlayingCarousel(movies: nowPlaying),
              const SizedBox(height: 16),
              MovieSection(title: 'Trending', movies: trending),
              MovieSection(title: 'Popular', movies: popular),
              MovieSection(title: 'Top Rated', movies: topRated),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// NOW PLAYING - carousel_slider
/// ---------------------------------------------------------------------------
class NowPlayingCarousel extends StatelessWidget {
  final List<Movie> movies;
  const NowPlayingCarousel({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: movies.length,
      options: CarouselOptions(
        height: 260,
        viewportFraction: 0.78,
        enlargeCenterPage: true,
        enlargeFactor: 0.15,
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 4),
      ),
      itemBuilder: (context, index, realIndex) {
        final movie = movies[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                movie.posterUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const _PosterPlaceholder(),
                loadingBuilder: (c, child, p) =>
                    p == null ? child : const _PosterPlaceholder(),
              ),
              // gradient agar teks terbaca
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black87],
                    stops: [0.45, 1],
                  ),
                ),
              ),
              Positioned(
                left: 12,
                right: 12,
                bottom: 12,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            movie.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${movie.year}   ${movie.genre}',
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            movie.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 9,
                              color: Colors.white60,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 28,
                      height: 28,
                      decoration: const BoxDecoration(
                        color: Colors.white24,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.chevron_right, size: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// ---------------------------------------------------------------------------
/// SECTION (Trending / Popular / Top Rated) - flutter_card_swiper
/// ---------------------------------------------------------------------------
class MovieSection extends StatelessWidget {
  final String title;
  final List<Movie> movies;
  const MovieSection({super.key, required this.title, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => SwipePage(title: title, movies: movies),
                  ),
                ),
                child: const Text(
                  'More',
                  style: TextStyle(fontSize: 11, color: Colors.white70),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 130,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, i) => _PosterCard(movie: movies[i]),
          ),
        ),
      ],
    );
  }
}

class _PosterCard extends StatelessWidget {
  final Movie movie;
  const _PosterCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: AspectRatio(
        aspectRatio: 2 / 3,
        child: Image.network(
          movie.posterUrl,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const _PosterPlaceholder(),
          loadingBuilder: (c, child, p) =>
              p == null ? child : const _PosterPlaceholder(),
        ),
      ),
    );
  }
}

class _PosterPlaceholder extends StatelessWidget {
  const _PosterPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF2A2A2A),
      alignment: Alignment.center,
      child: const Icon(Icons.movie, color: Colors.white24),
    );
  }
}

/// ---------------------------------------------------------------------------
/// HALAMAN SWIPE (flutter_card_swiper)
/// ---------------------------------------------------------------------------
class SwipePage extends StatelessWidget {
  final String title;
  final List<Movie> movies;
  const SwipePage({super.key, required this.title, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1C1C),
        title: Text(title, style: const TextStyle(fontSize: 16)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: CardSwiper(
            cardsCount: movies.length,
            numberOfCardsDisplayed: movies.length < 3 ? movies.length : 3,
            backCardOffset: const Offset(0, 28),
            padding: const EdgeInsets.only(bottom: 40),
            cardBuilder: (context, index, h, v) {
              final m = movies[index];
              return ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      m.posterUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const _PosterPlaceholder(),
                    ),
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black87],
                          stops: [0.6, 1],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 16,
                      bottom: 16,
                      right: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            m.title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${m.year}  •  ${m.genre}',
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
