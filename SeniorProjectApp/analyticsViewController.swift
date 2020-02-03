//
//  analyticsViewController.swift
//  SeniorProjectApp
//
//  Created by Gaurav Karkhanis on 2/2/20.
//  Copyright © 2020 Gaurav Karkhanis. All rights reserved.
//

import UIKit

class analyticsViewController: UIViewController {
    
    var ourStoryboard: UIStoryboard?

    override func viewDidLoad() {
        super.viewDidLoad()

        ourStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let updated_dataPoints: [String] = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
        let updated_values: [Double] = [1234, 546, 890, 3453, 1265, 2990, 9092, 980, 432, 3030, 2100, 208]
    
        
    modify_data(dataPoints: updated_dataPoints, values: updated_values)
    }
    
    @IBAction func didTapOnPieChartButton(_ sender: Any) {
        guard let vc = ourStoryboard?.instantiateViewController(withIdentifier: "PieChartViewController") as? PieChartViewController else { return }
           self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didTapOnLineChart(_ sender: Any) {
        guard let vc = ourStoryboard?.instantiateViewController(withIdentifier: "LineChartViewController") as? LineChartViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didTapOnBarChart(_ sender: Any) {
        guard let vc = ourStoryboard?.instantiateViewController(withIdentifier: "BarChartViewController") as? BarChartViewController else { return }
           self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
