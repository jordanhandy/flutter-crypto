// Package for testing device type
import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  // Default selected currency
  String selectedCurrency = 'USD';
  // Declare CoinData() object
  CoinData coinData = CoinData();

  // Dropdown menu for Android
  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getData();
        });
      },
    );
  }

  // Slider picker for iOS
  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Color(0xFF27496d),
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        selectedCurrency = pickerItems[selectedIndex].toString();
      },
      children: pickerItems,
    );
  }

//TODO: Eventually refactor hard-coded aspects
  // Variables to hold values for BTC, ETH, and LTC
  String fiatStringBTC = '?';
  String fiatStringETH = '?';
  String fiatStringLTC = '?';

  // Method to get Coin Data
  void getData() async {
    // Await the finding of Coin data for BTC
    // Await the finding of Coin data for ETH
    // Await the finding of Coin data for LTC
    var decodedDataBTC = await coinData.getCoinData('BTC', selectedCurrency);
    var decodedDataETH = await coinData.getCoinData('ETH', selectedCurrency);
    var decodedDataLTC = await coinData.getCoinData('LTC', selectedCurrency);
    setState(() {
      // Set state to update the text values found
      fiatStringBTC = decodedDataBTC.toStringAsFixed(0);
      fiatStringETH = decodedDataETH.toStringAsFixed(0);
      fiatStringLTC = decodedDataLTC.toStringAsFixed(0);
    });
  }

  @override
  void initState() {
    // Call initial data values at app boot
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF27496d),
        title: Text('Simple Crypto-Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Card(
                  color: Color(0xFF27496d),
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      //Update the Text Widget with the live bitcoin data here.
                      '1 BTC = $fiatStringBTC $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Color(0xFF27496d),
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      //Update the Text Widget with the live bitcoin data here.
                      '1 ETH = $fiatStringETH $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Color(0xFF27496d),
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      //Update the Text Widget with the live bitcoin data here.
                      '1 LTC = $fiatStringLTC $selectedCurrency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Color(0xFF27496d),
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
