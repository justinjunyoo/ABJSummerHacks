//
//  CountyAllBarTableViewCell.swift
//  webscraping
//
//  Created by Aarish  Brohi on 7/28/20.
//  Copyright © 2020 Aarish Brohi. All rights reserved.
//

import UIKit
import Charts

class CountyAllBarTableViewCell: UITableViewCell, ChartViewDelegate {

    @IBOutlet weak var barChart: BarChartView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        barChart.delegate = self
           
        let marker = ChartMarker()
        marker.chartView = barChart
        barChart.marker = marker
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setBarChart(values: [Double]) {
        var array: [BarChartDataEntry] = []

        for i in 0..<values.count  {
            array.append(BarChartDataEntry(x: Double(i), y: values[i]))
            
        }
        
        let set = BarChartDataSet(entries: array)
        set.colors = ChartColorTemplates.joyful()
        let data = BarChartData(dataSet: set)
        barChart.data = data
        barChart.leftAxis.spaceBottom = 0.0
        barChart.xAxis.labelPosition = .bottom
        barChart.leftAxis.axisMinimum = 0
        data.setDrawValues(false)
        barChart.data?.setDrawValues(false)
        barChart.pinchZoomEnabled = true
        barChart.scaleYEnabled = true
        barChart.scaleXEnabled = true
        barChart.rightAxis.enabled = false
        barChart.legend.enabled = false
        barChart.xAxis.drawGridLinesEnabled = false
    }

}
