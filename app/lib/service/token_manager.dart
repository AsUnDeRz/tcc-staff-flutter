class TokenManager {
  bool isTokenExpired(int timeStamp) {
    if (timeStamp == null) {
      return true;
    }
    if (timeStamp == 0) {
      return true;
    }
    int convertTimeStamp = timeStamp * 1000;
    var now = new DateTime.now();
    var tokenExpiredDate = new DateTime.fromMillisecondsSinceEpoch(convertTimeStamp);
    return now.isAfter(tokenExpiredDate);
  }
}
