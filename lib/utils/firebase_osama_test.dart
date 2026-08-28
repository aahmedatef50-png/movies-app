import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_movies_app/model/favourite.dart';

class FirebaseOsamaTest {

  static CollectionReference<Favourite> getFavouritesCollection(){
    return FirebaseFirestore.instance.collection(Favourite.CollictionName)
        .withConverter(fromFirestore: (snapshot, options) => Favourite.FromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson());
  }

  static Future<void> addFaviorate(Favourite fav){
    //todo: collection
    CollectionReference<Favourite> collectionRef=getFavouritesCollection();
    //todo: document
    DocumentReference<Favourite> docRef=collectionRef.doc();
    //todo: auto id
    fav.favouriteId=docRef.id;

    return docRef.set(fav);
  }


  //todo: get user related faviorets

}