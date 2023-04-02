//Argumentos entre pantallas

import 'dart:io';
import 'package:extructura_app/src/models/api_Invoice_models/invoice_model.dart';

class PageArgs {
  File? pdfFileToShow;
  InvoiceModel? invoice;

  PageArgs({
    this.pdfFileToShow,
    this.invoice,
  });
}
