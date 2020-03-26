import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

// List of fiat currencies
const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

// List of cryptos
const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

// API Key
String apiKey = DotEnv().env['APIKEY'];

// URL for API request
String coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate/';

// CoinData Class
class CoinData {
  // Promise of CoinData
  Future getCoinData(crypto, fiat) async {
    var url = '$coinAPIURL$crypto/$fiat?apikey=$apiKey';
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      var currentPrice = decodedData['rate'];
      return currentPrice;
      // If CoinData cannot be retrieved, return status code
    } else {
      print(response.statusCode);
    }
  }
}
