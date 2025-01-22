// match_utils.dart
import 'dart:async';

import 'package:intl/intl.dart';


String formatTime(DateTime time) {
  if (time.isAfter(DateTime.now().add(Duration(days: 1))) &&
      time.isBefore(DateTime.now().add(Duration(days: 2)))) {
    return 'Tomorrow ${DateFormat('h:mm a').format(time)}';
  }
  if (time.isAfter(DateTime.now().add(Duration(days: 1)))) {
    return DateFormat('MMM dd, h:mm a').format(time);
  }
  return DateFormat('h:mm a').format(time);
}


DateTime parseMatchDateTime(String matchDate, String matchTime) {
  // Example matchDate: '13/12/2025'
  // Example matchTime: '18:07:55.372566'

  try {
    // Split the matchDate to extract the day, month, and year
    List<String> dateParts = matchDate.split('/');
    String day = dateParts[0];
    String month = dateParts[1];
    String year = dateParts[2];

    // Format the date into ISO format (yyyy-MM-dd)
    String formattedDate = '$year-$month-$day';

    // Combine the formatted date with matchTime to form a complete datetime string
    // Ensure that matchTime has the proper format 'HH:mm:ss' if necessary
    if (matchTime.length > 8) {
      matchTime = matchTime.substring(0, 8);  // Trim milliseconds
    }

    String combinedDateTimeString = '$formattedDate $matchTime';

    // Parse the combined string into DateTime
    DateTime combinedMatchTime = DateTime.parse(combinedDateTimeString);
    return combinedMatchTime;
  } catch (e) {
    // Handle any errors that occur while parsing
    print("Error parsing match date and time: $e");
    return DateTime.now();  // Return current time if parsing fails
  }
}

String getTimeLeft(DateTime matchDateTime) {
  final DateTime now = DateTime.now();
  final Duration difference = matchDateTime.difference(now);

  if (difference.isNegative) return "Match has passed"; // If the target date is in the past

  int days = difference.inDays;
  int hours = difference.inHours % 24;
  int minutes = difference.inMinutes % 60;
  int seconds = difference.inSeconds % 60;

  // Format the output
  if (days > 1) {
    return '$days Days, ${hours}h ${minutes}m';
  } else if (days == 1) {
    return '1 Day, ${hours}h ${minutes}m';
  } else if (hours > 0) {
    return '${hours}h ${minutes}m ${seconds}s';
  } else if (minutes > 0) {
    return '${minutes}m ${seconds}s';
  } else {
    return '${seconds}s';
  }
}


Timer createTimer(Function callback) {
  return Timer.periodic(Duration(seconds: 1), (Timer timer) {
    callback();
  });
}

String formatAmount(int amount) {
  // Create a NumberFormat object for international formatting
  final numberFormat = NumberFormat('#,##0', 'en_US'); // 'en_US' for the US locale, which formats with commas

  if (amount >= 10000000) {
    double crore = amount / 10000000;
    return '₹ ${numberFormat.format(crore)} ${crore == 1 ? "Crore" : "Crores"}';
  } else if (amount >= 100000) {
    double lakh = amount / 100000;
    return '₹ ${numberFormat.format(lakh)} ${lakh == 1 ? "Lakh" : "Lakhs"}';
  } else if (amount >= 1000) {
    double thousand = amount / 1000;
    return '₹ ${numberFormat.format(thousand)} ${thousand == 1 ? "Thousand" : "Thousands"}';
  } else {
    return '₹ ${numberFormat.format(amount)}';
  }
}
String formatCash(num amount) {
  // Create a NumberFormat object for international formatting
  final numberFormat = NumberFormat('#,##0', 'en_US'); // This will format with commas
  return '₹ ${numberFormat.format(amount)}';
}

String formatDate(String dateStr) {
  final DateFormat inputFormat = DateFormat('dd/MM/yyyy');
  final DateFormat outputFormat = DateFormat('dd MMM, yyyy');
  DateTime date = inputFormat.parse(dateStr);
  return outputFormat.format(date);
}

String formatMatchTimeAndDate(DateTime matchTime, String matchDate) {
  String formattedTime = DateFormat('hh:mm a').format(matchTime);

  // If the date exists, format it
  String formattedDate = '';
  if (matchDate != '01/01/2022') {
    formattedDate = DateFormat('dd MMM yyyy').format(matchTime);  // Example: 15 Dec 2025
  }

  // Return either both date and time, or just the time
  return formattedDate.isEmpty ? formattedTime : "$formattedTime";
}

// utils.dart

// utils.dart

String getShortTeamName(String teamName) {
  if (teamName == null || teamName.isEmpty) {
    return 'Team';
  }

  List<String> words = teamName.split(' ');

  // Case: Single word team name
  if (words.length == 1) {
    return teamName.substring(0, 3).toUpperCase(); // First three letters
  }

  // Case: Multiple words (get the first letter of each word)
  String shortName = '';
  for (var word in words) {
    shortName += word[0].toUpperCase();  // Take the first letter of each word
  }

  return shortName;
}

// String getMatchTitle(String team1Name, String team2Name) {
//   String getShortTeamName(String teamName) {
//     if (teamName == null || teamName.isEmpty) {
//       return 'Team';
//     }
//
//     List<String> words = teamName.split(' ');
//
//     // Case: Single word team name
//     if (words.length == 1) {
//       return teamName.substring(0, 3).toUpperCase(); // First three letters
//     }
//
//     // Case: Multiple words (get the first letter of each word)
//     String shortName = '';
//     for (var word in words) {
//       shortName += word[0].toUpperCase();  // Take the first letter of each word
//     }
//
//     return shortName;
//   }
//
//   return '${getShortTeamName(team1Name)} vs ${getShortTeamName(team2Name)}';
// }



