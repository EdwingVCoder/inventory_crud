import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventory_crud/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:inventory_crud/dialog.dart';
import 'package:inventory_crud/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.windows);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventario',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final Database database = Database();
  late final DialogController dialogController = DialogController(database);

  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Inventario',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  dialogController.viewReportDialog(context);
                },
                icon: const Icon(
                  Icons.analytics,
                  color: Colors.white,
                )),
          ],
          backgroundColor: Colors.deepPurple,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 300,
                    child: TextField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.search),
                        border: UnderlineInputBorder(),
                        hintText: 'Ingrese nombre o código',
                      ),
                    ),
                  ),
                  FilledButton(
                      onPressed: () {
                        dialogController.createDialog(context);
                      },
                      child: const Text('Crear'))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                stream: database.readDocuments(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List productsList = snapshot.data!.docs;

                    return ListView.builder(
                        itemCount: productsList.length,
                        itemBuilder: (context, index) {
                          // Get each individual doc
                          DocumentSnapshot document = productsList[index];
                          String docID = document.id;

                          // Get data from each doc
                          Map<String, dynamic> data =
                              document.data() as Map<String, dynamic>;
                          int code = data['code'];
                          String name = data['name'];
                          int buyPrice = data['buyPrice'];
                          int sellPrice = data['sellPrice'];
                          int stock = data['stock'];

                          // Display List Tile
                          return ProductsCard(
                            docID: docID,
                            code: code,
                            name: name,
                            buyPrice: buyPrice,
                            sellPrice: sellPrice,
                            stock: stock,
                            dialogController: dialogController,
                          );
                        });
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )),
            ],
          ),
        ));
  }
}

class ProductsCard extends StatefulWidget {
  final String docID;
  final int code;
  final String name;
  final int buyPrice;
  final int sellPrice;
  final int stock;
  final DialogController dialogController;

  const ProductsCard({
    super.key,
    required this.docID,
    required this.code,
    required this.name,
    required this.buyPrice,
    required this.sellPrice,
    required this.stock,
    required this.dialogController,
  });

  @override
  State<ProductsCard> createState() => _ProductsCardState();
}

class _ProductsCardState extends State<ProductsCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          widget.dialogController.viewDataDialog(
              context,
              widget.docID,
              widget.code,
              widget.name,
              widget.buyPrice,
              widget.sellPrice,
              widget.stock);
        },
        child: Card(
          child: ListTile(
            title: Text(
              widget.name,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text('Codigo: #${widget.code}'),
          ),
        ));
  }
}
