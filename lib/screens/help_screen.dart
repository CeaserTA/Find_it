import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  final Color _mainColor = const Color(0xFF42A5F5);

  final List<Map<String, String>> _faqs = const [
    {
      'question': 'How do I post a lost item?',
      'answer':
          'Tap the blue "Report Lost" button (plus icon) on the main feed. Fill in the item details, location, and upload a photo, then submit.',
    },
    {
      'question': 'What should I do if I find an item?',
      'answer':
          'Tap the blue "Report Found" button. Provide clear details about the item and the exact location where you found it. Do NOT share your personal contact information.',
    },
    {
      'question': 'How does the category filter work?',
      'answer':
          'The category chips (e.g., Electronics, Keys) allow you to quickly narrow down the list view to only see items matching that specific type.',
    },
    {
      'question': 'How do I contact the person who posted an item?',
      'answer':
          'Once you view the item details, there will be a contact option (usually via the app\'s secure messaging or provided email/phone) to reach out to the poster.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Help & FAQs",
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
              child: Text(
                "Frequently Asked Questions",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // FAQ List
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final faq = _faqs[index];
                return _FaqCard(
                  question: faq['question']!,
                  answer: faq['answer']!,
                  mainColor: _mainColor,
                );
              },
              childCount: _faqs.length,
            ),
          ),

          // Feedback Section
          const SliverToBoxAdapter(child: SizedBox(height: 40)),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "We want to hear from you",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              child: Text(
                "Whether you're having a good or bad experience, your feedback helps us improve the app.",
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: isDark ? Colors.white70 : Colors.black54,
                ),
              ),
            ),
          ),

          // Feedback Form Card
          SliverToBoxAdapter(
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: _FeedbackForm(),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }
}

// FAQ Card (unchanged)
class _FaqCard extends StatefulWidget {
  final String question;
  final String answer;
  final Color mainColor;

  const _FaqCard({
    required this.question,
    required this.answer,
    required this.mainColor,
  });

  @override
  State<_FaqCard> createState() => _FaqCardState();
}

class _FaqCardState extends State<_FaqCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      elevation: _expanded ? 8 : 2,
      shadowColor: _expanded ? widget.mainColor.withOpacity(0.25) : null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: ExpansionTile(
          shape: const Border(),
          collapsedBackgroundColor: isDark ? Colors.grey[850] : Colors.grey[50],
          backgroundColor: isDark ? Colors.grey[900] : Colors.white,
          iconColor: widget.mainColor,
          collapsedIconColor: theme.iconTheme.color,
          onExpansionChanged: (value) => setState(() => _expanded = value),
          title: Text(
            widget.question,
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              child: Text(
                widget.answer,
                style: theme.textTheme.bodyMedium?.copyWith(
                  height: 1.5,
                  color: isDark ? Colors.white70 : Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// New Feedback Form Widget
class _FeedbackForm extends StatefulWidget {
  const _FeedbackForm();

  @override
  State<_FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<_FeedbackForm> {
  final TextEditingController _controller = TextEditingController();
  final Color _mainColor = const Color(0xFF42A5F5);
  bool _isSending = false;

  Future<void> _sendFeedback() async {
    if (_controller.text.trim().isEmpty) return;

    setState(() => _isSending = true);

    // Simulate sending (replace with your actual API call)
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Thank you! Your feedback has been sent."),
        backgroundColor: Colors.green,
      ),
    );

    _controller.clear();
    setState(() => _isSending = false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              maxLines: 6,
              textInputAction: TextInputAction.newline,
              decoration: InputDecoration(
                hintText: "Tell us what you think...",
                filled: true,
                fillColor: isDark ? Colors.grey[800] : Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isSending ? null : _sendFeedback,
              style: ElevatedButton.styleFrom(
                backgroundColor: _mainColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
              ),
              child: _isSending
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(
                      "Send Feedback",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}