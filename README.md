# TextCraft AI

TextCraft AI is a Flutter-based application that utilizes OpenAI's GPT-3 model to provide text summarization and rephrasing capabilities. It allows users to input text and generate concise summaries or rephrased versions of the input.

## Features

- **Summarize Text:** The application can generate a summary of a given text input. The summarization process condenses the input into a shorter length while preserving key information.
- **Rephrase Text:** Users can rephrase a given text input. This feature is useful for generating alternative versions of sentences or paragraphs without altering the original meaning.
- **Regenerate Output:** Users have the option to regenerate the output text, providing different variations of summaries or rephrased versions each time the "Regenerate" button is pressed.
- **Copy to Clipboard:** The application allows users to copy the output text to their device's clipboard with a single click, making it convenient for further use or sharing.

## Getting Started

To run the TextCraft AI application locally, follow these steps:

1. Clone the repository:
`git clone https://github.com/ganesh-vallabhareddy/TextCraft-AI.git`

2. Navigate to the project directory:
`cd TextCraft-AI`

3. Install the dependencies:
`flutter pub get`

4. Connect to an Android or iOS device (physical or emulator).

5. Run the application:
`flutter run`

## Dependencies

The TextCraft AI application utilizes the following dependencies:

- `flutter/material.dart`: The Flutter framework for building the UI.
- `chat_gpt_sdk`: The ChatGPT SDK for communicating with OpenAI's GPT-3 model.
- `firebase_auth`: The Firebase Authentication library for user authentication.
- `flutter/services.dart`: The Flutter services library for accessing the device's clipboard.
- `loading_widget.dart`: A custom widget for displaying loading spinners during API calls.

## Contributing

Contributions to the TextCraft AI project are welcome! If you encounter any issues or have suggestions for improvements, feel free to open an issue or submit a pull request. Make sure to follow the existing code style and guidelines.


