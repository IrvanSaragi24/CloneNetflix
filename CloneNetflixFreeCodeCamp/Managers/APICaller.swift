//
//  File.swift
//  CloneNetflixFreeCodeCamp
//
//  Created by Irvan P. Saragi on 02/12/23.
//

import Foundation


struct Constans {
    static let API_KEY = "697d439ac993538da4e3e60b54e762cd"
    static let baseURL = "https://api.themoviedb.org"
    static let YoutubeAPI_KEY = "AIzaSyDqX8axTGeNpXRiISTGL7Tya7fjKJDYi4g"
    static let YoutubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}

enum APIError : Error{
    case failedtoGetData
}

enum method: String{
    case GET = "GET"
    case PUT = "PUT"
    case POST = "POST"
    case UPDATE = "UPDATE"
    case PATCH = "PATCH"
}

class APICaller{
    static let shared = APICaller()
    
    
    func getTrandingMovies(completion : @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constans.baseURL)/3/trending/movie/day?api_key=\(Constans.API_KEY)" ) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = method.GET.rawValue
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch{
                completion(.failure(APIError.failedtoGetData))
            }
        }
        task.resume()
    }
    
    
    func getTrandingTvs(completion : @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constans.baseURL)/3/trending/tv/day?api_key=\(Constans.API_KEY)" ) else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch{
                completion(.failure(APIError.failedtoGetData))
            }
        }
        task.resume()
    }
    
    func getUpComingMovies(completion : @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constans.baseURL)/3/movie/upcoming?api_key=\(Constans.API_KEY)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch{
                completion(.failure(APIError.failedtoGetData))            }
        }
        task.resume()
    }
    
    func getPopular(completion : @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constans.baseURL)/3/movie/popular?api_key=\(Constans.API_KEY)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch{
                completion(.failure(APIError.failedtoGetData))
            }
        }
        task.resume()
    }
    
    func getTopRated(completion : @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constans.baseURL)/3/movie/top_rated?api_key=\(Constans.API_KEY)&language=en-US&page=1") else {return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch{
                completion(.failure(APIError.failedtoGetData))
            }
        }
        task.resume()
    }
    func getDiscoverMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constans.baseURL)/3/discover/movie?api_key=\(Constans.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
                
            } catch {
                completion(.failure(APIError.failedtoGetData))
            }
            
        }
        task.resume()
    }
    
    func search (with query : String ,completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constans.baseURL)/3/search/movie?api_key=\(Constans.API_KEY)&query=\(query)") else {
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
                
            } catch {
                completion(.failure(APIError.failedtoGetData))
            }
            
        }
        task.resume()
    }
    
    
    func getMovie(with query: String, completion: @escaping (Result<VideoElement, Error>) -> Void){
            guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
            guard let url = URL(string: "\(Constans.YoutubeBaseURL)q=\(query)&key=\(Constans.YoutubeAPI_KEY)") else {return}
        
        
            let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                
                do {
                    let results = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                    completion(.success(results.items[0]))
                } catch {
                    completion(.failure(error))
                    print(error)
                }

            }
            task.resume()
        }
    
}
