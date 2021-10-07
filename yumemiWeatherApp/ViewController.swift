//
//  ViewController.swift
//  yumemiWeatherApp
//
//  Created by Juri Ohto on 2021/08/10.
//

import UIKit
import YumemiWeather

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var reloadButton: UIButton!
    
    
    // imageのRenderingModeをalwaysTemplateに変更
    let sunnyImage = UIImage(named: "sunny")?.withRenderingMode(.alwaysTemplate)
    let cloudyImage = UIImage(named: "cloudy")?.withRenderingMode(.alwaysTemplate)
    let rainyImage = UIImage(named: "rainy")?.withRenderingMode(.alwaysTemplate)
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
   
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setUpView()
        
    }
    
    func setUpView() {
        
        let viewWidth = view.frame.width
        let imageViewSide = viewWidth / 2
        let labelsWidth = imageViewSide / 2
        
        imageView.image = sunnyImage
        imageView.tintColor = .red

        
        leftLabel.textColor = .blue
        leftLabel.textAlignment = .center
        
        rightLabel.textColor = .red
        rightLabel.textAlignment = .center
        
        closeButton.setTitle("Close", for: .normal)
        
        reloadButton.setTitle("Reload", for: .normal)
        //reloadButtonにアクションを追加する
        reloadButton.addTarget(self, action: #selector(tappedReloadButton), for: .touchUpInside)
        
        
        //Autosizingというレイアウトの仕組みを、AutoLayoutに変換するかどうかを設定するフラグをオフにする
        imageView.translatesAutoresizingMaskIntoConstraints = false
        leftLabel.translatesAutoresizingMaskIntoConstraints = false
        rightLabel.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        reloadButton.translatesAutoresizingMaskIntoConstraints = false
        
        //imageViewの幅を設定
        imageView.widthAnchor.constraint(equalToConstant: imageViewSide).isActive = true
        //imageViewの高さを設定
        imageView.heightAnchor.constraint(equalToConstant: imageViewSide).isActive = true
        //x座標の中心を親Viewと合わせる
        imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        //y座標の中心を親Viewと合わせる
        imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        
        leftLabel.widthAnchor.constraint(equalToConstant: labelsWidth).isActive = true
        //leftlableのおしりを親Viewの中心に設定
        leftLabel.trailingAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        //leftLabelをimageViewのbottomの真下に配置
        leftLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        
        
        rightLabel.widthAnchor.constraint(equalToConstant: labelsWidth).isActive = true
        //rightLabelのあたまを親Viewの中心に設定
        rightLabel.leftAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        rightLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        
        
        //closeLabelのy座標をleftLabelから80pt話す
        closeButton.topAnchor.constraint(equalTo: leftLabel.bottomAnchor, constant: 80).isActive = true
        //closeButtonの中央をleftLabelと合わせる
        closeButton.centerXAnchor.constraint(equalTo: leftLabel.centerXAnchor).isActive = true
        
        
        reloadButton.topAnchor.constraint(equalTo: rightLabel.bottomAnchor, constant: 80).isActive = true
        reloadButton.centerXAnchor.constraint(equalTo: rightLabel.centerXAnchor).isActive = true
  
    }

    func switchWeatherImage(weather: String) {
        switch weather {
        case "sunny":
            imageView.image = sunnyImage
            imageView.tintColor = .red
        case "cloudy":
            imageView.image = cloudyImage
            imageView.tintColor = .gray
        case "rainy":
            imageView.image = rainyImage
            imageView.tintColor = .blue
        default:
            break
        }
    }
    
    func switchErrMessage(err: Error) -> String {
        switch err {
        case YumemiWeatherError.invalidParameterError:
            return "既定範囲外です"
        case YumemiWeatherError.unknownError:
            return "不明なエラーが発生しました"
        default:
            return ""
        }
    }
    
    //オブジェクトからJSON文字列を生成
    let weatherInfo = WeatherInformation(area: "tokyo", date: "2020-04-01T12:00:00+09:00")

//    var jsonString = ""

    //JSONへのエンコード
    public func jsonEncode() -> String {
        
        var jsonString = ""
        
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.prettyPrinted, .withoutEscapingSlashes]
            let jsonData = try encoder.encode(weatherInfo)
            jsonString = String(data: jsonData, encoding: .utf8) ?? ""
            
        } catch {
            print(error.localizedDescription)
        }
        return jsonString
    }
    
    //Jsonからのデコード
    public func jsonDecode(jsonString: String) -> (String, Int, Int){
        //Stringをjson形式へ変換
        let json = jsonString.data(using: .utf8)!

        var weather: String = ""
        var maxTemp: Int = 0
        var minTemp: Int = 0

        do {
            let decoder = JSONDecoder()
            let data = try decoder.decode(WeatherData.self, from: json)
            weather = data.weather
            maxTemp = data.maxTemp
            minTemp = data.minTemp
//            print(weather)
        } catch {
            print(error)
        }
        return (weather, maxTemp, minTemp)
    }
    
    @objc func tappedReloadButton() {
        do {
            let weatherString = try YumemiWeather.fetchWeather(jsonEncode())
            let data = jsonDecode(jsonString: weatherString)
            switchWeatherImage(weather: data.0)
            print(data.0)
            leftLabel.text = "\(data.2)"//minTemp
            rightLabel.text = "\(data.1)"//maxTemp
        } catch let err {
            //エラー処理
            let errMessage = switchErrMessage(err: err)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            showAlert(title: "エラー", message: errMessage, actions: [okAction])
        }
    }
}
