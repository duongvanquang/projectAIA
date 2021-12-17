import 'dart:convert';

import '../constants/api_constants.dart';
import '../model/cast_model.dart';
import '../model/credit_model.dart';
import '../model/detail_tv_model.dart';
import '../model/discover_model.dart';
import '../model/movies_model.dart';
import '../model/person_model.dart';
import '../model/photo_image_model.dart';
import '../model/review_model.dart';
import '../model/trailer_model.dart';
import '../model/trending_model.dart';
import 'http_client.dart';

class ApiServices {
  Future<List<TrendingModel>> getTrendingData() async {
    final bodyTrendingData = await HttpClient(baseUrl: ApiConstant.baseUrl)
        .getData('/3/trending/tv/day', {'api_key': ApiConstant.apiKey});
    final getTrendingData = json.decode(bodyTrendingData);
    final List responseList =
        Map<String, dynamic>.from(getTrendingData)['results'];
    return responseList
        .map<TrendingModel>((json) => TrendingModel.fromJson(json))
        .toList();
  }

  Future<List<DiscoverModel>> getDiscoverData() async {
    final bodyDiscoverData = await HttpClient(baseUrl: ApiConstant.baseUrl)
        .getData('3/discover/tv', {'api_key': ApiConstant.apiKey});
    final getDiscoverdata = json.decode(bodyDiscoverData);
    final List responseList =
        Map<String, dynamic>.from(getDiscoverdata)['results'];
    return responseList
        .map<DiscoverModel>((json) => DiscoverModel.fromJson(json))
        .toList();
  }

  Future<List<Movie>> getCommingsoonData() async {
    final bodyCommingsoonData = await HttpClient(baseUrl: ApiConstant.baseUrl)
        .getData('3/movie/upcoming', {'api_key': ApiConstant.apiKey});
    final getCommingsoonData = json.decode(bodyCommingsoonData);
    final List responseList =
        Map<String, dynamic>.from(getCommingsoonData)['results'];
    return responseList.map<Movie>((json) => Movie.fromJson(json)).toList();
  }

  Future<List<Movie>> getMoviesData(String? section, int? page) async {
    final bodyMoviesData = await HttpClient(baseUrl: ApiConstant.baseUrl)
        .getData('/3/movie/$section',
            {'api_key': ApiConstant.apiKey, 'page': page.toString()});
    final getMoviesData = json.decode(bodyMoviesData);
    final List responseList =
        Map<String, dynamic>.from(getMoviesData)['results'];
    return responseList.map<Movie>((json) => Movie.fromJson(json)).toList();
  }

  Future<List<PersonModel>> getPersonData() async {
    final bodyPersonData = await HttpClient(baseUrl: ApiConstant.baseUrl)
        .getData('/3/person/popular', {'api_key': ApiConstant.apiKey});
    final getPersonData = json.decode(bodyPersonData);
    final List responseList =
        Map<String, dynamic>.from(getPersonData)['results'];
    return responseList
        .map<PersonModel>((json) => PersonModel.fromJson(json))
        .toList();
  }

  Future<PersonModel> getPersonIdData(int id) async {
    final bodyPersonIdData = await HttpClient(baseUrl: ApiConstant.baseUrl)
        .getData('/3/person/$id', {'api_key': ApiConstant.apiKey});
    final getPersonIdData = json.decode(bodyPersonIdData);
    final persondetail = PersonModel.fromJson(getPersonIdData)
      ..personImage = await getPhotoImagePerson(id)
      ..creditCart = await getCreditData(id);
    return persondetail;
  }

  Future<List<PersonImage>> getPhotoImagePerson(int id) async {
    final bodyPhotoImagePerson = await HttpClient(baseUrl: ApiConstant.baseUrl)
        .getData('/3/person/$id/images', {'api_key': ApiConstant.apiKey});
    final getPhotoImagePerson = json.decode(bodyPhotoImagePerson);
    final List itemPhotoData =
        Map<String, dynamic>.from(getPhotoImagePerson)['profiles'];
    return itemPhotoData
        .map<PersonImage>((json) => PersonImage.fromJson(json))
        .toList();
  }

  Future<List<CreditModel>> getCreditData(int id) async {
    final bodyCredit = await HttpClient(baseUrl: ApiConstant.baseUrl).getData(
        '/3/person/$id/movie_credits', {'api_key': ApiConstant.apiKey});
    final getCreditData = json.decode(bodyCredit);
    final List creditdata = Map<String, dynamic>.from(getCreditData)['cast'];
    return creditdata
        .map<CreditModel>((json) => CreditModel.fromJson(json))
        .toList();
  }

  Future<DetailTvModel> getDetailMovieData(int id) async {
    final bodyDetailMovieData = await HttpClient(baseUrl: ApiConstant.baseUrl)
        .getData('3/movie/$id', {'api_key': ApiConstant.apiKey});
    final getDetailMovieData = json.decode(bodyDetailMovieData);
    final detailMovieData = DetailTvModel.fromJson(getDetailMovieData)
      ..castmodel = await getCastData(id)
      ..reviewmodel = await getDataReview(id)
      ..trailerModel = await getDataTrailerMovie(id);
    return detailMovieData;
  }

  Future<DetailTvModel> getDetailTvData(int id) async {
    final bodyDetailTvData = await HttpClient(baseUrl: ApiConstant.baseUrl)
        .getData('3/tv/$id', {'api_key': ApiConstant.apiKey});
    final getDetailTvData = json.decode(bodyDetailTvData);
    final detailTVData = DetailTvModel.fromJson(getDetailTvData)
      ..castmodel = await getCastTvData(id)
      ..reviewmodel = await getDataTVReview(id)
      ..trailerModel = await getDataTrailerTV(id);
    return detailTVData;
  }

  Future<List<CastModel>> getCastData(int id) async {
    final bodyCastData = await HttpClient(baseUrl: ApiConstant.baseUrl)
        .getData('3/movie/$id/credits', {'api_key': ApiConstant.apiKey});
    final getCastData = json.decode(bodyCastData);
    final List castData = Map<String, dynamic>.from(getCastData)['cast'];
    return castData.map<CastModel>((json) => CastModel.fromJson(json)).toList();
  }

  Future<List<CastModel>> getCastTvData(int id) async {
    final bodyCastData = await HttpClient(baseUrl: ApiConstant.baseUrl)
        .getData('3/tv/$id/credits', {'api_key': ApiConstant.apiKey});
    final getCastData = json.decode(bodyCastData);
    final List castData = Map<String, dynamic>.from(getCastData)['cast'];
    return castData.map<CastModel>((json) => CastModel.fromJson(json)).toList();
  }

  Future<List<ReviewModel>> getDataReview(int id) async {
    final bodyDataReview = await HttpClient(baseUrl: ApiConstant.baseUrl)
        .getData('/3/movie/$id/reviews', {'api_key': ApiConstant.apiKey});
    final getDataReview = json.decode(bodyDataReview);
    final List reviewData = Map<String, dynamic>.from(getDataReview)['results'];
    return reviewData
        .map<ReviewModel>((json) => ReviewModel.fromJson(json))
        .toList();
  }

  Future<List<ReviewModel>> getDataTVReview(int id) async {
    final bodyDataTVReview = await HttpClient(baseUrl: ApiConstant.baseUrl)
        .getData('/3/tv/$id/reviews', {'api_key': ApiConstant.apiKey});
    final getDataTVReview = json.decode(bodyDataTVReview);
    final List reviewTVData =
        Map<String, dynamic>.from(getDataTVReview)['results'];
    return reviewTVData
        .map<ReviewModel>((json) => ReviewModel.fromJson(json))
        .toList();
  }

  Future<List<TrailerModel>> getDataTrailerMovie(int id) async {
    final bodyDataTrailerMovie = await HttpClient(baseUrl: ApiConstant.baseUrl)
        .getData('/3/movie/$id/videos', {'api_key': ApiConstant.apiKey});
    final getDataTrailerMovie = json.decode(bodyDataTrailerMovie);
    final List dataTrailerMovie =
        Map<String, dynamic>.from(getDataTrailerMovie)['results'];
    return dataTrailerMovie
        .map<TrailerModel>((json) => TrailerModel.fromJson(json))
        .toList();
  }

  Future<List<TrailerModel>> getDataTrailerTV(int id) async {
    final bodyDataTrailerTV = await HttpClient(baseUrl: ApiConstant.baseUrl)
        .getData('/3/tv/$id/videos', {'api_key': ApiConstant.apiKey});
    final getDataTrailerTV = json.decode(bodyDataTrailerTV);
    final List dataTrailerTV =
        Map<String, dynamic>.from(getDataTrailerTV)['results'];
    return dataTrailerTV
        .map<TrailerModel>((json) => TrailerModel.fromJson(json))
        .toList();
  }
}
