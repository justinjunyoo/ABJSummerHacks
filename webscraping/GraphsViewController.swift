//
//  GraphsViewController.swift
//  webscraping
//
//  Created by Aarish  Brohi on 6/11/20.
//  Copyright © 2020 Aarish Brohi. All rights reserved.
//

import UIKit
import Charts

class GraphsViewController: UIViewController, ChartViewDelegate {
    
//    var vc = DataNumbers(nibName: nil, bundle: nil)
    var data = ViewController(nibName: nil, bundle: nil).data
  
    
    var barChart = BarChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        barChart.delegate = self
        
//        data = vc.allInfo(dataArray: data)
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var str = Array<String>()
        
        
        barChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)
        barChart.center = view.center
        
        var array = [BarChartDataEntry]()
        
        view.addSubview(barChart)
        
        for i in 0...data.count - 3{
            
                array.append(BarChartDataEntry(x: Double(i), y: Double(data[i].cases)))
                str.append(String(data[i].name))
            
     
        }
        
        
        let set = BarChartDataSet(entries: array)
        set.colors = ChartColorTemplates.joyful()
        let data2 = BarChartData(dataSet: set)
        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: str)
        barChart.xAxis.granularity = 1
        barChart.xAxis.yOffset = 1;

        
        barChart.xAxis.labelPosition = XAxis.LabelPosition.bottomInside
        barChart.xAxis.avoidFirstLastClippingEnabled = false

 
        barChart.xAxis.labelFont = UIFont(name: "Verdana", size: 9.0)!
        barChart.rightAxis.enabled = false
        barChart.legend.enabled = false
        barChart.xAxis.drawGridLinesEnabled = false

        barChart.data = data2

    }
    

}
