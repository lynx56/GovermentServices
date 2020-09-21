//
//  HotWaterShutoffHotWaterShutoffInteractorOutput.swift
//  GovermentServices
//
//  Created by Holyberry on 20/09/2020.
//  Copyright © 2020 Gulnaz Almukhametova. All rights reserved.
//

import Foundation

protocol HotWaterShutoffInteractorOutput: class {
    
    func didRecieveSchedule(schedule: Schedule)
    
    func didRecieveCachedSchedule(schedule: Schedule, error: Error, lastUpdate: Date)
    
    func didRecievedError(error: DataProviderError)
    
}
