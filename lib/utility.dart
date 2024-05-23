import 'package:intl/intl.dart';

String formatCurrencyCOP(int num) {
  final formatador =
      NumberFormat.currency(locale: 'es_CO', symbol: '\$', decimalDigits: 0);
  return '${formatador.format(num)} COP';
}
