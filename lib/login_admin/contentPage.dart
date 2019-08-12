
import 'package:seemur_v1/components/widgets/leading_page.dart';
import 'package:seemur_v1/screens/admin/show_client.dart';

abstract class Content {
  Future<LeadingPage> lista();
  //Future<ListPersonalClient> personalclient(String id);
  //  Future<MapsPage> mapa();
  Future<ShowClientPage> admin();
}

class ContentPage implements Content {
  Future<LeadingPage> lista() async {
    return LeadingPage();
  }

  //  Future<MapsPage> mapa() async {
  //   return MapsPage();
  // }

  Future<ShowClientPage> admin() async {
    return ShowClientPage();
  }

  // Future<ListPersonalClient> personalclient(String id) async {
  //   print('listados mis recetas $id');
  //   return ListPersonalClient(
  //     id: id,
  //   );
  // }
}