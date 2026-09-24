import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Models/movie_model.dart';

abstract class HistoryRemoteDataSource {
  Future<void> addMovieToHistory(MovieModel movie);
  Future<List<MovieModel>> getHistoryMovies();
}

class HistoryRemoteDataSourceImpl implements HistoryRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  HistoryRemoteDataSourceImpl({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : firestore = firestore ?? FirebaseFirestore.instance,
        auth = auth ?? FirebaseAuth.instance;

  @override
  Future<void> addMovieToHistory(MovieModel movie) async {
    final userId = auth.currentUser?.uid ?? 'default_user';


    final movieData = movie.toJson();
    movieData['viewedAt'] = FieldValue.serverTimestamp();

    await firestore
        .collection('users')
        .doc(userId)
        .collection('history')
        .doc(movie.id?.toString())
        .set(movieData);

  }

  @override
  Future<List<MovieModel>> getHistoryMovies() async {
    final userId = auth.currentUser?.uid ?? 'default_user';



    final snapshot = await firestore
        .collection('users')
        .doc(userId)
        .collection('history')
        .orderBy('viewedAt', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => MovieModel.fromJson(doc.data()))
        .toList();
  }
}