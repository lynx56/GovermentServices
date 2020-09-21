//
//  HotWaterShutoffHotWaterShutoffViewOutput.swift
//  GovermentServices
//
//  Created by Holyberry on 20/09/2020.
//  Copyright © 2020 Gulnaz Almukhametova. All rights reserved.
//

protocol HotWaterShutoffViewOutput {
    
    func viewIsReady()
    
    func getViewModels() -> [AddressModel]
    
    func startRefreshing()
    
    func didSearch(_ searchText: String)
    
    func didCancelSearch()
    
    func didTapRetry()
}
