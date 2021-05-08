//
//  ViewController.swift
//  10YearChallenge十年
//
//  Created by ROSE on 2021/5/8.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateSlider: UISlider!
    @IBOutlet weak var yearLabel: UILabel!
    
    //指定特定時間生成 Date
    let dateFormatter = DateFormatter()
    var dateString:String = "2018/02/01"
    var timer:Timer?
    var imageNumber = 0
    var sliderNumber = 0
    
    //Array 依序列出欲顯示之圖片
    let photosArray = [
        "2018-02-1", "2018-03-1", "2018-04-1", "2018-05-1", "2018-06-1", "2018-07-1", "2018-08-1", "2018-09-1", "2018-10-1","2018-11-1", "2018-12-1","2019-01-1"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        dateSlider.setThumbImage(UIImage(named: "icon"), for: .normal)
    }
    
    //使用switch做選擇照片的連續數值判斷
    func choosePhoto(num1:Int){
        switch  num1 {
        case 0:
            dateString = "2018/02/01"
        case 1:
            dateString = "2018/03/01"
        case 2:
            dateString = "2018/04/01"
        case 3:
            dateString = "2018/05/01"
        case 4:
            dateString = "2018/06/01"
        case 5:
            dateString = "2018/07/01"
        case 6:
            dateString = "2018/08/01"
        case 7:
            dateString = "2018/09/01"
        case 8:
            dateString = "2018/10/01"
        case 9:
            dateString = "2018/11/01"
        case 10:
            dateString = "2018/12/01"
        default:
            dateString = "2019/01/01"
        }
        //使datePicker顯示之日期為dateString內的字串
        let date = dateFormatter.date(from: dateString)
        datePicker.date = date!
        
        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: datePicker.date)
        let year = dateComponents.year!
        var month = dateComponents.month!
        let day = dateComponents.day!
        month -= 1
        
        yearLabel.text = "\(year)-\(month)-\(day)"
    }
    //if eles, 比對Array內的照片
    func compare() {
        if imageNumber >= photosArray.count{
            imageNumber = 0
            choosePhoto(num1: imageNumber)
            photoImageView.image = UIImage(named: photosArray[imageNumber])
        }else{
            choosePhoto(num1: imageNumber)
            photoImageView.image = UIImage(named: photosArray[imageNumber])
        }
        //連動slider
        dateSlider.value = Float(imageNumber)
        imageNumber += 1
    }
    
    //每秒執行一次compare(使圖片跑起來)
    func time() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {(timer) in
            self.compare()
        })
    }
    
    
    
    @IBAction func chageDate(_ sender: UIDatePicker) {
        //取得datePicker的日期
        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: datePicker.date)
        let year = dateComponents.year!
        var month = dateComponents.month!
        let day = dateComponents.day!
        //Array由0開始，因此月份需-1
        month -= 1
        photoImageView.image = UIImage(named: photosArray[month])
        //連動slider
        dateSlider.value = Float(month)
        yearLabel.text = "\(year)-\(month)-\(day)"
    }
    
    // Slider拉把
    @IBAction func changeDateSlider(_ sender: UISlider) {
        //取得日期
        sliderNumber = Int(sender.value)
        dateSlider.value.round()
        yearLabel.text = photosArray[sliderNumber]
        photoImageView.image = UIImage(named: photosArray[sliderNumber])
    }
    
    //自動播放
    @IBAction func autoPlay(_ sender: UISwitch) {
        if sender.isOn{
            time()
            imageNumber = sliderNumber
            dateSlider.value = Float(imageNumber)
        }else{
            timer?.invalidate()
        }
    }
    
}

