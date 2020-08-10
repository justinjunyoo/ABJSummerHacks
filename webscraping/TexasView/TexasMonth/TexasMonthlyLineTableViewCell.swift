//
//  TexasMonthlyLineTableViewCell.swift
//  webscraping
//
//  Created by Aarish  Brohi on 7/27/20.
//  Copyright © 2020 Aarish Brohi. All rights reserved.
//

import UIKit
import Charts

class TexasMonthlyLineTableViewCell: UITableViewCell, ChartViewDelegate{

    
    @IBOutlet weak var lineChart: LineChartView!
    @IBOutlet weak var texasLineMonthView: UIView!
    var circleColors: [NSUIColor] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lineChart.delegate = self
        texasLineMonthView.backgroundColor = AppDelegate().uicolorFromHex(rgbValue: 0x313547)

        let marker = ChartMarker()
        marker.chartView = lineChart
        lineChart.marker = marker
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setLineChart(str: [String], values: [Double]){
        var array: [ChartDataEntry] = []
        
        for i in 0..<values.count{
            array.append(ChartDataEntry(x: Double(i), y: values[i]))
            let color = UIColor.link
            circleColors.append(color)
        }
        
        lineChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: str)
        
        lineChart.xAxis.labelFont = UIFont(name: "Verdana", size: 7.5)!
        let set = LineChartDataSet(entries: array)
        set.colors = circleColors
        let data = LineChartData(dataSet: set)
        lineChart.data = data
        
        lineChart.backgroundColor =  AppDelegate().uicolorFromHex(rgbValue: 0x313547)
        lineChart.xAxis.labelTextColor = .link
        lineChart.leftAxis.labelTextColor = .link
        lineChart.leftAxis.axisMinimum = 0.0
        
        set.drawCirclesEnabled = false
        data.setDrawValues(false)
        lineChart.data?.setDrawValues(false)
        lineChart.pinchZoomEnabled = true
        lineChart.scaleYEnabled = true
        lineChart.scaleXEnabled = true
        lineChart.xAxis.labelPosition = .bottom
        lineChart.leftAxis.spaceBottom = 0.0
        //        lineChart.highlighter = nil
        lineChart.rightAxis.enabled = false
        lineChart.legend.enabled = false
        lineChart.xAxis.drawGridLinesEnabled = false
        lineChart.leftAxis.zeroLineWidth = 0
        lineChart.rightAxis.zeroLineWidth = 0
        lineChart.rightAxis.removeAllLimitLines()
        lineChart.leftAxis.removeAllLimitLines()
    }
    
    
}
