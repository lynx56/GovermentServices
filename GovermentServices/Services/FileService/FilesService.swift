//
//  FilesService.swift
//  GovermentServices
//
//  Created by Holyberry on 21.09.2020.
//  Copyright © 2020 gulnaz. All rights reserved.
//

import Foundation
import Zip

typealias WorkProgress = (Double) -> Void

enum FileServiceError: Error {
    case cacheFolderNotAvailable
    case unarchivingFailed
    case decodingError(Error)
}

protocol FileService {
    func decodeZippedData<T: Decodable>(data: Data, progressHandler: WorkProgress?, completionHandler: @escaping (Result<T, FileServiceError>) -> Void)
}
