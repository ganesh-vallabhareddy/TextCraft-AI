import 'package:flutter/material.dart';
import 'package:textcraft/components/ele_button.dart';
import 'package:flutter/services.dart';

class OutputPage extends StatefulWidget {
  final String title;
  final String outputText;
  final Function goBack;
  final Function summarize;
  final Function rephrase;

  const OutputPage({
    Key? key,
    required this.title,
    required this.outputText,
    required this.goBack,
    required this.summarize,
    required this.rephrase,
  }) : super(key: key);

  @override
  State<OutputPage> createState() => _OutputPageState();
}

class _OutputPageState extends State<OutputPage> {
  String _regeneratedOutput = '';
  bool _isRegenerating = false;

  void regenerateOutput() async {
    setState(() {
      _isRegenerating = true;
    });

  
    setState(() {
      _isRegenerating = false;
      if (widget.title == 'Summarized Text') {
        _regeneratedOutput = '';
        widget.summarize(); // Summarize the regenerated output
      } else if (widget.title == 'Rephrased Text') {
        _regeneratedOutput = '';
        widget.rephrase(); // Rephrase the regenerated output
      }
    });
  }

  void navigateToHome() {
    widget.goBack();
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    final snackBar = SnackBar(content: Text('Text copied to clipboard'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            navigateToHome();
          },
          child: Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: Colors.grey[900],
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {
                      copyToClipboard(widget.outputText);
                    },
                    icon: Icon(Icons.copy),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Container(
                height: MediaQuery.of(context).size.height * 0.35,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade600, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.only(
                  left: 6,
                  right: 6,
                ),
                child: SelectableText(
                  widget.outputText,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  EleButton(
                    onPressed: () {
                      widget.goBack(); // Call the function here
                      navigateToHome();
                    },
                    text: 'Go Back',
                  ),
                  EleButton(
                    onPressed: regenerateOutput,
                    text: 'Regenerate',
                  ),
                ],
              ),
              SizedBox(height: 20),
              if (_regeneratedOutput.isNotEmpty && !_isRegenerating)
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade600, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          copyToClipboard(_regeneratedOutput);
                        },
                        icon: Icon(Icons.copy),
                      ),
                      Expanded(
                        child: SelectableText(
                          _regeneratedOutput,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
