//
//  HotWaterShutoffHotWaterShutoffInitializer.swift
//  GovermentServices
//
//  Created by Holyberry on 20/09/2020.
//  Copyright © 2020 Gulnaz Almukhametova. All rights reserved.
//

import UIKit

class HotWaterShutoffModuleInitializer: NSObject {

    var hotwatershutoffViewController: HotWaterShutoffViewController

    override init() {
        
        hotwatershutoffViewController = HotWaterShutoffViewController()
        
        let configurator = HotWaterShutoffModuleConfigurator()
        
        configurator.configureModuleForViewInput(viewInput: hotwatershutoffViewController)
        
    }
}
