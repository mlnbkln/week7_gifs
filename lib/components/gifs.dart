import 'package:week7_gifs/helpers/fetch.dart';
import 'package:week7_gifs/helpers/constants.dart';

class GifsFetch {
  Future<dynamic> getGifs(String searchString) async {
    FetchHelper fetchData = FetchHelper(
        "$giphyUrl?api_key=$giphyApiKey&q=$searchString&limit=$numberOfGifs&offset=0&rating=g");

    var decodedData = await fetchData.getData();
    return decodedData;
  }
}