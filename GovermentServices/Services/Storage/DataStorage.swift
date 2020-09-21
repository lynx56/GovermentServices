//
//  Storage.swift
//  GovermentServices
//
//  Created by Holyberry on 21.09.2020.
//  Copyright © 2020 gulnaz. All rights reserved.
//

import CoreData

protocol DataStorage {
    func saveHotWaterShutoffSchedule(_ schedule: Schedule, completionHandler: SaveCompletion?)
    func hotWaterShutoffSchedule() -> (Schedule, CachedDate)?
}

enum DataStorageError: Error {
    case savingNotComplete
    case noData
    case other(Error)
}

typealias SaveCompletion = (Result<Bool, DataStorageError>) -> Void
typealias CachedDate = Date
