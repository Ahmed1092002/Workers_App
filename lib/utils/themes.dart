import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled10/src/app_root.dart';
import 'package:untitled10/src/app_root.dart';

ThemeData lightTheme = ThemeData(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  scaffoldBackgroundColor: backgroundColor,
  brightness: Brightness.light,
  appBarTheme:  AppBarTheme(
    color: backgroundColor,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),

  ),
  dropdownMenuTheme: DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
    ),
    menuStyle:MenuStyle(
      backgroundColor: MaterialStateColor.resolveWith((states) => backgroundColor),

    ),

  ),



  textTheme:  TextTheme(
    bodyLarge: GoogleFonts.poppins(
      fontSize: 16,
      color: greenColor,
      fontWeight: FontWeight.bold,


    ),
    bodySmall: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: grayColor,
    ),

    bodyMedium: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: grayColor,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsets>(
        EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 10,
        ),
      ),

      backgroundColor: MaterialStateColor.resolveWith((states) => greenColor),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  ),
  dialogBackgroundColor: backgroundColor,
  timePickerTheme: TimePickerThemeData(
    backgroundColor: backgroundColor,
    dialHandColor: greenColor,
    dialBackgroundColor: backgroundColor,
    dayPeriodColor: greenColor,
    dayPeriodTextColor: greenColor,
    hourMinuteColor: greenColor,
    hourMinuteTextColor: greenColor,
    dayPeriodBorderSide: BorderSide(
      color: greenColor,
    ),
    hourMinuteTextStyle: TextStyle(
      color: greenColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  dataTableTheme: DataTableThemeData(
    dataTextStyle: TextStyle(
      color: greenColor,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    headingRowColor: MaterialStateColor.resolveWith((states) => backgroundColor),
    headingTextStyle: TextStyle(
      color: greenColor,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  ),
  fontFamily: GoogleFonts.poppins().fontFamily,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: backgroundColor,
    selectedItemColor: greenColor,
    unselectedItemColor: grayColor,
  ),
  indicatorColor: greenColor,
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: greenColor,
  ),

);

// ThemeData darkTheme = ThemeData(
//   visualDensity: VisualDensity.adaptivePlatformDensity,
//   scaffoldBackgroundColor: backgroundColor,
//   brightness: Brightness.dark,
//   appBarTheme: AppBarTheme(
//     color: backgroundColor,
//     elevation: 0,
//     iconTheme: IconThemeData(color: Colors.white),
//     titleTextStyle: TextStyle(
//       color: Colors.white,
//       fontSize: 20,
//       fontWeight: FontWeight.bold,
//     ),
//   ),
//   dropdownMenuTheme: DropdownMenuThemeData(
//     inputDecorationTheme: InputDecorationTheme(
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10),
//         borderSide: BorderSide(
//           color: Colors.grey,
//         ),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10),
//         borderSide: BorderSide(
//           color: Colors.grey,
//         ),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10),
//         borderSide: BorderSide(
//           color: Colors.grey,
//         ),
//       ),
//     ),
//     menuStyle:MenuStyle(
//       backgroundColor: MaterialStateColor.resolveWith((states) => backgroundColor),
//
//     ),
//
//   ),
//   textTheme:  TextTheme(
//     bodyLarge: TextStyle(
//       fontSize: 16,
//       fontWeight: FontWeight.bold,
//       color: greenColor,
//     ),
//     bodyMedium: TextStyle(
//       fontSize: 16,
//       fontWeight: FontWeight.bold,
//       color: grayColor,
//     ),
//   ),
//   elevatedButtonTheme: ElevatedButtonThemeData(
//     style: ButtonStyle(
//       padding: MaterialStateProperty.all<EdgeInsets>(
//         EdgeInsets.symmetric(
//           horizontal: 50,
//           vertical: 10,
//         ),
//       ),
//       backgroundColor: MaterialStateColor.resolveWith((states) => greenColor),
//       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//         RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//       ),
//     ),
//   ),
// );
//
