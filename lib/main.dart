// Import the Flutter Material package, which provides Material Design widgets.
import 'package:flutter/material.dart';

// The main function is the entry point of the Flutter app.
void main() {
  // runApp sets up the root widget of the app.
  runApp(
    // MaterialApp is the top-level widget that sets up app-wide settings.
    MaterialApp(
      // The home property defines the default screen of the app.
      home: Scaffold(
        // Sets the scaffold background to transparent so the gradient shows through.
        backgroundColor: Colors.transparent,

        // The body is the main content of the screen.
        body: Container(
          // Makes the container fill the entire width of the screen.
          width: double.infinity,

          // Makes the container fill the entire height of the screen.
          height: double.infinity,

          // Adds a background decoration to the container.
          decoration: BoxDecoration(
            // Adds a linear gradient background that transitions between two colors.
            gradient: LinearGradient(
              // Starts the gradient from the top-left corner.
              begin: Alignment.topLeft,

              // Ends the gradient at the bottom-right corner.
              end: Alignment.bottomRight,

              // Defines the two colors used in the gradient.
              colors: [
                const Color.fromARGB(255, 237, 42, 247), // A pink color
                const Color.fromARGB(255, 97, 0, 89), // A dark purple color
              ],
            ),
          ),

          // Child widget of the container: centers its content.
          child: Center(
            // Displays the text in the center of the screen.
            child: Text(
              'Tic Tac Toe Game', // The text to display.
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24, // Sets the font size.
                color: Colors.white, // Makes the text white.
              ),
            ),
          ),
        ),
      ),
    ),
  );
}