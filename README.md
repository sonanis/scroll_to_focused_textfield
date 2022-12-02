

## Features

prevents TextField from being obscured by the keyboard.

## Getting started

```
dependencies:
  scroll_to_focused_textfield:
    git:
      url: https://github.com/sonanis/scroll_to_focused_textfield
```

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder. 

```dart
import 'package:flutter/material.dart';
import 'package:scroll_to_focused_textfield/scroll_to_focused_textfield.dart';

class TestScrollToFocused extends StatefulWidget {
  const TestScrollToFocused({Key? key}) : super(key: key);

  @override
  State<TestScrollToFocused> createState() => _TestScrollToFocusedState();
}

class _TestScrollToFocusedState extends State<TestScrollToFocused> {
  @override
  Widget build(BuildContext context) {
    return ScrollToFocusedTextField(
      child: Scaffold(
        /// sometimes we ware demanded keep size
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: Text('Test'),),
        /// TextField must be placed in scrollable widget
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              _buildContainer(Colors.red),
              _buildContainer(Colors.yellow),
              _buildContainer(Colors.blue),
              _buildTextField(),

              /// Add an empty widget of height MediaQuery.of(context).viewInsets.bottom
              Container(
                height: MediaQuery.of(context).viewInsets.bottom,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(){
    return Container(
      height: 150,
      child: TextField(
        minLines: 99,
        maxLines: 999,
        decoration: InputDecoration(
          hintText: 'TextField',
        ),
      ),
    );
  }

  Widget _buildContainer(Color color){
    return Container(
      height: 150,
      color: color,
    );
  }
}
```

