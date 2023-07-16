import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:textcraft/components/ele_button.dart';

import '../components/loading_widget.dart';
import 'output_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void goBack() {
    _inputTextController.clear();
  }

  final String _rephrasePrompt =
      'Rephrase this Text. If the given text is a question, don\'t straight away give the answer, just Rephrase the given Input Text. If you feel given sentence is incomplete, dont complete the remaining sentence, just rephrase until the given input input text, that\'s enough, don\'t give the expected comeplete sentence. Now follow all these instructions carefully and Rephrase the below text';

  final String _summarizePrompt =
      'Summarize this given Text in shorter length than the input text in a very simple way. If the given text is a question, don\'t straight away give the answer to that question, instead summarize the question, so what i wanna say is.. just Summarize the given Input Text. If you feel given sentence is incomplete, dont complete the remaining sentence, just summarize until the given input input text, that\'s enough. Now follow all these instructions carefully and Summarize the below text';
  final _inputTextController = TextEditingController();
  late OpenAI openAI;

  void initState() {
    openAI = OpenAI.instance
        .build(token: 'Your_API_KEY'); // Replace with your API key
    super.initState();
  }

  void summarize() async {
    if (_inputTextController.text.isEmpty) {
      _showSnackBar('Missing input! Please Enter some text ');
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text('Summarizing...')),
          content: Container(
            height: 100,
            child: SingleChildScrollView(
              child: Center(child: LoadingWidget()),
            ),
          ),
        );
      },
    );

    try {
      final completionContext = await openAI.onCompletion(
        request: CompleteText(
          prompt: _summarizePrompt + _inputTextController.text + '.',
          maxTokens: 500,
          model: TextDavinci3Model(),
        ),
      );
      Navigator.pop(context);

      if (completionContext != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OutputPage(
              title: 'Summarized Text',
              outputText: completionContext.choices.first.text,
              goBack: goBack,
              rephrase: rephrase,
              summarize: summarize,
            ),
          ),
        );
      } else {
        _showErrorDialog('Oops! Looks like API key is down');
      }
    } catch (error) {
      _showErrorDialog(
          'Please wait until Mr.Ganesh updates the API key.. or else message him so that he may do it faster');
    }
  }

  void rephrase() async {
    if (_inputTextController.text.isEmpty) {
      _showSnackBar('Missing input! Please Enter some text');
      return;
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text('Rephrasing...')),
          content: Container(
            height: 100,
            child: SingleChildScrollView(
              child: Center(child: LoadingWidget()),
            ),
          ),
        );
      },
    );
    try {
      final completionContext = await openAI.onCompletion(
        request: CompleteText(
          prompt: _rephrasePrompt + _inputTextController.text + '.',
          maxTokens: 500,
          model: TextDavinci3Model(),
        ),
      );
      Navigator.pop(context);

      if (completionContext != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OutputPage(
              title: 'Rephrased Text',
              outputText: completionContext.choices.first.text,
              goBack: goBack,
              rephrase: rephrase,
              summarize: summarize,
            ),
          ),
        );
      } else {
        _showErrorDialog('Oops! Unable to fetch data from API.');
      }
    } catch (error) {
      _showErrorDialog(
          'Please Wait until Mr. Ganesh Updates the API Key or ping him so that he updates it quickly ');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
          ),
        ),
        content: Container(
          padding: EdgeInsets.fromLTRB(
              16.0, 12.0, 16.0, MediaQuery.of(context).padding.bottom + 12.0),
          child: Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Oops Looks like the API key is down'),
          content: Text(
            message,
            textAlign: TextAlign.center,
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: Icon(Icons.home),
        backgroundColor: Colors.grey[900],
        title: Text('TextCraft AI'),
        centerTitle: true,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text('Are you sure, You want to Logout?'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('No')),
                        TextButton(
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                              Navigator.pop(context);
                            },
                            child: Text('Yes'))
                      ],
                    );
                  });
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(Icons.logout),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade600, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _inputTextController,
                      maxLines: null,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText:
                              'Enter your Text here to Summarize or Rewrite'),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                EleButton(onPressed: summarize, text: 'Summarize'),
                EleButton(onPressed: rephrase, text: 'Rephrase'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
