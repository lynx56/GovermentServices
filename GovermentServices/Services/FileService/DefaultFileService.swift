//
//  DefaultFileService.swift
//  GovermentServices
//
//  Created by Holyberry on 21.09.2020.
//  Copyright © 2020 gulnaz. All rights reserved.
//

import Zip

struct DefaultFileService: FileService {
    private let tmpFileName = "hotWaterShutoffSchedule"
    
    func decodeZippedData<T: Decodable>(data: Data, progressHandler: WorkProgress? = nil, completionHandler: @escaping (Result<T, FileServiceError>) -> Void) {
        let fileManager = FileManager.default
        
        guard let cachePath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { completionHandler(.failure(.cacheFolderNotAvailable)); return }
        
        let fileUrl = cachePath.appendingPathComponent(tmpFileName).appendingPathExtension("zip")
        let decompressedDirectoryUrl = cachePath.appendingPathComponent(tmpFileName)
        
        do {
            try data.write(to: fileUrl)
            
            try Zip.unzipFile(fileUrl, destination: decompressedDirectoryUrl, overwrite: true, password: nil, progress: progressHandler)
             
            guard let fileWithJson = try fileManager.contentsOfDirectory(at: decompressedDirectoryUrl,
                                                                 includingPropertiesForKeys: nil).first else {
                                                                    completionHandler(.failure(.unarchivingFailed)); return }
            
            let data = try Data(contentsOf: fileWithJson, options: .alwaysMapped)
            let decoder = JSONDecoder()
            let result = try decoder.decode(T.self, from: data)
            completionHandler(.success(result))
            
        } catch {
            completionHandler(.failure(.decodingError(error)))
        }
    }
}
