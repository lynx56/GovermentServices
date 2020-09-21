//
//  HotWaterShutoffHotWaterShutoffViewInput.swift
//  GovermentServices
//
//  Created by Holyberry on 20/09/2020.
//  Copyright © 2020 Gulnaz Almukhametova. All rights reserved.
//

protocol HotWaterShutoffViewInput: class {

    func reloadData()
    
    func showError(_ error: String)
    
    func startLoading()
    
    func stopLoading()
}
