import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/constants.dart';
import '../core/document_service.dart';
import '../core/mfine_loader.dart';
import 'invoice_screen.dart';

class InvoiceDetailScreen extends StatelessWidget {
  final InvoiceModel invoice;

  const InvoiceDetailScreen({
    super.key,
    required this.invoice,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              // ===============================================================
              // TOP BAR
              // ===============================================================
              _topBar(context),

              // ===============================================================
              // INVOICE DOCUMENT
              // ===============================================================
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 40,
                    ),
                    child: _InvoiceDocument(
                      invoice: invoice,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topBar(BuildContext context) {
    return SizedBox(
      height: 72,
      child: Row(
        children: [
          // ---------------------------------------------------------------
          // BACK
          // ---------------------------------------------------------------
          IconButton(
            onPressed: () {
              Navigator.of(context).maybePop();
            },
            padding: const EdgeInsets.only(
              left: 20,
            ),
            alignment: Alignment.centerLeft,
            icon: const Icon(
              Icons.arrow_back,
              size: 31,
              color: Color(0xFF71828E),
            ),
          ),

          const Spacer(),

          // ---------------------------------------------------------------
          // DOWNLOAD
          // ---------------------------------------------------------------
          _circleAction(
            icon: Icons.download_rounded,
            tooltip: 'Download',
            onTap: () async {
              await runWithMfineLoader(
                context,
                () => MfineDocumentService.downloadInvoice(
                  invoice.invoiceNumber.replaceFirst('#', ''),
                  invoice.date,
                  invoice.amount,
                ),
                message: 'Preparing your invoice...',
              );
            },
          ),

          const SizedBox(width: 14),

          // ---------------------------------------------------------------
          // SHARE
          // ---------------------------------------------------------------
          _circleAction(
            icon: Icons.share_outlined,
            tooltip: 'Share',
            onTap: () async {
              await runWithMfineLoader(
                context,
                () => MfineDocumentService.shareInvoice(
                  invoice.invoiceNumber.replaceFirst('#', ''),
                  invoice.date,
                  invoice.amount,
                ),
                message: 'Preparing invoice for sharing...',
              );
            },
          ),

          const SizedBox(width: 16),
        ],
      ),
    );
  }

  Widget _circleAction({
    required IconData icon,
    required String tooltip,
    required VoidCallback onTap,
  }) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: const Color(0xFFF0F0F0),
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: SizedBox(
            width: 54,
            height: 54,
            child: Icon(
              icon,
              size: 29,
              color: const Color(0xFF5E6870),
            ),
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// INVOICE DOCUMENT
// =============================================================================

class _InvoiceDocument extends StatelessWidget {
  final InvoiceModel invoice;

  const _InvoiceDocument({
    required this.invoice,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (
        BuildContext context,
        BoxConstraints constraints,
      ) {
        final width = constraints.maxWidth;

        return Container(
          width: width,
          color: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.064,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =============================================================
              // POWERED BY MFINE
              // =============================================================
              const Row(
                children: [
                  Text(
                    'Powered By mfine',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 9),
                  Icon(
                    Icons.monitor_heart_rounded,
                    size: 14,
                    color: Color(0xFF00A6BC),
                  ),
                ],
              ),

              const SizedBox(height: 35),

              // =============================================================
              // LOGO + TAX INVOICE
              // =============================================================
              LayoutBuilder(
                builder: (context, constraints) {
                  final compact = constraints.maxWidth < 340;

                  return compact
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 72,
                              height: 72,
                              decoration: BoxDecoration(
                                color: AppConstants.teal,
                                borderRadius: BorderRadius.circular(28),
                              ),
                              child: const Icon(
                                Icons.monitor_heart_rounded,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 18),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'TAX INVOICE',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Invoice #',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  'S2756834641192',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Invoice Date',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  'September 18th 2026',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 72,
                              height: 72,
                              decoration: BoxDecoration(
                                color: AppConstants.teal,
                                borderRadius: BorderRadius.circular(28),
                              ),
                              child: const Icon(
                                Icons.monitor_heart_rounded,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                            const Spacer(),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'TAX INVOICE',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Invoice #',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  'S2756834641192',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Invoice Date',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  'September 18th 2026',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                },
              ),

              const SizedBox(height: 22),

              // =============================================================
              // BILLING INFORMATION
              // =============================================================
              LayoutBuilder(
                builder: (context, constraints) {
                  final compact = constraints.maxWidth < 360;

                  return compact
                      ? const Wrap(
                          spacing: 20,
                          runSpacing: 18,
                          children: [
                            SizedBox(
                              width: 160,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Billing From',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'mfine Healthcare',
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Address',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 160,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Billing To',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Disha Sankneniwar',
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Billing From',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'mfine Healthcare',
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Address',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 24),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Billing To',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Disha Sankneniwar',
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                },
              ),

              const SizedBox(height: 48),

              // =============================================================
              // TABLE
              // =============================================================
              _invoiceTable(invoice),

              const SizedBox(height: 17),

              const Text(
                'SAC code : 998319',
                style: TextStyle(
                  fontSize: 11,
                ),
              ),

              const Text(
                'Place of supply - Karnataka (29)',
                style: TextStyle(
                  fontSize: 11,
                ),
              ),

              const SizedBox(height: 70),

              // =============================================================
              // NOTES
              // =============================================================
              const Text(
                'NOTES',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                'The invoice is a computer generated invoice, hence no signature is required',
                style: TextStyle(
                  fontSize: 9,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ==========================================================================
  // INVOICE TABLE
  // ==========================================================================

  Widget _invoiceTable(
    InvoiceModel invoice,
  ) {
    return Table(
      border: TableBorder.all(
        color: const Color(0xFF404040),
        width: 0.8,
      ),
      columnWidths: const {
        0: FlexColumnWidth(5.6),
        1: FlexColumnWidth(0.8),
        2: FlexColumnWidth(1),
      },
      children: [
        const TableRow(
          children: [
            _TableCell(
              'Product',
              bold: true,
            ),
            _TableCell(
              'Qty',
              bold: true,
            ),
            _TableCell(
              'Price',
              bold: true,
            ),
          ],
        ),
        TableRow(
          children: [
            _TableCell(
              invoice.product,
              bold: true,
            ),
            const _TableCell('1'),
            _TableCell(
              invoice.priceBeforeTax,
            ),
          ],
        ),
        TableRow(
          children: [
            const _TableCell(
              'Total',
              bold: true,
              alignEnd: true,
            ),
            const _TableCell(''),
            _TableCell(
              invoice.priceBeforeTax,
              bold: true,
              alignEnd: true,
            ),
          ],
        ),
        TableRow(
          children: [
            const _TableCell(
              'Tax (18.00 %)',
              bold: true,
              alignEnd: true,
            ),
            const _TableCell(''),
            _TableCell(
              invoice.tax,
              bold: true,
              alignEnd: true,
            ),
          ],
        ),
        TableRow(
          children: [
            const _TableCell(
              'Amount Payable',
              bold: true,
              alignEnd: true,
            ),
            const _TableCell(''),
            _TableCell(
              '₹${invoice.amount}',
              bold: true,
              alignEnd: true,
            ),
          ],
        ),
      ],
    );
  }
}

class _TableCell extends StatelessWidget {
  final String text;
  final bool bold;
  final bool alignEnd;

  const _TableCell(
    this.text, {
    this.bold = false,
    this.alignEnd = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 6,
      ),
      child: Align(
        alignment: alignEnd ? Alignment.centerRight : Alignment.centerLeft,
        child: Text(
          text,
          textAlign: alignEnd ? TextAlign.right : TextAlign.left,
          style: TextStyle(
            fontSize: 11,
            fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
