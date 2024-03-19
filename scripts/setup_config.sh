#!/bin/bash
echo "Setting up config file"
mkdir -p lib/data

# TODO: add other config variables here
echo 'import "package:flutter/foundation.dart";

class Config {
  static String razorpayApiKey = "'$1'";
  static bool isProd = kDebugMode ? false : true;
  static String mixPanelKey = "'$2'";
  static String googleClientID = "'$3'";
}' > lib/data/config.dart
