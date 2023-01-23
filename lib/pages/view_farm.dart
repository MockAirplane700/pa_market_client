import 'package:flutter/material.dart';
import 'package:pa_market_client/constants/functions.dart';
import 'package:pa_market_client/constants/variables.dart';
import 'package:pa_market_client/objects/farm.dart';
import 'package:pa_market_client/widgets/custom_search_delegate.dart';

class ViewFarm extends StatefulWidget {
  final Farm farm;
  const ViewFarm({Key? key, required this.farm}) : super(key: key);

  @override
  State<ViewFarm> createState() => _ViewFarmState();
}

class _ViewFarmState extends State<ViewFarm> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Farms', style: TextStyle(color: textColor),),
        backgroundColor: appBarBackgroundColor,
        iconTheme: const IconThemeData(color: iconThemeDataColor),
        actions: [
          IconButton(onPressed: (){
            showSearch(context: context, delegate: MySearchDelegate());
          }, icon: const Icon(Icons.search))
        ],
      ),
      backgroundColor: applicationBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image of the farm
          Image.network(widget.farm.image),
          // Name + owner
          Padding(
            padding: EdgeInsets.all(height/80),
            child: Row(children: [
              Text(widget.farm.name, style: const TextStyle(color: textColor),),
              Text('Owned by, ${widget.farm.name}', style: const TextStyle(color: textColor),),
            ],),
          ),
          // address + city + produce
          Padding(
            padding:  EdgeInsets.all(height/80),
            child: Row(
              children: [
                Expanded(flex: 2,child: Text(widget.farm.address, style: const TextStyle(color: textColor),),),
                Expanded(flex:1, child:  Text('[ ${widget.farm.produce} ]', style: const TextStyle(color: textColor),),)
              ],
            ),
          ),
          // description
          Card(
            shadowColor: shadowColor,
            color: cardBackgroundColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(height/80)),
            child: Padding(padding: EdgeInsets.all(height/50), child:  Text(widget.farm.description, style: const TextStyle(color: textColor),),),
          ),
          // reach out to them, email, call
          Card(
            child: Column(
              children: [
                const Text('Reach out to us!', style:  TextStyle(color: textColor),),
                Row(
                  children: [
                    Expanded(
                      child: IconButton(onPressed: (){
                        launchWebSiteUrl('tel:${widget.farm.phone}');
                      }, icon: const Icon(Icons.phone)),
                    ),
                    Expanded(child: IconButton(onPressed: (){
                      launchEmailIntent(supportEmail, 'PA MARKET APP: CUSTOMER REACHING OUT');
                    }, icon: const Icon(Icons.email)))

                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
