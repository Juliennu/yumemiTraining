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
    
    
    @objc func tappedReloadButton() {
        
        do {
            let weatherString = try YumemiWeather.fetchWeather(at: "Tokyo")
            print(weatherString)
            switchWeatherImage(weather: weatherString)
            
        } catch let err {
            //エラー処理
            print(err)
            let errMessage = switchErrMessage(err: err)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            showAlert(title: "エラー", message: errMessage, actions: [okAction])

        }
        
        

    }
    
    
    
    
    
    
    

}
