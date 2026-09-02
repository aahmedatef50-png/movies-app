import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_movies_app/model/watch_history.dart';
import 'package:my_movies_app/model/favourite.dart';
import 'package:my_movies_app/model/my_user.dart';

class FirebaseUtils {
  static CollectionReference<MyUser> getCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter(
          fromFirestore: (snapshot, options) {
            return MyUser.fromJson(snapshot.data()!);
          },
          toFirestore: (user, options) {
            return user.toJson();
          },
        );
  }

  static Future<void> addUserInFireStore(MyUser user) {
    var collectionRef = getCollection();
    var docRef = collectionRef.doc(user.id);
    return docRef.set(user);
  }

  static Stream<MyUser?> getUserFromFireStore(String userId) {
    var stream = getCollection().doc(userId).snapshots();
    return stream.map((query) {
      return query.data();
    });
  }

  static Future<void> updateUser(MyUser newUser) {
    return getCollection().doc(newUser.id).update({
      'name': newUser.name,
      'phone_number': newUser.phoneNumber,
      'image_index': newUser.imageIndex,
    });
  }

  static Future<void> deleteUser(String userId) {
    return getCollection().doc(userId).delete();
  }


  static CollectionReference<Favourite> getFavouritesCollection() {
    return FirebaseFirestore.instance
        .collection(Favourite.collectionName)
        .withConverter<Favourite>(
      fromFirestore: (snapshot, options) {
        return Favourite.fromJson(snapshot.data()!);
      },
      toFirestore: (favourite, options) {
        return favourite.toJson();
      },
    );
  }


// Add favorite
  static Future<void> addFavorite(Favourite favourite) async {
    final collectionRef = getFavouritesCollection();

    final docRef = collectionRef.doc();

    favourite.favouriteId = docRef.id;

    await docRef.set(favourite);
  }


// Remove favorite
  static Future<void> removeFavorite(
      String userId,
      num movieId,
      ) async {
    final snapshot = await getFavouritesCollection()
        .where('userId', isEqualTo: userId)
        .where('movieId', isEqualTo: movieId)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      await snapshot.docs.first.reference.delete();
    }
  }


// Check if favorite
  static Future<bool> isFavorite(
      String userId,
      num movieId,
      ) async {
    final snapshot = await getFavouritesCollection()
        .where('userId', isEqualTo: userId)
        .where('movieId', isEqualTo: movieId)
        .limit(1)
        .get();

    return snapshot.docs.isNotEmpty;
  }


// Get user's favorites
  static Stream<List<Favourite>> getFavorites(
      String userId,
      ) {
    return getFavouritesCollection()
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map((doc) => doc.data())
          .toList(),
    );
  }

  static CollectionReference<WatchHistory>
  getWatchHistoryCollection() {
    return FirebaseFirestore.instance
        .collection(WatchHistory.collectionName)
        .withConverter<WatchHistory>(
      fromFirestore: (snapshot, options) {
        return WatchHistory.fromJson(snapshot.data()!);
      },
      toFirestore: (history, options) {
        return history.toJson();
      },
    );
  }


// Add / Update watch history
  static Future<void> addToWatchHistory(
      WatchHistory history,
      ) async {
    final collectionRef = getWatchHistoryCollection();

    // Check if this movie was already watched by this user
    final snapshot = await collectionRef
        .where('userId', isEqualTo: history.userId)
        .where('movieId', isEqualTo: history.movieId)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      // Movie already exists
      // Update the existing document

      final docRef = snapshot.docs.first.reference;

      await docRef.update({
        'rating': history.rating,
        'largeCoverImage': history.largeCoverImage,
        'watchedAt': FieldValue.serverTimestamp(),
      });
    } else {
      // Movie doesn't exist
      // Create new document

      final docRef = collectionRef.doc();

      history.historyId = docRef.id;

      await docRef.set(
        WatchHistory(
          historyId: docRef.id,
          movieId: history.movieId,
          rating: history.rating,
          largeCoverImage: history.largeCoverImage,
          userId: history.userId,
          watchedAt: DateTime.now(),
        ),
      );
    }
  }


// Check if movie was watched
  static Future<bool> isMovieWatched(
      String userId,
      num movieId,
      ) async {
    final snapshot = await getWatchHistoryCollection()
        .where('userId', isEqualTo: userId)
        .where('movieId', isEqualTo: movieId)
        .limit(1)
        .get();

    return snapshot.docs.isNotEmpty;
  }


  static Stream<List<WatchHistory>> getWatchHistory(
      String userId,
      ) {
    return getWatchHistoryCollection()
        .where('userId', isEqualTo: userId)
        .orderBy('watchedAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map((doc) => doc.data())
          .toList(),
    );
  }
}
