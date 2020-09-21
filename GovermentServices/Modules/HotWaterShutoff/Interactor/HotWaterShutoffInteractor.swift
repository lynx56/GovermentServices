//
//  HotWaterShutoffHotWaterShutoffInteractor.swift
//  GovermentServices
//
//  Created by Holyberry on 20/09/2020.
//  Copyright © 2020 Gulnaz Almukhametova. All rights reserved.
//

class HotWaterShutoffInteractor: HotWaterShutoffInteractorInput {

    unowned var output: HotWaterShutoffInteractorOutput
    
    private var service: DataProviderProrocol
    private var storage: DataStorage
    
    init(service: DataProviderProrocol, storage: DataStorage, output: HotWaterShutoffInteractorOutput) {
        self.service = service
        self.storage = storage
        self.output = output
    }
    
    func loadHotWaterShutoffSchedule() {
        service.hotWaterShutoffSchedule(progressHandler: nil) { result in
            switch result {
            case .failure(let error):
                if let (cachedSchedule, lastUpdateDate) = self.storage.hotWaterShutoffSchedule() {
                    self.output.didRecieveCachedSchedule(schedule: cachedSchedule, error: error, lastUpdate: lastUpdateDate)
                } else {
                    self.output.didRecievedError(error: error)
                }
            case.success(let schedule):
                self.output.didRecieveSchedule(schedule: schedule)
                self.storage.saveHotWaterShutoffSchedule(schedule, completionHandler: nil)
            }
        }
    }
}
