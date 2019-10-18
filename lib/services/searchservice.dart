import 'package:cloud_firestore/cloud_firestore.dart';

class SearchService {
  searchByString(String searchField) {
    return Firestore.instance
        .collection('client')
        .where('tasktags', isEqualTo: searchField.substring(0, 1).toUpperCase())
        .where('taskname', isEqualTo: searchField.substring(0, 1).toUpperCase())
        .where('taskenviroments',
            isEqualTo: searchField.substring(0, 1).toUpperCase())
        .where('taskfeatures',
            isEqualTo: searchField.substring(0, 1).toUpperCase())
        .where('taskfoods',
            isEqualTo: searchField.substring(0, 1).toUpperCase())
        .where('taskplans',
            isEqualTo: searchField.substring(0, 1).toUpperCase())
        .where('taskservices',
            isEqualTo: searchField.substring(0, 1).toUpperCase())
        .getDocuments();
  }
}
