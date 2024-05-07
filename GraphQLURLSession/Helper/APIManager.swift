//
//  APIManager.swift
//  GraphQLURLSession
//
//  Created by WhyQ on 03/05/24.
//

//This API Manager class is using to fatch GraphQL Data  
import UIKit

enum DataError:Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case network(_ error:Error?)
}

typealias handler = (Result<[Continents], DataError>) -> Void
//Singleton Design pattern
final class APIManager {
    static let shared = APIManager()
    private init() {}
    
    func fetchProduct(queryString:String,completion: @escaping handler) {

        guard let url = URL(string: Constant.API.productURL) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        //Here is the main GraphQL Query in PostString Variable
        let postString = queryString
        request.httpBody = postString.data(using: .utf8)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data, error == nil else {
                return
            }
            guard let response = response as? HTTPURLResponse,
                  200 ... 299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            //JSONDecoder() data ko model me decode karta hai
            do {
                let continents = try JSONDecoder().decode(DataModel.self, from: data)
                completion(.success(continents.data.continents))
            }catch {
                completion(.failure(.network(error)))
            }
        }.resume()
    }
}

