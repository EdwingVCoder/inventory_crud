import 'package:flutter/material.dart';
import 'package:inventory_crud/widgets.dart';
import 'package:inventory_crud/database.dart';
import 'package:inventory_crud/utility.dart';

class DialogController {
  // Database Class
  late final Database database;

  // Constructor
  DialogController(this.database);

  // Create Controllers
  TextEditingController createCodeController = TextEditingController();
  TextEditingController createNameController = TextEditingController();
  TextEditingController createBuyPriceController = TextEditingController();
  TextEditingController createSellPriceController = TextEditingController();
  TextEditingController createStockController = TextEditingController();

  // Update Controllers
  TextEditingController updateCodeController = TextEditingController();
  TextEditingController updateNameController = TextEditingController();
  TextEditingController updateBuyPriceController = TextEditingController();
  TextEditingController updateSellPriceController = TextEditingController();
  TextEditingController updateStockController = TextEditingController();

  // Función Crear

  void createDialog(context) async {
    createCodeController.text = '';
    createNameController.text = '';
    createBuyPriceController.text = '';
    createSellPriceController.text = '';
    createStockController.text = '';
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Crear Producto',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            content: SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: ListBody(
                children: [
                  CodeInput(
                    controller: createCodeController,
                    hintText: 'Código',
                  ),
                  const SizedBox(height: 15),
                  TextInput(
                    controller: createNameController,
                    hintText: 'Nombre',
                  ),
                  const SizedBox(height: 15),
                  MoneyInput(
                    controller: createBuyPriceController,
                    hintText: 'Precio Compra',
                  ),
                  const SizedBox(height: 15),
                  MoneyInput(
                    controller: createSellPriceController,
                    hintText: 'Precio Venta',
                  ),
                  const SizedBox(height: 15),
                  StockInput(
                    controller: createStockController,
                    hintText: 'Stock',
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  int code = int.parse(createCodeController.text);
                  String name = createNameController.text;
                  int buyPrice = int.parse(createBuyPriceController.text);
                  int sellPrice = int.parse(createSellPriceController.text);
                  int stock = int.parse(createStockController.text);
                  database.addDocument(code, name, buyPrice, sellPrice, stock);
                  Navigator.pop(context);
                },
                child: const Text('Crear'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancelar'),
              ),
            ],
          );
        });
  }

  // Read Dialog
  void viewDataDialog(
      context, docID, code, name, buyPrice, sellPrice, stock) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              '$name - #$code',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            content: SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: ListBody(
                children: [
                  productData('Precio Compra', formatCurrencyCOP(buyPrice)),
                  productData('Precio Venta', formatCurrencyCOP(sellPrice)),
                  productData('Stock', '$stock Unidades')
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  updateDataDialog(
                      context, docID, code, name, buyPrice, sellPrice, stock);
                },
                child: const Text('Editar'),
              ),
              TextButton(
                onPressed: () {
                  deleteDataDialog(context, docID, code, name);
                },
                child: const Text('Eliminar'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cerrar'),
              ),
            ],
          );
        });
  }

  // Update Dialog
  void updateDataDialog(
      context, docID, code, name, buyPrice, sellPrice, stock) async {
    updateCodeController.text = code.toString();
    updateNameController.text = name;
    updateBuyPriceController.text = buyPrice.toString();
    updateSellPriceController.text = sellPrice.toString();
    updateStockController.text = stock.toString();
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Actualizar Producto',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            content: SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: ListBody(
                children: [
                  CodeInput(
                      controller: updateCodeController, hintText: '#$code'),
                  const SizedBox(height: 15),
                  TextInput(controller: updateNameController, hintText: name),
                  const SizedBox(height: 15),
                  MoneyInput(
                      controller: updateBuyPriceController,
                      hintText: '\$$buyPrice COP'),
                  const SizedBox(height: 15),
                  MoneyInput(
                      controller: updateSellPriceController,
                      hintText: '\$$sellPrice COP'),
                  const SizedBox(height: 15),
                  StockInput(
                      controller: updateStockController,
                      hintText: '$stock Unidades'),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  int code = int.parse(updateCodeController.text);
                  String name = updateNameController.text;
                  int buyPrice = int.parse(updateBuyPriceController.text);
                  int sellPrice = int.parse(updateSellPriceController.text);
                  int stock = int.parse(updateStockController.text);
                  database.updateDocument(
                      docID, code, name, buyPrice, sellPrice, stock);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text('Guardar'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancelar'),
              ),
            ],
          );
        });
  }

  // Delete Dialog
  void deleteDataDialog(context, docID, code, name) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Eliminar Producto',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            content: SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: ListBody(
                children: [
                  productData('Nombre', name),
                  const SizedBox(height: 15),
                  productData('Código', '#$code')
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  database.deleteDocument(docID);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text('Eliminar'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancelar'),
              ),
            ],
          );
        });
  }

  // View Report
  void viewReportDialog(context) async {
    List<int> report = await database.getReport();
    int patrimony = report[0];
    int totalSells = report[1];
    int estimatedProfits = report[2];

    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Reporte de patrimonio',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            content: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: ListBody(
                  children: [
                    productData('Patrimonio', formatCurrencyCOP(patrimony)),
                    productData('Total Ventas', formatCurrencyCOP(totalSells)),
                    productData('Ganancias esperadas',
                        formatCurrencyCOP(estimatedProfits))
                  ],
                )),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cerrar'))
            ],
          );
        });
  }
}
