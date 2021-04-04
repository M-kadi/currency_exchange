import 'package:flutter/material.dart';
import 'CurrencyExchange.dart';
import 'MyHomePage.dart';

// For json
import 'dart:convert';

import 'dart:io';

// For http
import 'package:http/http.dart' as http;


void main() async {
  await setup();

  runApp(MyApp(currencyExchange: currencyExchange));
}

Future<CurrencyExchange> currencyExchange;
Future<void> setup() async {

  // Check if internet is Connected
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connected');
    }
  } on SocketException catch (_) {
    print('not connected');
    return;
  }


  final response = await http.get('https://api.ratesapi.io/api/latest');

  if (response.statusCode == 200) {
    currencyExchange = getCurrencyExchange(response.body);
  } else {
    throw Exception('Unable to fetch products from the REST API');
  }
}

Future<CurrencyExchange> getCurrencyExchange(String responseBody) async {
  return new CurrencyExchange.fromJson(json.decode(responseBody));
}


class MyApp extends StatelessWidget {
  final Future<CurrencyExchange> currencyExchange;

  MyApp({this.currencyExchange});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Currency Exchange', currencyExchange: currencyExchange),
    );
  }
}

