import 'package:farmer/import.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: const Padding(
        padding: EdgeInsets.all(10),
        child: Column(children: [
          Text("CSIR-National Botanical Research Institute"),
          SizedBox(height: 50),
          Text(
            "Helpline no",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text("0522-2297802; Fax: 0522-2205839"),
          Text(
            "Email",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text("director@nbri.res.in"),
          Text(
            "Website",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text("https://www.nbri.res.in"),
          SizedBox(height: 50),
          Text(
            "Address",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text("CSIR-National Botanical Research Institute,"),
          Text("PO Box No. 436, Rana Pratap Marg,"),
          Text("Lucknow Uttar Pradesh, India 226001"),
        ]),
      ),
    );
  }
}
