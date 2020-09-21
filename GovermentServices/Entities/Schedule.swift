//
//  Schedule.swift
//  GovermentServices
//
//  Created by Holyberry on 21.09.2020.
//  Copyright © 2020 gulnaz. All rights reserved.
//

import Foundation

typealias Schedule = [ScheduleItem]

struct ScheduleItem: Decodable {
    let city: String
    let address: String
    let house: String
    let corpus: String
    let liter: String
    let date: DatePeriod

    enum CodingKeys: String, CodingKey {
        case city = "Населенный пункт"
        case address = "Адрес жилого здания"
        case house = "№ дома"
        case corpus = "корпус"
        case liter = "литер"
        case date = "Период отключения ГВС"
    }
}
