//
//  CivilService.swift
//  GovermentServices
//
//  Created by Holyberry on 20.09.2020.
//  Copyright © 2020 gulnaz. All rights reserved.
//

import Moya

enum CivilService {
    case hotWaterShutoffSchedulle
}

extension CivilService: TargetType {
    
    var baseURL: URL { return Bundle.main.host }
    
    var path: String {
        switch self {
        case .hotWaterShutoffSchedulle:
            return "/UniversalMobileService/classifiers/downloadClassifiers"
        }
    }
    
    var method: Method {
        .get
    }
    
    var task: Task {
        switch self {
        case .hotWaterShutoffSchedulle:
            return .requestParameters(parameters: ["classifiersId": 4], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}



extension CivilService {
    
    var sampleData: Data {
        switch self {
        case .hotWaterShutoffSchedulle:
            return """
            {
              "status": "result",
              "responseData": {
                "classifiers": [
                  {
                    "classifierId": 4,
                    "classifierName": "График остановок ТЭЦ ТГК-1 2016г",
                    "file": "WyB7CiAgICAi0J3QsNGB0LXQu9C10L3QvdGL0Lkg0L/Rg9C90LrRgiI6ICLQodCw0L3QutGCLdCf0LXRgtC10YDQsdGD0YDQsyIsCiAgICAi0JDQtNGA0LXRgSDQttC40LvQvtCz0L4g0LfQtNCw0L3QuNGPIjogItCS0LXRgtC10YDQsNC90L7QsiIsCiAgICAi4oSWINC00L7QvNCwIjogIjQ3IiwKICAgICLQutC+0YDQv9GD0YEiOiAiIiwKICAgICLQu9C40YLQtdGAIjogIiIsCiAgICAi0J/QtdGA0LjQvtC0INC+0YLQutC70Y7Rh9C10L3QuNGPINCT0JLQoSI6ICIyMi4wNi4yMDIwLTA1LjA3LjIwMjAiCiAgfQpd",
                    "version": "26"
                  }
                ]
              },
              "expectedResponseDate": "12.08.2020"
            }
            """.utf8Encoded
                
        }
    }
}
