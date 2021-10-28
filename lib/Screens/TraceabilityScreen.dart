// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:rethink/System/Theme.dart';
import 'package:rethink/Services/TraceabilityServices.dart';

class TraceabilityScreen extends StatefulWidget {
  const TraceabilityScreen({ Key? key }) : super(key: key);

  @override
  _TracebilityScreenState createState() => _TracebilityScreenState();
}

class _TracebilityScreenState extends State<TraceabilityScreen> {
  
  @override
  void initState() {
    super.initState();
  }

  IconData statusIcon(int index, String condition) {
    if(condition == 'Factory')
    {
      return Icons.precision_manufacturing_rounded;
    }
    else if(condition == 'Warehouse')
    {
      return Icons.storefront_rounded;
    }
    else if(condition == 'Store')
    {
      return Icons.store;
    }
    else
    {
      return Icons.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: GetTraceabilityInformation().fetchTraceabilityList(),
      builder: (BuildContext context, snapshot) {
        if(!snapshot.hasData)
        {
          return const Center(child: CircularProgressIndicator());
        }
        else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Traceability'),
            ),
            body: ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.only(left: 10),
                  alignment: Alignment.centerLeft,
                  child: const Icon(Icons.arrow_downward_rounded)
                );
              },
              itemCount: traceabilityList.length,
              itemBuilder: (BuildContext ctxt, int index) {
                 return Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Container(
                        margin: const EdgeInsets.only(left: 10, top: 10),
                        alignment: Alignment.bottomLeft,
                        child: Text('24 October 2021',
                        style: MyTheme().itemInfoTitleStyle(),
                        ),
                     ),
                     Container(
                       margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                       decoration: const BoxDecoration(
                         borderRadius: BorderRadius.all(Radius.circular(10)),
                         color: Colors.grey,
                       ),
                       child: Column(
                         children: [
                           Row(
                             children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.all(5),
                                  child: Icon(
                                   statusIcon(index, traceabilityList[index]['LocationName'])
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(5),
                                      child: const Text('Nets Ecohauz Sdn Bhd'),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width / 2,
                                          margin: const EdgeInsets.all(5),
                                          child: Text(traceabilityList[index]['LocationName']),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width / 2 - 74,
                                          alignment: Alignment.centerRight,
                                          margin: const EdgeInsets.all(5),
                                          child: Text(traceabilityList[index]['Status'],
                                          textAlign: TextAlign.right,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                             ],
                           ),
                         ],
                       ),
                     ),
                   ],
                 );
              }
            ),
          );
        }
      }
    );
  }
}