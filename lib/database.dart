import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final CollectionReference products =
      FirebaseFirestore.instance.collection('products');

  // Insert Document
  Future<void> addDocument(
      int code, String name, int buyPrice, int sellPrice, int stock) async {
    return products.doc(code.toString()).set({
      'code': code,
      'name': name,
      'buyPrice': buyPrice,
      'sellPrice': sellPrice,
      'stock': stock
    });
  }

  // Read Documents
  Stream<QuerySnapshot> readDocuments() {
    final productsStream =
        products.orderBy('code', descending: true).snapshots();
    return productsStream;
  }

  // Update Document
  Future<void> updateDocument(String docID, int code, String name, int buyPrice,
      int sellPrice, int stock) async {
    return products.doc(docID).update({
      'code': code,
      'name': name,
      'buyPrice': buyPrice,
      'sellPrice': sellPrice,
      'stock': stock
    });
  }

  // Delete Document
  Future<void> deleteDocument(String docID) async {
    return products.doc(docID).delete();
  }

  // Get Patrimony
  Future<List<int>> getReport() async {
    int patrimony = 0;
    int totalSells = 0;
    int estimatedProfits = 0;

    QuerySnapshot snapshot = await readDocuments().first;

    for (var document in snapshot.docs) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      // Get Data
      int buyPrice = data['buyPrice'];
      int sellPrice = data['sellPrice'];
      int stock = data['stock'];
      // Add Patrimony
      patrimony += buyPrice * stock;
      // Add Sells
      totalSells += sellPrice * stock;
    }

    estimatedProfits = totalSells - patrimony;

    return [patrimony, totalSells, estimatedProfits];
  }
}
