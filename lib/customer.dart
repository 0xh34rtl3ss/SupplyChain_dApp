import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key});

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  TextEditingController itemId = TextEditingController();
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
    String contractAddress = '0xe288153494D12DE21E92D2AbD145e38dB363cA0f';

    final contract = DeployedContract(ContractAbi.fromJson(abi, "SupplyChain"),
        EthereumAddress.fromHex(contractAddress));
    //print(contract);
    return contract;
  }

  Future<List<dynamic>> query(
      String functionName, List<dynamic> args, Web3Client ethClient) async {
    final contract = await loadContract();
    final ethFunction = contract.function(functionName);
    final result = await ethClient.call(
        contract: contract, function: ethFunction, params: args);
    // final result = await ethClient.sendTransaction(
    //     Credentials,
    //     Transaction.callContract(
    //         contract: contract, function: ethFunction, parameters: args));
    return result;
  }

  Future<String> getParcelDetails(String itemId) async {
    final result = await query('viewParcelinfo', [itemId], ethClient);

    final receipt = await ethClient.getLogs(FilterOptions());
    // final data = event.values;
    data = true;
    myData = result.toString();
    print(result);
    return result.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('View Tracking Details'),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.lightBlue[200],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Enter Item details'),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: customerInputController,
                  decoration: InputDecoration(labelText: 'Tracking ID'),
                ),
              ),
              ElevatedButton(
                  onPressed: (() async {
                    if (customerInputController.text.isNotEmpty) {
                      var data =
                          await getParcelDetails(customerInputController.text);
                      List<String> dataList =
                          data.split(",").map((item) => item.trim()).toList();

                      if (dataList[1].isNotEmpty &&
                          dataList[2].isNotEmpty &&
                          dataList[4].isNotEmpty) {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    leading: new Icon(Icons.wifi_tethering),
                                    title: new Text(
                                        'Tracking ID:  ${dataList[3]}'),
                                  ),
                                  ListTile(
                                    leading: new Icon(Icons.place),
                                    title: new Text(
                                        'Parcel Origin:  ${dataList[4]}'),
                                  ),
                                  ListTile(
                                    leading: new Icon(Icons.home_work),
                                    title: new Text(
                                        'Current Owner:  ${dataList[1]}'),
                                  ),
                                  ListTile(
                                    leading: new Icon(
                                        Icons.keyboard_double_arrow_right),
                                    title:
                                        new Text('Next Owner:  ${dataList[2]}'),
                                  ),
                                ],
                              );
                            });
                      } else {
                        final snackBar = SnackBar(
                          /// need to set following properties for best effect of awesome_snackbar_content
                          elevation: 0,
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          content: AwesomeSnackbarContent(
                            title: 'Oh Snap!',
                            message: 'Tracking ID is not in the records!',

                            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                            contentType: ContentType.failure,
                          ),
                        );

                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(snackBar);
                      }
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
                  child: Text('Submit')),
            ],
          ),
        ));
  }
}
