import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/constants.dart';
import '../core/document_service.dart';
import '../core/interaction_feedback.dart';
import '../core/mfine_loader.dart';
import '../widgets/doctor_card.dart';
import '../widgets/search_bar.dart';

class ConsultScreen extends StatefulWidget {
  const ConsultScreen({super.key});
  @override
  State<ConsultScreen> createState() => _ConsultScreenState();
}

class _ConsultScreenState extends State<ConsultScreen> {
  bool previousFirst = true;

  void _openConsultation(DoctorData doctor) {
    if (doctor.name == 'Dr. Prem Prakash Bansal (Pulmonologist)') {
      context.push('/consult-room');
      return;
    }
    showNetworkErrorDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F5),
      appBar: AppBar(
        title: const Text('Consult India’s Top Doctors'),
        leading: IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: const Icon(Icons.arrow_back_rounded)),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(12, 0, 12, 8),
        child: Container(
          height: 62,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: const [
                BoxShadow(
                    color: Color(0x16000000),
                    blurRadius: 16,
                    offset: Offset(0, 6))
              ]),
          child: Row(children: [
            Expanded(
                child: InkWell(
                    onTap: () {},
                    child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.tune, color: AppConstants.tealDark),
                          SizedBox(width: 8),
                          Text('Filters',
                              style: TextStyle(fontWeight: FontWeight.w800)),
                        ]))),
            const VerticalDivider(width: 1),
            Expanded(
                child: InkWell(
                    onTap: () {},
                    child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.sort_rounded,
                              color: AppConstants.tealDark),
                          SizedBox(width: 8),
                          Text('Sort',
                              style: TextStyle(fontWeight: FontWeight.w800)),
                        ]))),
          ]),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 100),
          children: [
            const MFineSearchBar(hint: 'Search for doctors or specialties'),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Row(children: [
                const CircleAvatar(
                    radius: 22,
                    backgroundColor: Color(0xFFEAF8FC),
                    child: Icon(Icons.person, color: AppConstants.tealDark)),
                const SizedBox(width: 11),
                const Expanded(
                    child: Text('Show doctors you consulted before',
                        style: TextStyle(
                            color: AppConstants.tealDark,
                            fontWeight: FontWeight.w800))),
                Switch(
                    value: previousFirst,
                    onChanged: (v) => setState(() => previousFirst = v)),
              ]),
            ),
            const SizedBox(height: 12),
            const Text('Showing earliest available doctors near you',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
            const SizedBox(height: 12),
            ...DoctorData.doctors.map((d) => DoctorCard(
                  doctor: d,
                  onConsult: () => _openConsultation(d),
                )),
          ],
        ),
      ),
    );
  }
}

class ConsultationRoomScreen extends StatefulWidget {
  const ConsultationRoomScreen({super.key, this.isDecemberRecord = false});

  final bool isDecemberRecord;

  @override
  State<ConsultationRoomScreen> createState() => _ConsultationRoomScreenState();
}

class _ChatMessage {
  final bool me;
  final String text;
  final String time;
  final String? label;
  final bool payment;
  final bool prescription;
  final String? prescriptionFileName;
  _ChatMessage(
      {required this.me,
      required this.text,
      required this.time,
      this.label,
      this.payment = false,
      this.prescription = false,
      this.prescriptionFileName});
}

class _ConsultationRoomScreenState extends State<ConsultationRoomScreen> {
  String get _chatDate => widget.isDecemberRecord ? '02 Dec 25' : '07 Sep 26';
  final _controller = TextEditingController();
  bool video = false;
  final List<_ChatMessage> _messages = [
    _ChatMessage(
        me: false,
        label: 'Dr. Ikram Khan',
        text:
            "Hi Disha Sankneniwar, I am Dr. Ikram Khan from Dr. Prem Prakash's team. I will now collect some information about general health before Dr. Prem Prakash speaks with you.",
        time: '02:37 PM'),
    _ChatMessage(
        me: false,
        label: 'Dr. Ikram Khan',
        text: 'In which language would you like to chat?',
        time: '02:37 PM'),
    _ChatMessage(
        me: true, label: 'Disha Sankneniwar', text: 'Hindi', time: '02:37 PM'),
    _ChatMessage(
        me: false,
        label: 'Dr. Ikram Khan',
        text:
            'Kya ye consultation Disha Sankneniwar ke liye hai? Confirm karein',
        time: '02:37 PM'),
    _ChatMessage(
        me: true, label: 'Disha Sankneniwar', text: 'Yes', time: '02:37 PM'),
    _ChatMessage(
        me: false,
        label: 'Dr. Ikram Khan',
        text: 'Height kitni hai',
        time: '02:37 PM'),
    _ChatMessage(
        me: true,
        label: 'Disha Sankneniwar',
        text: '5 ft 4 inches',
        time: '02:37 PM'),
    _ChatMessage(
        me: false,
        label: 'Dr. Ikram Khan',
        text: 'Wazan batayein',
        time: '02:37 PM'),
    _ChatMessage(
        me: true, label: 'Disha Sankneniwar', text: '58 kg', time: '02:37 PM'),
    _ChatMessage(
        me: false,
        label: 'Dr. Ikram Khan',
        text:
            'Kya ye consultation Disha Sankneniwar ke liye hai? Confirm karein',
        time: '02:37 PM'),
    _ChatMessage(
        me: true,
        label: 'Disha Sankneniwar',
        text: 'Chronic Cough',
        time: '02:38 PM'),
    _ChatMessage(
        me: false,
        label: 'Dr. Ikram Khan',
        text: 'Apni health problems ke baare mein thodi jankari dein.',
        time: '02:38 PM'),
    _ChatMessage(
        me: true,
        label: 'Disha Sankneniwar',
        text:
            'Chronic Cough\nSince: 1 days\nTriggered By: Weather\nType: Dry\nColor Of Sputum: Yellow\nAppetite: Decreased\nFever increases: Yes\nAssociated with fever: Yes',
        time: '02:38 PM'),
    _ChatMessage(
        me: false,
        label: 'Dr. Ikram Khan',
        text: 'Kya aapko kisi tarah ki allergy hai?',
        time: '02:43 PM'),
    _ChatMessage(
        me: true,
        label: 'Disha Sankneniwar',
        text: 'Drug allergy - No\n\nDust allergy - No',
        time: '02:43 PM'),
    _ChatMessage(
        me: false,
        label: 'Dr. Ikram Khan',
        text:
            'Dhanyawaad. Ab aapka appointment chune hue doctor, Dr. Prem Prakash ke sath book kar raha hoon.',
        time: '02:43 PM'),
    _ChatMessage(
        me: false,
        label: 'System',
        text: 'Your payment was successful',
        time: '02:45 PM',
        payment: true),
    _ChatMessage(
        me: false,
        label: 'Dr. Ikram Khan',
        text: 'Jankari ke liye dhanyawaad',
        time: '02:45 PM'),
    _ChatMessage(
        me: false,
        label: 'Dr. Ikram Khan',
        text:
            'Senior Doctor ke sath abhi case details share kar rahe hain..doctor aapse scheduled time pe baat karenge',
        time: '02:45 PM'),
    _ChatMessage(
        me: true,
        label: 'Disha Sankneniwar',
        text:
            'Hi doctor. I would like to\nhave this consultation over video to\nexplain my concerns',
        time: '05:34 PM'),
    _ChatMessage(
      me: false,
      label: 'Dr. Prem Prakash Bansal',
      text: 'hlo',
      time: '05:37 PM',
    ),
    _ChatMessage(
        me: true,
        label: 'Disha Sankneniwar',
        text: 'Hi doctor',
        time: '05:38 PM'),
    _ChatMessage(
        me: false,
        label: 'Dr. Prem Prakash',
        text: 'I. Avoid cold . Advliquid diet.\nAdv rest',
        time: '05:39 PM'),
    _ChatMessage(
        me: false,
        label: 'Dr. Prem Prakash Bansal',
        text: 'Prescription',
        time: '05:37 PM',
        prescription: true),
    _ChatMessage(
        me: false,
        label: 'Dr. Prem Prakash',
        text:
            'Prescription check karein.\nAgar koi sawal hai toh humein contact karein.',
        time: '05:37 PM'),
  ];

  final List<_ChatMessage> _decemberMessages = [
    _ChatMessage(
      me: false,
      label: 'Dr. Ikram Khan',
      text: 'Namaste Disha, aapki consultation details review kar raha hoon.',
      time: '11:10 AM',
    ),
    _ChatMessage(
      me: true,
      label: 'Disha Sankneniwar',
      text: 'Mujhe chest mein discomfort aur halki weakness hai.',
      time: '11:12 AM',
    ),
    _ChatMessage(
      me: false,
      label: 'Dr. Prem Prakash',
      text: 'Aap rest karein aur prescribed medicines time par lein.',
      time: '11:18 AM',
    ),
    _ChatMessage(
      me: false,
      label: 'Dr. Prem Prakash',
      text: 'Aapki December consultation prescription ready hai.',
      time: '11:20 AM',
      prescription: true,
      prescriptionFileName: 'Disha Prescription.pdf',
    ),
    _ChatMessage(
      me: false,
      label: 'Dr. Prem Prakash',
      text:
          'Prescription share karein aur koi doubt ho toh humein contact karein.',
      time: '11:21 AM',
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _send() {
    final value = _controller.text.trim();
    if (value.isEmpty) return;
    setState(() {
      _messages.add(_ChatMessage(
          me: true, label: 'Disha Sankneniwar', text: value, time: 'Now'));
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final compactLayout = screenWidth < 360;
    final messages = widget.isDecemberRecord ? _decemberMessages : _messages;

    return Scaffold(
      backgroundColor: const Color(0xFFFCFEFE),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(compactLayout ? 136 : 128),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Container(
                color: const Color(0xFFE6F7FB),
                padding: EdgeInsets.fromLTRB(
                    compactLayout ? 4 : 12, 8, compactLayout ? 4 : 12, 8),
                child: Row(children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    style: IconButton.styleFrom(backgroundColor: Colors.white),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  Expanded(
                    child: Text("Dr. Prem Prakash's\nConsultation Room",
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: compactLayout ? 16 : 18,
                            height: 1.2,
                            fontWeight: FontWeight.w900)),
                  ),
                  IconButton(
                    onPressed: () =>
                        showComingSoonDialog(context, 'Consultation help'),
                    style: IconButton.styleFrom(
                        backgroundColor: AppConstants.teal,
                        foregroundColor: Colors.white),
                    icon: const Icon(Icons.question_mark_rounded),
                  ),
                ]),
              ),
              Container(
                height: compactLayout ? 53 : 57,
                padding: const EdgeInsets.all(4),
                color: Colors.white,
                child: Row(children: [
                  Expanded(child: _tab('Chat', !video)),
                  Expanded(child: _tab('Video', video)),
                ]),
              ),
            ],
          ),
        ),
      ),
      body: video
          ? Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF12373F), Color(0xFF071619)]),
              ),
              child: const Column(mainAxisSize: MainAxisSize.min, children: [
                CircleAvatar(
                    radius: 42,
                    backgroundColor: Colors.white12,
                    child: Icon(Icons.person, size: 54, color: Colors.white)),
                SizedBox(height: 14),
                Text('Video consultation preview',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800)),
                SizedBox(height: 8),
                Text('Camera and microphone are simulated.',
                    style: TextStyle(color: Colors.white70)),
              ]),
            )
          : SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) => Stack(
                  children: [
                    ListView.builder(
                      padding: const EdgeInsets.fromLTRB(14, 14, 14, 96),
                      itemCount: messages.length,
                      itemBuilder: (_, i) {
                        final m = messages[i];
                        if (m.payment) return _paymentCard(m);
                        if (m.prescription) return _prescriptionCard(m);
                        return _bubble(m);
                      },
                    ),
                    Positioned(
                      left: 8,
                      right: 8,
                      bottom: MediaQuery.viewInsetsOf(context).bottom + 8,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () => showComingSoonDialog(
                                  context, 'File attachments'),
                              style: IconButton.styleFrom(
                                minimumSize: Size(compactLayout ? 48 : 56,
                                    compactLayout ? 48 : 56),
                                backgroundColor: Colors.white,
                                side:
                                    const BorderSide(color: AppConstants.teal),
                              ),
                              icon: const Icon(Icons.attach_file,
                                  color: AppConstants.tealDark),
                            ),
                            SizedBox(width: compactLayout ? 4 : 7),
                            Expanded(
                              child: TextField(
                                controller: _controller,
                                onSubmitted: (_) => _send(),
                                minLines: 1,
                                maxLines: compactLayout ? 3 : 4,
                                decoration: InputDecoration(
                                  hintText: 'Type here',
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 18, vertical: 15),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(28),
                                    borderSide: const BorderSide(
                                        color: Color(0xFFE1E8EA)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(28),
                                    borderSide: const BorderSide(
                                        color: AppConstants.teal, width: 1.5),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: compactLayout ? 4 : 7),
                            IconButton(
                              onPressed: _send,
                              style: IconButton.styleFrom(
                                  minimumSize: Size(compactLayout ? 48 : 56,
                                      compactLayout ? 48 : 56),
                                  backgroundColor: AppConstants.coral,
                                  foregroundColor: Colors.white),
                              icon: const Icon(Icons.send_rounded),
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _tab(String label, bool selected) {
    return GestureDetector(
      onTap: () => setState(() => video = label == 'Video'),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppConstants.coral : Colors.white,
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(label == 'Chat' ? 14 : 0),
            right: Radius.circular(label == 'Video' ? 14 : 0),
          ),
          border: Border.all(color: AppConstants.coral),
        ),
        child: Text(label,
            style: TextStyle(
                color: selected ? Colors.white : AppConstants.coral,
                fontSize: 16,
                fontWeight: FontWeight.w800)),
      ),
    );
  }

  Widget _bubble(_ChatMessage m) {
    return Align(
      alignment: m.me ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .78),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.fromLTRB(18, 14, 18, 12),
        decoration: BoxDecoration(
          color: m.me ? const Color(0xFFBDEFF8) : const Color(0xFFF0F0F0),
          borderRadius: BorderRadius.circular(23),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(m.label ?? '',
              style: const TextStyle(
                  color: Color(0xFF78939B),
                  fontWeight: FontWeight.w700,
                  fontSize: 12)),
          const SizedBox(height: 7),
          Text(m.text, style: const TextStyle(fontSize: 16, height: 1.38)),
          const SizedBox(height: 7),
          Align(
              alignment: Alignment.centerRight,
              child: Text('$_chatDate  ${m.time}',
                  style: const TextStyle(
                      color: Color(0xFF76909A), fontSize: 10.5))),
        ]),
      ),
    );
  }

  Widget _paymentCard(_ChatMessage m) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 26),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFD7DFE1)),
      ),
      child: Column(children: [
        const Text('Thank you!',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
        const SizedBox(height: 10),
        const Icon(Icons.check_circle_outline,
            color: AppConstants.tealDark, size: 52),
        const SizedBox(height: 8),
        Text(m.text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
      ]),
    );
  }

  Widget _prescriptionCard(_ChatMessage message) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(23),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message.label ?? '',
            style: const TextStyle(
              color: Color(0xFF78939B),
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          const Row(
            children: [
              Icon(Icons.picture_as_pdf_outlined,
                  color: AppConstants.tealDark, size: 30),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'prescription .pdf',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () async {
                try {
                  final path = await runWithMfineLoader(
                    context,
                    MfineDocumentService.downloadPrescription,
                    message: 'Downloading prescription...',
                  );
                  if (mounted && path != null) {
                    showMfineToast(
                      context,
                      'Prescription downloaded successfully',
                    );
                  }
                } catch (error) {
                  if (mounted) {
                    showMfineToast(
                      context,
                      'Could not download prescription',
                      isError: true,
                    );
                  }
                }
              },
              icon: const Icon(Icons.download_rounded),
              label: const Text('Download'),
              style: FilledButton.styleFrom(
                backgroundColor: AppConstants.coral,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '$_chatDate  ${message.time}',
              style: const TextStyle(
                color: Color(0xFF76909A),
                fontSize: 10.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
