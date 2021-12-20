import 'dart:convert';

import '../model/cast_model.dart';
import '../model/credit_model.dart';
import '../model/detail_tv_model.dart';
import '../model/discover_model.dart';
import '../model/movies_model.dart';
import '../model/person_model.dart';
import '../model/photo_image_model.dart';
import '../model/review_model.dart';
import '../model/search_model.dart';
import '../model/trailer_model.dart';
import '../model/trending_model.dart';
import '../utils/rest_client.dart';

abstract class MoviesDBService {
  Future<List<TrendingModel>> getTrendingData();
  Future<List<DiscoverModel>> getDiscoverData();
  Future<List<Movie>> getCommingsoonData();
  Future<List<PersonModel>> getPersonData();
  Future<PersonModel> getPersonIdData(int id);
  Future<List<PersonImage>> getPhotoImagePerson(int id);
  Future<List<CreditModel>> getCreditData(int id);
  Future<DetailTvModel> getDetailMovieData(int id);
  Future<DetailTvModel> getDetailTvData(int id);
  Future<List<CastModel>> getCastData(int id);
  Future<List<CastModel>> getCastTvData(int id);
  Future<List<ReviewModel>> getDataReview(int id);
  Future<List<TrailerModel>> getDataTrailerMovie(int id);
  Future<List<TrailerModel>> getDataTrailerTV(int id);
  Future<List<ReviewModel>> getDataTVReview(int id);
  Future<List<SearchModel>> getDataSearchMulti(int page, String query);
  Future<List<Movie>> getMoviesData(String? section, int? page);
}

class ApiServices extends MoviesDBService {
  @override
  Future<List<TrendingModel>> getTrendingData() async {
    final bodyTrendingData =
        await HttpClientServices.httpClient().getData('/3/trending/tv/day');
    final getTrendingData = json.decode(bodyTrendingData);
    final List responseList =
        Map<String, dynamic>.from(getTrendingData)['results'];
    return responseList
        .map<TrendingModel>((json) => TrendingModel.fromJson(json))
        .toList();
  }

  @override
  Future<List<DiscoverModel>> getDiscoverData() async {
    final bodyDiscoverData =
        await HttpClientServices.httpClient().getData('3/discover/tv');
    final getDiscoverdata = json.decode(bodyDiscoverData);
    final List responseList =
        Map<String, dynamic>.from(getDiscoverdata)['results'];
    return responseList
        .map<DiscoverModel>((json) => DiscoverModel.fromJson(json))
        .toList();
  }

  @override
  Future<List<Movie>> getCommingsoonData() async {
    final bodyCommingsoonData =
        await HttpClientServices.httpClient().getData('3/movie/upcoming');
    final getCommingsoonData = json.decode(bodyCommingsoonData);
    final List responseList =
        Map<String, dynamic>.from(getCommingsoonData)['results'];
    return responseList.map<Movie>((json) => Movie.fromJson(json)).toList();
  }

  @override
  Future<List<Movie>> getMoviesData(String? section, int? page) async {
    final bodyMoviesData = await HttpClientServices.httpClient()
        .getData('/3/movie/$section', params: {'page': page.toString()});
    final getMoviesData = json.decode(bodyMoviesData);
    final List responseList =
        Map<String, dynamic>.from(getMoviesData)['results'];
    return responseList.map<Movie>((json) => Movie.fromJson(json)).toList();
  }

  @override
  Future<List<PersonModel>> getPersonData() async {
    final bodyPersonData =
        await HttpClientServices.httpClient().getData('/3/person/popular');
    final getPersonData = json.decode(bodyPersonData);
    final List responseList =
        Map<String, dynamic>.from(getPersonData)['results'];
    return responseList
        .map<PersonModel>((json) => PersonModel.fromJson(json))
        .toList();
  }

  @override
  Future<PersonModel> getPersonIdData(int id) async {
    final bodyPersonIdData =
        await HttpClientServices.httpClient().getData('/3/person/$id');
    final getPersonIdData = json.decode(bodyPersonIdData);
    final persondetail = PersonModel.fromJson(getPersonIdData)
      ..personImage = await getPhotoImagePerson(id)
      ..creditCart = await getCreditData(id);
    return persondetail;
  }

  @override
  Future<List<PersonImage>> getPhotoImagePerson(int id) async {
    final bodyPhotoImagePerson =
        await HttpClientServices.httpClient().getData('/3/person/$id/images');
    final getPhotoImagePerson = json.decode(bodyPhotoImagePerson);
    final List itemPhotoData =
        Map<String, dynamic>.from(getPhotoImagePerson)['profiles'];
    return itemPhotoData
        .map<PersonImage>((json) => PersonImage.fromJson(json))
        .toList();
  }

  @override
  Future<List<CreditModel>> getCreditData(int id) async {
    final bodyCredit = await HttpClientServices.httpClient()
        .getData('/3/person/$id/movie_credits');
    final getCreditData = json.decode(bodyCredit);
    final List creditdata = Map<String, dynamic>.from(getCreditData)['cast'];
    return creditdata
        .map<CreditModel>((json) => CreditModel.fromJson(json))
        .toList();
  }

  @override
  Future<DetailTvModel> getDetailMovieData(int id) async {
    final bodyDetailMovieData =
        await HttpClientServices.httpClient().getData('3/movie/$id');
    final getDetailMovieData = json.decode(bodyDetailMovieData);
    final detailMovieData = DetailTvModel.fromJson(getDetailMovieData)
      ..castmodel = await getCastData(id)
      ..reviewmodel = await getDataReview(id)
      ..trailerModel = await getDataTrailerMovie(id);
    return detailMovieData;
  }

  @override
  Future<DetailTvModel> getDetailTvData(int id) async {
    final bodyDetailTvData =
        await HttpClientServices.httpClient().getData('3/tv/$id');
    final getDetailTvData = json.decode(bodyDetailTvData);
    final detailTVData = DetailTvModel.fromJson(getDetailTvData)
      ..castmodel = await getCastTvData(id)
      ..reviewmodel = await getDataTVReview(id)
      ..trailerModel = await getDataTrailerTV(id);
    return detailTVData;
  }

  @override
  Future<List<CastModel>> getCastData(int id) async {
    final bodyCastData =
        await HttpClientServices.httpClient().getData('3/movie/$id/credits');
    final getCastData = json.decode(bodyCastData);
    final List castData = Map<String, dynamic>.from(getCastData)['cast'];
    return castData.map<CastModel>((json) => CastModel.fromJson(json)).toList();
  }

  @override
  Future<List<CastModel>> getCastTvData(int id) async {
    final bodyCastData =
        await HttpClientServices.httpClient().getData('3/tv/$id/credits');
    final getCastData = json.decode(bodyCastData);
    final List castData = Map<String, dynamic>.from(getCastData)['cast'];
    return castData.map<CastModel>((json) => CastModel.fromJson(json)).toList();
  }

  @override
  Future<List<ReviewModel>> getDataReview(int id) async {
    final bodyDataReview =
        await HttpClientServices.httpClient().getData('/3/movie/$id/reviews');
    final getDataReview = json.decode(bodyDataReview);
    final List reviewData = Map<String, dynamic>.from(getDataReview)['results'];
    return reviewData
        .map<ReviewModel>((json) => ReviewModel.fromJson(json))
        .toList();
  }

  @override
  Future<List<ReviewModel>> getDataTVReview(int id) async {
    final bodyDataTVReview =
        await HttpClientServices.httpClient().getData('/3/tv/$id/reviews');
    final getDataTVReview = json.decode(bodyDataTVReview);
    final List reviewTVData =
        Map<String, dynamic>.from(getDataTVReview)['results'];
    return reviewTVData
        .map<ReviewModel>((json) => ReviewModel.fromJson(json))
        .toList();
  }

  @override
  Future<List<TrailerModel>> getDataTrailerMovie(int id) async {
    final bodyDataTrailerMovie =
        await HttpClientServices.httpClient().getData('/3/movie/$id/videos');
    final getDataTrailerMovie = json.decode(bodyDataTrailerMovie);
    final List dataTrailerMovie =
        Map<String, dynamic>.from(getDataTrailerMovie)['results'];
    return dataTrailerMovie
        .map<TrailerModel>((json) => TrailerModel.fromJson(json))
        .toList();
  }

  @override
  Future<List<TrailerModel>> getDataTrailerTV(int id) async {
    final bodyDataTrailerTV =
        await HttpClientServices.httpClient().getData('/3/tv/$id/videos');
    final getDataTrailerTV = json.decode(bodyDataTrailerTV);
    final List dataTrailerTV =
        Map<String, dynamic>.from(getDataTrailerTV)['results'];
    return dataTrailerTV
        .map<TrailerModel>((json) => TrailerModel.fromJson(json))
        .toList();
  }

  @override
  Future<List<SearchModel>> getDataSearchMulti(int page, String query) async {
    final bodyDataSearchMulti = await HttpClientServices.httpClient().getData(
        '/3/search/multi/',
        params: {'query': query, 'page': page.toString()});
    final getDataSearchMulti = json.decode(bodyDataSearchMulti);
    final List dataSearch =
        Map<String, dynamic>.from(getDataSearchMulti)['results'];
    // debugPrint(bodyDataSearchMulti);
    return dataSearch
        .map<SearchModel>((json) => SearchModel.fromJson(json))
        .toList();
  }
}
