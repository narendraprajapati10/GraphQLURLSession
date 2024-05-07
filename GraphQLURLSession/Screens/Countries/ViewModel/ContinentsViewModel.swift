//
//  ContinentsViewModel.swift
//  GraphQLURLSession
//
//  Created by WhyQ on 03/05/24.
//

import Foundation

final class ContinentsViewModel {
    var continents:[Continents] = []
    var eventHandler: ((_ event: Event) -> Void)? //for data binding
    func fatchProducts() {
        self.eventHandler?(.loading)
        APIManager.shared.fetchProduct(queryString: "{\"query\":\"{continents{name code}}\",\"variables\":{}}") { response in
            DispatchQueue.main.async {
                self.eventHandler?(.stopLoading)
                switch response {
                case .success(let continents):
                    self.continents = continents
                    self.eventHandler?(.dataLoaded)
                case .failure(let error):
                    self.eventHandler?(.error(error))
                    print(error)
                }
            }
        }        
    }
}

extension ContinentsViewModel {
        enum Event {
            case loading
            case stopLoading
            case dataLoaded
            case error(_ error:Error?)
        }
    }
