//
//  DataService.swift
//  GovermentServices
//
//  Created by Holyberry on 21.09.2020.
//  Copyright © 2020 gulnaz. All rights reserved.
//

import Moya

protocol DataProviderProrocol {
    func hotWaterShutoffSchedule(progressHandler: WorkProgress?, completionHandler: @escaping (Result<Schedule, DataProviderError>) -> Void)
}

enum DataProviderError: Error {
    case networkError
    case dataError
}

