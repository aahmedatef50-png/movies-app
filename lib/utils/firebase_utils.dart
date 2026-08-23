import 'package:cloud_firestore/cloud_firestore.dart';
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
}
