import 'package:app/model/concert_entity.dart';
import 'package:app/service/api.dart';
import 'package:flutter/widgets.dart';

class ConcertRepository extends ChangeNotifier {
  ConcertApiProvider apiProvider;
  List<ConcertDataRecord> concertList;

  ConcertRepository();

  ConcertRepository.instance()
      : apiProvider = ConcertApiProvider(),
        concertList = new List() {
    getConcertList();
  }

  Future<ConcertEntity> getConcertList() async {
    concertList = new List();
    try {
      ConcertEntity concertEntity = await apiProvider.getConcertList();
      print("get concert " + concertEntity.toString());
      if (concertEntity.data != null) {
        print(concertEntity);
        concertList = concertEntity.data.record;
        notifyListeners();
        return concertEntity;
      } else {
        notifyListeners();
        return concertEntity;
      }
    } catch (e) {
      notifyListeners();
      return null;
    }
  }
}
