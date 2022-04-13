//  SpaceRocketService.swift
//  KonturKadyrovIlya
//
//  Created by Илья Кадыров on 13.04.2022.
//

import Alamofire

class SpaceRocketService {
    
    func getSpaceRockets(completion: @escaping (RequestResult<[SpaceRocketModel]>) -> Void) {
        AF.request(Constants.pathAllSpaceRockets).responseDecodable(of: [SpaceRocketModel].self) {response in
            if let error = response.error {
                print(error)
                completion(RequestResult.error(text: error.errorDescription ?? Constants.defaultTextError))
                return
            }
            do {
                try completion(RequestResult.complete(data: response.result.get()))
            } catch(let error) {
                print(error)
                completion(RequestResult.error(text: "\(error)"))
            }
        }
    }
}

//MARK: - Constants

private extension SpaceRocketService {
    enum Constants {
        static let pathAllSpaceRockets: String = "https://api.spacexdata.com/v4/rockets"
        static let defaultTextError: String = "Что-то пошло не так"
    }
}
