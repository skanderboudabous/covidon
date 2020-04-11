import 'package:url_launcher/url_launcher.dart';

const TITLE = "CoviDon";
const adminEmail = "admin@iit.ens.tn";
const List<String> choices = [
  "Food",
  "Sanitary",
  "Drugs",
  "Cleaning",
  "Other"
];
const covidUrl="https://www.covidvisualizer.com";
void call(String number) async {
  String tel = "tel:";
  if (await canLaunch(tel + number)) await launch(tel + number);
}
//SAMU (secours médicaux) : 190
//Garde nationale : 193
//Police de secours : 197
//Protection civile : 198
//Activité suspecte : 80 101 111