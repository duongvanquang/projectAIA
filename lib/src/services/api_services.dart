import 'dart:convert';

import 'package:moviesaia/src/model/detail_tv_model.dart';

import '../constants/api_constants.dart';
import '../model/credit_model.dart';
import '../model/discover_model.dart';
import '../model/movies_model.dart';
import '../model/person_model.dart';
import '../model/photo_image_model.dart';
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
    final bodyDetailTvData = await HttpClient(baseUrl: ApiConstant.baseUrl)
        .getData('3/movie/$id', {'api_key': ApiConstant.apiKey});
    final getDetailTvData = json.decode(bodyDetailTvData);
    final detailTVData = DetailTvModel.fromJson(getDetailTvData);
    return detailTVData;
  }

  Future<DetailTvModel> getDetailTvData(int id) async {
    final bodyDetailTvData = await HttpClient(baseUrl: ApiConstant.baseUrl)
        .getData('3/tv/$id', {'api_key': ApiConstant.apiKey});
    final getDetailTvData = json.decode(bodyDetailTvData);
    final detailTVData = DetailTvModel.fromJson(getDetailTvData);
    return detailTVData;
  }
}
