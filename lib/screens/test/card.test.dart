import 'package:flutter/material.dart';

void showCodePopup(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true, // Closes the popup when clicking outside
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent, // Keeps the underlying card styling crisp
        child: Container(
          // Adjust width constraints as needed for mobile/web
          constraints: const BoxConstraints(maxWidth: 600), 
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: const Color(0xff0d1117), // Dark editor background
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: Colors.blue.withOpacity(0.4), // Subtle blue border
              width: 1.5,
            ),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal, // Allows horizontal scrolling if text overflows
            child: SelectableText.rich(
              TextSpan(
                style: const TextStyle(
                  fontFamily: 'Courier', // Use a monospace font for code look
                  fontSize: 14,
                  height: 1.5,
                ),
                children: [
                  const TextSpan(text: "1  const ", style: TextStyle(color: Colors.blue)),
                  const TextSpan(text: "developer = {\n", style: TextStyle(color: Colors.yellow)),
                  
                  const TextSpan(text: "2    name: ", style: TextStyle(color: Colors.lightBlueAccent)),
                  TextSpan(text: "'Binay Kumar Das',\n", style: TextStyle(color: Colors.orange[300])),
                  
                  const TextSpan(text: "3    location: ", style: TextStyle(color: Colors.lightBlueAccent)),
                  TextSpan(text: "'Bhubaneswar, India',\n", style: TextStyle(color: Colors.orange[300])),
                  
                  const TextSpan(text: "4    role: ", style: TextStyle(color: Colors.lightBlueAccent)),
                  TextSpan(text: "'Senior Software Engineer',\n", style: TextStyle(color: Colors.orange[300])),
                  
                  const TextSpan(text: "5    stack: ", style: TextStyle(color: Colors.lightBlueAccent)),
                  TextSpan(text: "['React', 'Angular', 'Node', 'TypeScript'],\n", style: TextStyle(color: Colors.orange[300])),
                  
                  const TextSpan(text: "6    passion: ", style: TextStyle(color: Colors.lightBlueAccent)),
                  TextSpan(text: "'Crafting seamless digital experiences',\n", style: TextStyle(color: Colors.orange[300])),
                  
                  const TextSpan(text: "7  };", style: TextStyle(color: Colors.yellow)),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}