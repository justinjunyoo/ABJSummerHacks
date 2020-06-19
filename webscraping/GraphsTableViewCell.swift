//
//  GraphsTableViewCell.swift
//  webscraping
//
//  Created by Aarish  Brohi on 6/12/20.
//  Copyright © 2020 Aarish Brohi. All rights reserved.
//

import UIKit
import Charts

class GraphsTableViewCell: UITableViewCell, ChartViewDelegate {
    

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var xTitle: UILabel!
    @IBOutlet weak var yTitle: UILabel!
    @IBOutlet weak var barChart: BarChartView!
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func setBarChart(str: [String], values: [Int]) {
       var array: [BarChartDataEntry] = []
        barChart.backgroundColor = UIColor.white

       for i in 0..<values.count  {
          array.append(BarChartDataEntry(x: Double(i), y: Double(values[i])))
       }

        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: str)
        let set = BarChartDataSet(entries: array)
        set.colors = [UIColor.systemRed,UIColor.systemOrange,UIColor.systemYellow, UIColor.orange]
        
        // barCornerRadius = CGFloat(5.0)
        
        let data2 = BarChartData(dataSet: set)
        barChart.xAxis.granularity = 1
        barChart.setVisibleXRangeMaximum(20)

        barChart.moveViewToX(70)

        barChart.xAxis.labelPosition = XAxis.LabelPosition.bottomInside
        barChart.xAxis.avoidFirstLastClippingEnabled = false
        barChart.xAxis.labelFont = UIFont(name: "Verdana", size: 7.5)!
        barChart.rightAxis.enabled = false
        barChart.legend.enabled = false
        barChart.xAxis.drawGridLinesEnabled = false
        barChart.animate(xAxisDuration: 3.0, yAxisDuration: 3.0, easingOption: .easeOutElastic)
  
        
        barChart.data?.setDrawValues(false)
        barChart.pinchZoomEnabled = true
        barChart.scaleYEnabled = true
        barChart.scaleXEnabled = true
        barChart.highlighter = nil
        
        barChart.data = data2
        
    }


}
