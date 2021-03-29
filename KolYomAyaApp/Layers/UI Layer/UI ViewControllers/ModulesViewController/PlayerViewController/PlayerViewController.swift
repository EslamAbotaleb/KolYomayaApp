
import UIKit
import MediaPlayer
import AVFoundation

class PlayerViewController: BaseViewController {
    var statusPlaying: Bool?
    @IBOutlet weak var nameReciterLabel: UILabel!
    @IBOutlet weak var nameSuraLabel: UILabel!
    var getaNameReciter: String?
    var getaImageReciter: String?
    var audioLinkPlay: String?
    var suraName: String?
    @IBOutlet weak var imageReciter: UIImageView!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var nextAya: UIButton!
    @IBOutlet weak var endTimeLabel: UILabel!
    var audioLinks: [AudioList]? = [AudioList]()
    @IBOutlet weak var sliderAudio: UISlider!
    @IBOutlet weak var previousAya: UIButton!
    @IBOutlet weak var startTimeLabel: UILabel!
    var position : Int  = 0
    @IBOutlet weak var holder: UIView!
//     = AVPlayer()
//      var isPlaying: Bool = false
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
    }
    func playAudioBackground() {
            do {
               try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default, options: [.mixWithOthers, .allowAirPlay])
                print("Playback OK")
                try AVAudioSession.sharedInstance().setActive(true)
                print("Session is Active")
            } catch {
                print(error)
            }
        }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let audios = self.audioLinks?[position]
        
        initPlayer(url: (audioLinkPlay)!)

        setupRemoteTransportControls()
//        setupNowPlaying()
        updateVideoPlayerSlider()
        self.updateVideoPlayerSlider()
        
        setupNotifications()
        
//        playAudioBackground()
        playPauseButton.setImage(UIImage(named: "pause_btn"), for: .normal)
        nextAya.setImage(UIImage(named: "forward.fill"), for: .normal)
              previousAya.setImage(UIImage(named: "backward.fill"), for: .normal)

        if self.suraName != nil {
            nameSuraLabel.text = self.suraName
        }
//                nameSuraLabel.text = self.audioLinks?[0].name
//                    audios?.name
        self.nameReciterLabel.text = getaNameReciter
        self.imageReciter.makeRounded()
//        self.imageReciter.imageFromURL(urlString: self.getaImageReciter ?? "")
        self.imageReciter.imageFromURL(urlString: self.getaImageReciter ?? "https://play-lh.googleusercontent.com/dddXO8_b6BbuzNbIPwIKY86uCi4iiEePAfkZPUKV_tfhE4n2-e5vh9pNPxRp61HsCg=s180-rw")
        playPauseButton.addTarget(self, action: #selector(didTapPlayPauseButton(_:)), for: .touchUpInside)
        nextAya.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        previousAya.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        sliderAudio?.addTarget(self, action: #selector(didSlideSlider), for: .valueChanged)
      
    }
    func updateVideoPlayerSlider(suraName: String? = "") {
        // 1 . Guard got compile error because `videoPlayer.currentTime()` not returning an optional. So no just remove that.
        let currentTimeInSeconds = CMTimeGetSeconds((InputDetails.details.player?.currentTime())!)
        // 2 Alternatively, you could able to get current time from `currentItem` - videoPlayer.currentItem.duration

        let mins = currentTimeInSeconds / 60
        let secs = currentTimeInSeconds.truncatingRemainder(dividingBy: 60)
        let timeformatter = NumberFormatter()
        timeformatter.minimumIntegerDigits = 2
        timeformatter.minimumFractionDigits = 0
        timeformatter.roundingMode = .down
        guard let minsStr = timeformatter.string(from: NSNumber(value: mins)), let secsStr = timeformatter.string(from: NSNumber(value: secs)) else {
            return
        }
        
        self.startTimeLabel.text = minsStr + ":" + secsStr
      
        sliderAudio.value = Float(currentTimeInSeconds) // I don't think this is correct to show current progress, however, this update will fix the compile error

        // 3 My suggestion is probably to show current progress properly
        if let currentItem = InputDetails.details.player?.currentItem {
            let duration = currentItem.duration
            if (CMTIME_IS_INVALID(duration)) {
                // Do sth
                return
            }
            let currentTime = currentItem.currentTime()
            
           sliderAudio.value = Float(CMTimeGetSeconds(currentTime) / CMTimeGetSeconds(duration))
        }
    }

    func initPlayer(url : String) {
        guard let url = URL.init(string: url) else { return }
        let playerItem = AVPlayerItem.init(url: url)
         

        InputDetails.details.player = AVPlayer.init(playerItem: playerItem)
        let timeScale = CMTimeScale(NSEC_PER_SEC)
        let time = CMTime(seconds: 0.5, preferredTimescale: timeScale)
        
        InputDetails.details.player?.addPeriodicTimeObserver(forInterval: time, queue: .main, using: { (progressTime) in
                let seconds = CMTimeGetSeconds(progressTime)
                let secondText = String(format: "%02d", Int(seconds) % 60)
                let minutes = String(format: "%02d", Int(seconds) / 60)
                self.startTimeLabel.text = minutes + ":" + secondText
                self.endTimeLabel.text = minutes + ":" + secondText
            if let duration = InputDetails.details.player?.currentItem?.duration {
                    let durationSeconds = CMTimeGetSeconds(duration)
                    self.sliderAudio?.value = Float(seconds / durationSeconds)
                }
            })

//        self.delegatePlayAudio?.statusPlaying = true
        InputDetails.details.player?.play()
        InputDetails.details.statusPl = true 
      
        
    }
    func setupNotifications() {
              let notificationCenter = NotificationCenter.default
              notificationCenter.addObserver(self,
                                             selector: #selector(handleInterruption),
                                             name: AVAudioSession.interruptionNotification,
                                             object: nil)
              notificationCenter.addObserver(self,
                                             selector: #selector(handleRouteChange),
                                             name: AVAudioSession.routeChangeNotification,
                                             object: nil)
            }
           func setupRemoteTransportControls() {
             // Get the shared MPRemoteCommandCenter
             let commandCenter = MPRemoteCommandCenter.shared()

             // Add handler for Play Command
             commandCenter.playCommand.addTarget { [unowned self] event in
                print("Play command - is playing: \(InputDetails.details.statusPl)")
                

                if !(InputDetails.details.statusPl!) {
                    InputDetails.details.statusPl = true
                    // play
                    InputDetails.details.player?.play()
                    self.playPauseButton.setImage(UIImage(named: "pause_btn"), for: .normal)
                    return .success
                }
               
                return .commandFailed
             }
             // Add handler for Pause Command
             commandCenter.pauseCommand.addTarget { [unowned self] event in
               print("Pause command - is playing: \(InputDetails.details.statusPl)")
//               if self.isPlaying {
//                 self.player?.pause()
//                self.playPauseButton.setImage(UIImage(named: "play_btn"), for: .normal)
//
//                 return .success
//               }
//
                if ((InputDetails.details.statusPl) != nil) {
                    InputDetails.details.statusPl = false
                    print("status\(InputDetails.details.statusPl)")
                           //pause
                    InputDetails.details.player?.pause()

                    self.playPauseButton.setImage(UIImage(named: "play_btn"), for: .normal)
    return .success
                       }
                return .commandFailed

              
         }
            
//            commandCenter.changePlaybackPositionCommand.addTarget
//                   { (event: MPRemoteCommandEvent) -> MPRemoteCommandHandlerStatus in
//                       let event = event as! MPChangePlaybackPositionCommandEvent
//                       print("change playback",event.positionTime)
//
//                    self.player?.seek(to: CMTime(seconds: event.positionTime, preferredTimescale: CMTimeScale(1000)), completionHandler: { [weak self](success) in
//                                                 guard let self = self else {return}
//                                                 if success {
////                                                    self.player?.rate = self.player?.rate
//                                                 }
//                                             })
//
////                    self.player?.currentTime = event.positionTime
//                       self.setupNowPlaying()
//                       return .success
//                   }
            

//            commandCenter.changePlaybackPositionCommand.addTarget { [weak self](remoteEvent) -> MPRemoteCommandHandlerStatus in
//                   guard let self = self else {return .commandFailed}
//                   if let player = self.player {
//                      let playerRate = player.rate
//                      if let event = remoteEvent as? MPChangePlaybackPositionCommandEvent {
//                          player.seek(to: CMTime(seconds: event.positionTime, preferredTimescale: CMTimeScale(1000)), completionHandler: { [weak self](success) in
//                              guard let self = self else {return}
//                              if success {
//                                  self.player?.rate = playerRate
//                              }
//                          })
//                          return .success
//                       }
//                   }
//                   return .commandFailed
//               }
//            UIApplication.shared.beginReceivingRemoteControlEvents()

            commandCenter.nextTrackCommand.addTarget { [unowned self] event in
                         print("Pause command - is playing: \(InputDetails.details.statusPl)")
//                         if self.isPlaying {
//                           self.player?.pause()
//                          self.playPauseButton.setImage(UIImage(named: "play_btn"), for: .normal)
//
//                           return .success
//                         }
//                self.isPlaying = false

                if self.position < (self.audioLinks!.count - 1) {
                    self.position = self.position + 1
//                    if !self.isPlaying {
                    InputDetails.details.player?.pause()
                    InputDetails.details.player = nil
                        self.playPauseButton.setImage(UIImage(named: "play_btn"), for: .normal)
                        self.configure()
                    self.updateVideoPlayerSlider(suraName: self.audioLinks?[self.position].name)
//                    self.setupNowPlaying(suraName: self.audioLinks?[self.position].name)

                        return .success
//                    }

                }
                return .commandFailed
            }
//
              commandCenter.previousTrackCommand.addTarget { [unowned self] event in
                print("Pause command - is playing: \(InputDetails.details.statusPl)")
            //                         if self.isPlaying {
            //                           self.player?.pause()
            //                          self.playPauseButton.setImage(UIImage(named: "play_btn"), for: .normal)
            //
            //                           return .success
            //                         }
//                self.isPlaying = false

                     if self.position > 0 {
                         self.position = self.position - 1

                        InputDetails.details.player?.pause()
                        InputDetails.details.player = nil
                         self.configure()
                        self.playPauseButton.setImage(UIImage(named: "pause_btn"), for: .normal)
                        return .success
                     }
                                     return .commandFailed
                                   }
           }
    
//
//    func setupNowPlaying(suraName: String? = "") {
//          // Define Now Playing Info
//          var nowPlayingInfo = [String : Any]()
//             let audios = self.audioLinks?[position]
//        nowPlayingInfo[MPMediaItemPropertyTitle] = audios?.name
//
//
//           let timeScale = CMTimeScale(NSEC_PER_SEC)
//           let time = CMTime(seconds: 0.5, preferredTimescale: timeScale)
//
//        InputDetails.details.player?.addPeriodicTimeObserver(forInterval: time, queue: .main, using: { (progressTime) in
//                   let seconds = CMTimeGetSeconds(progressTime)
//                   let secondText = String(format: "%02d", Int(seconds) % 60)
//                   let minutes = String(format: "%02d", Int(seconds) / 60)
//                   self.startTimeLabel.text = minutes + ":" + secondText
//                   self.endTimeLabel.text = minutes + ":" + secondText
//            if let duration = InputDetails.details.player?.currentItem?.duration {
//                       let durationSeconds = CMTimeGetSeconds(duration)
//                       self.sliderAudio?.value = Float(seconds / durationSeconds)
//                    nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = durationSeconds
//                    nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = time
//                nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = InputDetails.details.player?.rate
//
//
//                   }
//
//
//
//               })
//
//
//        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
//
//        }

        // MARK: Handle Notifications
        @objc func handleRouteChange(notification: Notification) {
          guard let userInfo = notification.userInfo,
            let reasonValue = userInfo[AVAudioSessionRouteChangeReasonKey] as? UInt,
            let reason = AVAudioSession.RouteChangeReason(rawValue:reasonValue) else {
              return
          }
          switch reason {
          case .newDeviceAvailable:
            let session = AVAudioSession.sharedInstance()
            for output in session.currentRoute.outputs where output.portType == AVAudioSession.Port.headphones {
              print("headphones connected")
              DispatchQueue.main.sync {
                InputDetails.details.player?.play()
              }
              break
            }
          case .oldDeviceUnavailable:
            if let previousRoute =
              userInfo[AVAudioSessionRouteChangePreviousRouteKey] as? AVAudioSessionRouteDescription {
              for output in previousRoute.outputs where output.portType == AVAudioSession.Port.headphones {
                print("headphones disconnected")
                DispatchQueue.main.sync {
                    InputDetails.details.player?.pause()
                }
                break
              }
            }
          default: ()
          }
        }

        @objc func handleInterruption(notification: Notification) {
          guard let userInfo = notification.userInfo,
            let typeValue = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt,
            let type = AVAudioSession.InterruptionType(rawValue: typeValue) else {
              return
          }

          if type == .began {
            print("Interruption began")
            // Interruption began, take appropriate actions
          }
          else if type == .ended {
            if let optionsValue = userInfo[AVAudioSessionInterruptionOptionKey] as? UInt {
              let options = AVAudioSession.InterruptionOptions(rawValue: optionsValue)
              if options.contains(.shouldResume) {
                // Interruption Ended - playback should resume
                print("Interruption Ended - playback should resume")
                InputDetails.details.player?.play()
              } else {
                // Interruption Ended - playback should NOT resume
                print("Interruption Ended - playback should NOT resume")
              }
            }
          }
        }
    
    func configure() {

        let audios = self.audioLinks?[position]
        
        initPlayer(url: (audios?.audioLink)!)
        
        playPauseButton.setImage(UIImage(named: "pause_btn"), for: .normal)
        nameSuraLabel.text = audios?.name
        updateVideoPlayerSlider()
        // Player Controls
        self.nameReciterLabel.text = getaNameReciter
        self.imageReciter.makeRounded()
        self.imageReciter.imageFromURL(urlString: self.getaImageReciter ?? "https://play-lh.googleusercontent.com/dddXO8_b6BbuzNbIPwIKY86uCi4iiEePAfkZPUKV_tfhE4n2-e5vh9pNPxRp61HsCg=s180-rw")
        
        playPauseButton.addTarget(self, action: #selector(didTapPlayPauseButton(_:)), for: .touchUpInside)
        nextAya.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        previousAya.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        nextAya.setImage(UIImage(named: "forward.fill"), for: .normal)
        previousAya.setImage(UIImage(named: "backward.fill"), for: .normal)
        
        sliderAudio?.addTarget(self, action: #selector(didSlideSlider), for: .valueChanged)
        
    }
    @objc func didTapBackButton() {
        InputDetails.details.statusPl = false

        if position > 0 {
            position = position - 1
            InputDetails.details.player?.pause()
            InputDetails.details.player = nil
            configure()
            
        }
    }
    
    @objc func didTapNextButton() {
//        self.sliderAudio.value = 0
        InputDetails.details.statusPl = false

        if position < (audioLinks!.count - 1) {
                  position = position + 1
            InputDetails.details.player?.pause()
            InputDetails.details.player = nil
    
                  configure()
              }
    }
    
    @objc func didTapPlayPauseButton(_ sender: UIButton) {
        
//        ((InputDetails.details.statusPl) != nil)
        if InputDetails.details.statusPl == true  {
            InputDetails.details.statusPl = false
            print("falsefalse\(InputDetails.details.statusPl)")
            //pause
            InputDetails.details.player?.pause()

            playPauseButton.setImage(UIImage(named: "play_btn"), for: .normal)

        } else {
            InputDetails.details.statusPl = true
            print("truetrue\(InputDetails.details.statusPl)")

            // play
            InputDetails.details.player?.play()
            playPauseButton.setImage(UIImage(named: "pause_btn"), for: .normal)

        }
    }
    @objc func didSlideSlider( slider: UISlider) {
        
        if let duration = InputDetails.details.player?.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            let value = Float64(sliderAudio!.value) * totalSeconds
            if value.isNaN {
                print("nanannannanananananana")
                sliderAudio.isContinuous = false
                slider.isEnabled = false
            } else {
                let seekTime = CMTime(value: Int64(value), timescale: 1)
    //            slider.setValue(seekTime, animated: true)
                InputDetails.details.player?.seek(to: seekTime, completionHandler: { (completedSeek) in

                })
            }
           
        }
       
    }
    @objc func sliderAction(_ sender: UISlider, forEvent event: UIEvent) {
        
        if let touchEvent = event.allTouches?.first {
          switch touchEvent.phase {
          case .began:
            print("touches began")
//            sliderTouchBegan()
          case .ended:
            print("touches ended")
//            sliderTouchEnded()
          default:
            print("no")
//            delegate?.sliderValueUpdated(sender.value)
          }
        }
      }

//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
////        player?.pause()
//
//        if isBeingDismissed {
//             // TODO: Do your stuff here.
//            isPlaying = true
//            print("glksjglishlihihkhkuh")
//         }
//    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if (isBeingDismissed || isMovingFromParent) {
            // clean up code here
            InputDetails.details.statusPl = true
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
