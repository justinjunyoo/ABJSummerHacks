//
//  TexasAllBarTableViewCell.swift
//  webscraping
//
//  Created by Aarish  Brohi on 7/26/20.
//  Copyright © 2020 Aarish Brohi. All rights reserved.
//

import UIKit
import Charts

class TexasAllBarTableViewCell: UITableViewCell, ChartViewDelegate {


    @IBOutlet weak var barChart: BarChartView!
    @IBOutlet weak var texasAllBar: UIView!
    @IBOutlet weak var chartTitle: UILabel!
    @IBOutlet weak var yaxis: UILabel!
    
    
    var circleColors: [NSUIColor] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        barChart.delegate = self
        texasAllBar.backgroundColor = AppDelegate().uicolorFromHex(rgbValue: 0x313547)
        
        let marker = ChartMarker()
        marker.chartView = barChart
        barChart.marker = marker
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setBarChart(str: [String], values: [Double]) {
        var array: [BarChartDataEntry] = []
        
        for i in 0..<values.count  {
            array.append(BarChartDataEntry(x: Double(i), y: values[i]))
            let color = UIColor.link
            circleColors.append(color)
        }
        
        barChart.backgroundColor =  AppDelegate().uicolorFromHex(rgbValue: 0x313547)
        barChart.xAxis.labelTextColor = .link
        barChart.leftAxis.labelTextColor = .link
        
        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: str)

        let set = BarChartDataSet(entries: array)
        set.colors = circleColors
        let data = BarChartData(dataSet: set)
        barChart.data = data
        barChart.xAxis.labelFont = UIFont(name: "Verdana", size: 7.5)!
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
