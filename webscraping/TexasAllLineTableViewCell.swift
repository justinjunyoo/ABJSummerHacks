//
//  TexasAllTimeTableViewCell.swift
//  webscraping
//
//  Created by Aarish  Brohi on 7/25/20.
//  Copyright © 2020 Aarish Brohi. All rights reserved.
//

import UIKit
import Charts




class TexasAllLineTableViewCell: UITableViewCell, ChartViewDelegate{


    @IBOutlet weak var lineChart: LineChartView!
    
    
    let markerView = MarkerView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lineChart.delegate = self

        let marker = ChartMarker()
        marker.chartView = lineChart
        lineChart.marker = marker
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

//    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
//        let graphPoint = chartView.getMarkerPosition(highlight: highlight)
//        let cases = NSInteger(entry.y)
//        let days = NSInteger(entry.x)
//        markerView.caseLabel.text = String(cases)
//        markerView.dayLabel.text = String(days)
//        markerView.center = CGPoint(x: graphPoint.x, y: markerView.center.y)
//
//
//        markerView.isHidden = false
//    }

    func setLineChart(str: [String], values: [Double]){
        let dog = str
        var array: [ChartDataEntry] = []
//        lineChart.backgroundColor = UIColor.white
//        for i in 0..<str.count{
//            dog[i] = dog[i].replacingOccurrences(of: "-", with: ".", options: NSString.CompareOptions.literal, range: nil)
//            let cnt = Double(dog[i]) ?? 0.0
//            cat.append(cnt)
//        }
        
        for i in 0..<values.count{
            array.append(ChartDataEntry(x: Double(i), y: values[i]))
        }
        var rat = [String]()
        for i in 0..<values.count{
            rat.append(String(i))
        }
        lineChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: dog)
    
        lineChart.xAxis.labelFont = UIFont(name: "Verdana", size: 7.5)!
        let set = LineChartDataSet(entries: array)
        set.colors = ChartColorTemplates.material()
        let data = LineChartData(dataSet: set)
        lineChart.data = data

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
