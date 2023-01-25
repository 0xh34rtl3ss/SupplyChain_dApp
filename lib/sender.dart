//input 2 : item(Text) & receiver destination (text)

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class SenderPage extends StatefulWidget {
  @override
  State<SenderPage> createState() {
    return _SenderPageState();
  }
}

class _SenderPageState extends State<SenderPage> {
  final itemtrackInputController = TextEditingController();
  final destinationInputController = TextEditingController();
  final addrdestinationInputController = TextEditingController();

  late Client httpClient;
  late Web3Client ethClient;

  var time = 0;
  bool data = false;
  late var myData;
  final Credentials = EthPrivateKey.fromHex(
      'd09894577e2cd49b1e2f7b9f8ced4a5ca14d7cd7e91642067f0dd193de3c6fd3');
  final String myAddress = '0x65E09A2C684aCDbbeFB0BD7A972e1BA57580766D';
  //Infura url
  final String blockchainUrl = 'http://127.0.0.1:7545';
  final customerInputController = TextEditingController(); //user

  @override
  void initState() {
    super.initState();
    httpClient = Client();
    ethClient = Web3Client(blockchainUrl, httpClient);
  }

  Future<DeployedContract> loadContract() async {
    String abi = await rootBundle.loadString('../assets/abi.json');
    String contractAddress = '0xb8b29745CFFd1A5db8a637Bb71E203287a9078fa';

    final contract = DeployedContract(ContractAbi.fromJson(abi, "SupplyChain"),
        EthereumAddress.fromHex(contractAddress));
    //print(contract);
    return contract;
  }

  Future<String> query(
      String functionName, List<dynamic> args, Web3Client ethClient) async {
    final contract = await loadContract();
    final ethFunction = contract.function(functionName);

    // final result = await ethClient.call(
    //     contract: contract, function: ethFunction, params: args);
    final result = await ethClient.sendTransaction(
        Credentials,
        Transaction.callContract(
            contract: contract, function: ethFunction, parameters: args));
    return result;
  }

  Future<String> addParcel(String itemId, String location, String addr) async {
    final result = await query('addParcel',
        [itemId, location, EthereumAddress.fromHex(addr)], ethClient);

    final receipt = await ethClient.getLogs(FilterOptions());
    // final data = event.values;
    return result.toString();
    // return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Create and Send Parcel'),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.lightBlue[200],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Enter Item details to Send'),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: itemtrackInputController,
                  decoration: InputDecoration(labelText: 'Item Tracking ID'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: destinationInputController,
                  decoration: InputDecoration(labelText: 'Sender Location'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: addrdestinationInputController,
                  decoration: InputDecoration(labelText: 'Enter destination'),
                ),
              ),
              ElevatedButton(
                  onPressed: (() async {
                    if (itemtrackInputController.text.isNotEmpty &&
                        destinationInputController.text.isNotEmpty &&
                        addrdestinationInputController.text.isNotEmpty) {
                      var data = await addParcel(
                          itemtrackInputController.text,
                          destinationInputController.text,
                          addrdestinationInputController.text);
                      print(data);
                      final snackBar = SnackBar(
                        /// need to set following properties for best effect of awesome_snackbar_content
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: 'Nice!',
                          message: 'Transaction accepted!\nat: ${data}',

                          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                          contentType: ContentType.success,
                        ),
                      );

                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                    } else {
                      final snackBar = SnackBar(
                        /// need to set following properties for best effect of awesome_snackbar_content
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: 'Oh Snap!',
                          message: 'You cannot submit with a blank input!',

                          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                          contentType: ContentType.failure,
                        ),
                      );

                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                    }
                  }),
                  child: Text("Submit"))
            ],
          ),
        ));
  }
}
