import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InvoiceModel {
  final String title;
  final String invoiceNumber;
  final String date;
  final int amount;
  final String product;
  final String priceBeforeTax;
  final String tax;

  const InvoiceModel({
    required this.title,
    required this.invoiceNumber,
    required this.date,
    required this.amount,
    required this.product,
    required this.priceBeforeTax,
    required this.tax,
  });
}

const invoiceData = <InvoiceModel>[
  InvoiceModel(
    title: 'MFine ONE Membership - 3 months',
    invoiceNumber: '#6aada012dd8e507e97...',
    date: '18th Sep 2026',
    amount: 249,
    product: 'MFine ONE Membership - 3 months',
    priceBeforeTax: '211.02',
    tax: '37.98',
  ),
  InvoiceModel(
    title: 'Online Consultation',
    invoiceNumber: '#6aaccf2ad8e50770ee...',
    date: '18th Sep 2026',
    amount: 454,
    product: 'Online Consultation',
    priceBeforeTax: '384.75',
    tax: '69.25',
  ),
];

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 74,
        title: const Text(
          'Invoice',
          style: TextStyle(
            color: Colors.black,
            fontSize: 23,
            fontWeight: FontWeight.w800,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).maybePop();
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 31,
            color: Color(0xFF71818D),
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: ListView.separated(
          padding: const EdgeInsets.fromLTRB(
            24,
            15,
            24,
            30,
          ),
          itemCount: invoiceData.length,
          separatorBuilder: (_, __) => const SizedBox(height: 14),
          itemBuilder: (context, index) {
            final invoice = invoiceData[index];

            return _InvoiceCard(
              invoice: invoice,
              onTap: () {
                context.push(
                  '/invoice-detail',
                  extra: invoice,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _InvoiceCard extends StatelessWidget {
  final InvoiceModel invoice;
  final VoidCallback onTap;

  const _InvoiceCard({
    required this.invoice,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  26,
                  27,
                  24,
                  0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ---------------------------------------------------------
                    // TITLE
                    // ---------------------------------------------------------
                    Text(
                      invoice.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF5B6873),
                        fontSize: 21,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // ---------------------------------------------------------
                    // INVOICE NUMBER + TOTAL
                    // ---------------------------------------------------------
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            'INVOICE ${invoice.invoiceNumber}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Color(0xFF171B20),
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Total',
                          style: TextStyle(
                            color: Color(0xFF7A8791),
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // ---------------------------------------------------------
                    // DATE + VIEW + AMOUNT + PAID
                    // ---------------------------------------------------------
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final compact = constraints.maxWidth < 340;

                        if (!compact) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  invoice.date,
                                  style: const TextStyle(
                                    color: Color(0xFF171B20),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              GestureDetector(
                                onTap: onTap,
                                child: const Text(
                                  'View Invoice',
                                  style: TextStyle(
                                    color: Color(0xFFA2ADB6),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Flexible(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.centerRight,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '₹${invoice.amount}',
                                        style: const TextStyle(
                                          color: Color(0xFF273139),
                                          fontSize: 21,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      const _PaidStamp(),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              invoice.date,
                              style: const TextStyle(
                                color: Color(0xFF171B20),
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: onTap,
                                  child: const Text(
                                    'View Invoice',
                                    style: TextStyle(
                                      color: Color(0xFFA2ADB6),
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '₹${invoice.amount}',
                                        style: const TextStyle(
                                          color: Color(0xFF273139),
                                          fontSize: 21,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const _PaidStamp(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),

              // ---------------------------------------------------------------
              // JAGGED BOTTOM
              // ---------------------------------------------------------------
              const _JaggedBottom(),
            ],
          ),
        ),
      ),
    );
  }
}

class _PaidStamp extends StatelessWidget {
  const _PaidStamp();

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -0.16,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 2,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFF20C842),
            width: 3,
          ),
          borderRadius: BorderRadius.circular(7),
        ),
        child: const Text(
          'PAID',
          style: TextStyle(
            color: Color(0xFF20C842),
            fontSize: 18,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.3,
          ),
        ),
      ),
    );
  }
}

class _JaggedBottom extends StatelessWidget {
  const _JaggedBottom();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 14,
      width: double.infinity,
      child: CustomPaint(
        painter: _JaggedPainter(),
      ),
    );
  }
}

class _JaggedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFFF1F4FA);

    const double toothWidth = 12;

    final path = Path();

    path.moveTo(0, size.height);

    for (double x = 0; x < size.width; x += toothWidth) {
      path.lineTo(
        x + toothWidth / 2,
        0,
      );

      path.lineTo(
        x + toothWidth,
        size.height,
      );
    }

    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) {
    return false;
  }
}
