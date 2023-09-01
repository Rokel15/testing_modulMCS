import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'CatetanMhsController.dart';
import 'CatetanMhsModel.dart';

class AddDataPage extends StatefulWidget {
  const AddDataPage({Key? key}) : super(key: key);

  @override
  State<AddDataPage> createState() => _AddDataPageState();
}

class _AddDataPageState extends State<AddDataPage> {
  final CatetanMhsController catetanMhsController = Get.put(CatetanMhsController());

  String pilihTanggal = 'Select Date';

  Future selectDate(BuildContext context) async{
    final DateTime? setDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime(2100),
    );
    if(setDate != null && setDate != DateTime.now()){
      setState(() {
        this.pilihTanggal = DateFormat.yMd().format(setDate).toString();
      });
    }
  }

  int pilihWarna = 1;

  TextEditingController tugas1 = TextEditingController();
  TextEditingController tugas2 = TextEditingController();
  TextEditingController tugas3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                border: Border.all(color: Colors.white),
                boxShadow: [
                  BoxShadow(
                      color: Colors.white,
                      offset: Offset(0.0, 0.1),
                      blurRadius: 10.0
                  )
                ],
                color: Color(0xff2E3840),
              ),
              child: Padding(
                padding: const EdgeInsets.all(13),
                child: Text('Add your note', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))),
            ),

            //pilih tanggal
            Container(
              padding: EdgeInsets.only(top: 40, left: 10, right: 10, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('$pilihTanggal', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                  GestureDetector(
                    child: Icon(Icons.edit_calendar),
                    onTap: (){
                      selectDate(context);
                    },
                  )
                ],
              ),
            ),

            //pilih warna
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  // padding: EdgeInsets.only(top: 30, bottom: 0),
                  child: Wrap(
                    children: List<Widget>.generate(
                        4, (index) {
                          return GestureDetector(
                            child: Container(
                              margin: EdgeInsets.only(left: 13, right: 8),
                              height: MediaQuery.of(context).size.width / 13,
                              width: MediaQuery.of(context).size.width / 13,
                              decoration: BoxDecoration(
                                borderRadius : BorderRadius.circular(15),
                                color:
                                index==0? Color(0xff4C4C6D) :
                                index==1? Color(0xff6F61C0) :
                                index==2? Colors.blue[900] :
                                Colors.pink[500]
                              ),
                              child:
                              pilihWarna==index?
                              Icon(Icons.done_all) : Container(),
                            ),
                            onTap: (){
                              setState(() {
                                pilihWarna = index;
                              });
                            },
                          );
                    }),
                  ),
                ),
              ],
            ),

            //isi tugas 1
            Container(
              padding: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tugas 1', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  TextFormField(
                    controller: tugas1,
                    maxLines: 5,
                    textAlign: TextAlign.justify,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.purpleAccent)
                      )
                    ),
                  )
                ],
              ),
            ),

            //isi tugas 2
            Container(
              padding: EdgeInsets.only(top: 40, left: 10, right: 10, bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tugas 2', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  TextFormField(
                    controller: tugas2,
                    maxLines: 5,
                    textAlign: TextAlign.justify,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.purpleAccent)
                        )
                    ),
                  )
                ],
              ),
            ),

            //isi tugas 3
            Container(
              padding: EdgeInsets.only(top: 40, left: 10, right: 10, bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tugas 3', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  TextFormField(
                    controller: tugas3,
                    maxLines: 5,
                    textAlign: TextAlign.justify,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.purpleAccent)
                        )
                    ),
                  )
                ],
              ),
            ),

            //save button
            Container(
              padding: EdgeInsets.only(bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      icon: Icon(Icons.save_outlined),
                      onPressed: (){
                        add_to_catetanMhs();
                        Get.back();
                      }
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  add_to_catetanMhs() async{
    await catetanMhsController.addCatetanMhs(
      catetanMhsModel: CatetanMhsModel(
          tanggal: pilihTanggal,
          warna: pilihWarna,
          tugas1: tugas1.text,
          tugas2: tugas2.text,
          tugas3: tugas3.text,
      ),
    );
    catetanMhsController.getCatetanMhsData();
  }

}