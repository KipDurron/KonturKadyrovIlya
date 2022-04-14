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
                completion(RequestResult.error(text: error.errorDescription ?? Constants.defaultTextError))
                return
            }
            do {
                try completion(RequestResult.complete(data: response.result.get()))
            } catch(let error) {
                completion(RequestResult.error(text: "\(error)"))
            }
        }
    }
    
    func getLaunchesRocket(rocketId: String, completion: @escaping (RequestResult<[LaunchModel]>) -> Void) {
        let parameters: [String: Any] = [
            Constants.query: [Constants.rocket: rocketId],
            Constants.options: [Constants.select: [Constants.name, Constants.success, Constants.dateUnix]]
        ]

        AF.request(Constants.pathLaunchesRocket, method: .post, parameters: parameters).responseDecodable(of: ResponseLaunches.self) {response in
            if let error = response.error {
                completion(RequestResult.error(text: error.errorDescription ?? Constants.defaultTextError))
                return
            }
            do {
                try completion(RequestResult.complete(data: response.result.get().launches))
            } catch(let error) {
                completion(RequestResult.error(text: "\(error)"))
            }
        }
    }
}

//MARK: - Constants

private extension SpaceRocketService {
    enum Constants {
        static let pathAllSpaceRockets = "https://api.spacexdata.com/v4/rockets"
        static let pathLaunchesRocket = "https://api.spacexdata.com/v4/launches/query"
        static let defaultTextError = "Что-то пошло не так"
        static let query = "query"
        static let rocket = "rocket"
        static let name = "name"
        static let success = "success"
        static let dateUnix = "date_unix"
        static let options = "options"
        static let select = "select"
    }
}
