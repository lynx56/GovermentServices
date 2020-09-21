//
//  ApiProvider.swift
//  GovermentServices
//
//  Created by Holyberry on 21.09.2020.
//  Copyright © 2020 gulnaz. All rights reserved.
//

import Moya

class ApiProvider: MoyaProvider<CivilService>, DataProviderProrocol {
    private let fileService: FileService
    
    init(fileService: FileService) {
        self.fileService = fileService
    }
    
    func hotWaterShutoffSchedule(progressHandler: WorkProgress?, completionHandler: @escaping (Result<Schedule, DataProviderError>) -> Void) {
        self.request(.hotWaterShutoffSchedulle) { result in
            switch result {
            case .success(let response):
                guard let encodedSchedule = try? response.map(ScheduleResponse.self).responseData.classifiers.first?.file,
                    let data = Data(base64Encoded: encodedSchedule) else {
                        completionHandler(.failure(.dataError))
                        return }
                
                self.fileService.decodeZippedData(data: data, progressHandler: progressHandler) { (result: Result<Schedule, FileServiceError>) -> Void in
                    switch result {
                    case .success(let schedule):
                        completionHandler(.success(schedule))
                    case .failure:
                        completionHandler(.failure(.dataError))
                    }
                }
                
            case .failure:
                completionHandler(.failure(.networkError))
            }
        }
    }
}

fileprivate struct ScheduleResponse: Codable {
    let status: String
    let responseData: ResponseData
    let expectedResponseDate: String
    
    struct ResponseData: Codable {
        let classifiers: [Classifier]
    }
    
    struct Classifier: Codable {
        let classifierId: Int
        let classifierName, file, version: String
    }
}
