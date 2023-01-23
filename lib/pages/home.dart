import 'package:flutter/material.dart';
import 'package:pa_market_client/constants/variables.dart';
import 'package:pa_market_client/logic/farms.dart';
import 'package:pa_market_client/objects/farm.dart';
import 'package:pa_market_client/pages/view_farm.dart';
import 'package:pa_market_client/widgets/custom_search_delegate.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
      body: SingleChildScrollView(
        child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Banner image
            Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              decoration: const BoxDecoration(
                  image: DecorationImage(image: NetworkImage("https://www.rushlimbaugh.com/wp-content/uploads/2018/08/APP-South-African-Farm.jpg"),
                    fit: BoxFit.cover,
                  )
              ),
              child:Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const <Widget>[
                  Text("Listed Farms", style: TextStyle(fontSize: 30, color: Colors.white),)
                ],
              ),
            ),
            // Farms list
            SizedBox(height: height,child: FutureBuilder( future: Farms.getFarms(), builder: (context, snapshot){

              if (snapshot.hasData){
                Set<List<Farm>> snap = snapshot.data;
                List<Farm> farms = snap.first;
                // set the search data
                Farms.setSearchFarms(farms);
                return ListView.builder(
                  physics:const  NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (farms.isEmpty){
                        return const Center(child: Text('There are currently no farms', style: TextStyle(color: textColor),),);
                      }else{
                        return Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(height/80)),
                          elevation: 8,
                          shadowColor: shadowColor,
                          color: cardBackgroundColor,
                          child: ListTile(
                            visualDensity: const VisualDensity(vertical: VisualDensity.maximumDensity),
                            leading: Image.network(farms[index].image),
                            title: Text(farms[index].name, style: const TextStyle(color: textColor),),
                            subtitle: Text(farms[index].produce, style: const TextStyle(color: textColor),),
                            trailing: Text(farms[index].city, style: const TextStyle(color: textColor),),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewFarm(farm: farms[index])));
                            },
                          ),
                        );
                      }
                    },
                  itemCount: farms.length,
                );
              }else{
                return const Center(child: CircularProgressIndicator(),);
              }//end if-else
            }),)

          ],
        ),
      ),
    );
  }
}
