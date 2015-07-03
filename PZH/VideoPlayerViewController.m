//
//  VideoPlayViewController.m
//  PZH
//
//  Created by ZengYifei on 15/7/1.
//  Copyright (c) 2015年 IOS-develop. All rights reserved.
//

#import "VideoPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface VideoPlayerViewController () <UIGestureRecognizerDelegate, UIActionSheetDelegate>
{
    VLCMediaPlayer *_mediaplayer;
//    BOOL _setPosition;
//    BOOL _displayRemainingTime;
//    int _currentAspectRatioMask;
//    NSArray *_aspectRatios;
//    UIActionSheet *_audiotrackActionSheet;
//    UIActionSheet *_subtitleActionSheet;
//    NSURL *_url;
//    NSTimer *_idleTimer;
}
@end

@implementation VideoPlayerViewController
@synthesize movieView;//,positionSlider,timeDisplay,playPauseButton,subtitleSwitcherButton,audioSwitcherButton,toolbar,controllerPanel,volumeView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.view.frame = [[UIScreen mainScreen] bounds];
        self.navigationItem.hidesBackButton = NO;
        UIBarButtonItem * back = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
        self.navigationItem.leftBarButtonItem = back;
        
        UIBarButtonItem * play = [[UIBarButtonItem alloc]initWithTitle:@"Play" style:UIBarButtonItemStylePlain target:self action:@selector(playOrPause)];
        self.navigationItem.rightBarButtonItem = play;
        self.movieView = [[UIView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
        //self.movieView.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:self.movieView];
        
        
        UIView * timeControllVIew = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 290, 65)];
        UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, 170, 65)];
        slider.minimumValue = 0;
        slider.maximumValue = 100;
        slider.value = 0;
        //[slider addTarget:self action:@selector(updateValue:) forControlEvents:UIControlEventValueChanged];
        [timeControllVIew addSubview:slider];
        
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(180, 0, 50, 65)];
        timeLabel.text = @"00";
        [timeControllVIew addSubview:timeLabel];
        
        self.navigationItem.titleView = timeControllVIew;
        
       
    }
    return self;
}

- (void)back{
    [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
    //[self.navigationController popViewControllerAnimated:YES];
}

- (void)playOrPause{
//    if (_mediaplayer.isPlaying){
//        [_mediaplayer pause];
//        self.navigationItem.rightBarButtonItem.title = @"play";
//    }else{
//        [_mediaplayer play];
//        self.navigationItem.rightBarButtonItem.title = @"Pause";
//    }
    [_mediaplayer play];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _mediaplayer = [[VLCMediaPlayer alloc] init];
    _mediaplayer.delegate = self;
    _mediaplayer.drawable = self.movieView;
    _mediaplayer.media = [VLCMedia mediaWithURL:[NSURL URLWithString:@"http://www.panzhihua.gov.cn/images/zjpzh/yxpzh/sppzh/xxp/2323.wmv"]];
    //[_mediaplayer pause];
//    self.wantsFullScreenLayout = YES;
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//    
//    /* we want to influence the system volume */
//    [[AVAudioSession sharedInstance] setDelegate:self];
//    
//    /* populate array of supported aspect ratios (there are more!) */
//    _aspectRatios = @[@"DEFAULT", @"FILL_TO_SCREEN", @"4:3", @"16:9", @"16:10", @"2.21:1"];
//    
//    /* fix-up the UI */
//    CGRect rect = self.toolbar.frame;
//    rect.size.height += 20.;
//    self.toolbar.frame = rect;
//    [self.timeDisplay setTitle:@"" forState:UIControlStateNormal];
//    
//    /* this looks a bit weird, but let's try to support iOS 5 */
//    UISlider *volumeSlider = nil;
//    for (id aView in self.volumeView.subviews){
//        if ([[[aView class] description] isEqualToString:@"MPVolumeSlider"]){
//            volumeSlider = (UISlider *)aView;
//            break;
//        }
//    }
//    [volumeSlider addTarget:self
//                     action:@selector(volumeSliderAction:)
//           forControlEvents:UIControlEventValueChanged];
//    
//    /* setup gesture recognizer to toggle controls' visibility */
//    movieView.userInteractionEnabled = NO;
//    UITapGestureRecognizer *tapOnVideoRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleControlsVisible)];
//    tapOnVideoRecognizer.delegate = self;
//    [self.view addGestureRecognizer:tapOnVideoRecognizer];
}

//- (void)playMediaFromURL:(NSURL*)theURL
//{
//    _url = theURL;
//}
//
//- (void)playandPause:(id)sender
//{
//    if (_mediaplayer.isPlaying)
//        [_mediaplayer pause];
//    
//    [_mediaplayer play];
//}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //[self.navigationController setNavigationBarHidden:YES animated:YES];
    
    /* setup the media player instance, give it a delegate and something to draw into */
    //_mediaplayer = [[VLCMediaPlayer alloc] init];
    
    
    //_mediaplayer.delegate = self;
    //_mediaplayer.drawable = self.movieView;
    
    /* listen for notifications from the player */
//    [_mediaplayer addObserver:self forKeyPath:@"time" options:0 context:nil];
//    [_mediaplayer addObserver:self forKeyPath:@"remainingTime" options:0 context:nil];
//    
//    /* create a media object and give it to the player */
//    _mediaplayer.media = [VLCMedia mediaWithURL:_url];
//    
//    [_mediaplayer play];
//    
//    if (self.controllerPanel.hidden)
//        [self toggleControlsVisible];
//    
//    [self _resetIdleTimer];
}


//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    
//    if (_mediaplayer) {
//        @try {
//            [_mediaplayer removeObserver:self forKeyPath:@"time"];
//            [_mediaplayer removeObserver:self forKeyPath:@"remainingTime"];
//        }
//        @catch (NSException *exception) {
//            NSLog(@"we weren't an observer yet");
//        }
//        
//        if (_mediaplayer.media)
//            [_mediaplayer stop];
//        
//        if (_mediaplayer)
//            _mediaplayer = nil;
//    }
//    
//    if (_idleTimer) {
//        [_idleTimer invalidate];
//        _idleTimer = nil;
//    }
//    
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
//}

//- (void)toggleControlsVisible
//{
//    BOOL controlsHidden = !self.controllerPanel.hidden;
//    self.controllerPanel.hidden = controlsHidden;
//    self.toolbar.hidden = controlsHidden;
//    [[UIApplication sharedApplication] setStatusBarHidden:controlsHidden withAnimation:UIStatusBarAnimationFade];
//}
//
//- (void)_resetIdleTimer
//{
//    if (!_idleTimer)
//        _idleTimer = [NSTimer scheduledTimerWithTimeInterval:5.
//                                                      target:self
//                                                    selector:@selector(idleTimerExceeded)
//                                                    userInfo:nil
//                                                     repeats:NO];
//    else {
//        if (fabs([_idleTimer.fireDate timeIntervalSinceNow]) < 5.)
//            [_idleTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:5.]];
//    }
//}
//
//- (void)idleTimerExceeded
//{
//    _idleTimer = nil;
//    
//    if (!self.controllerPanel.hidden)
//        [self toggleControlsVisible];
//}

//- (UIResponder *)nextResponder
//{
//    [self _resetIdleTimer];
//    return [super nextResponder];
//}
//
//- (void)positionSliderAction:(UISlider *)sender
//{
//    [self _resetIdleTimer];
//    
//    /* we need to limit the number of events sent by the slider, since otherwise, the user
//     * wouldn't see the I-frames when seeking on current mobile devices. This isn't a problem
//     * within the Simulator, but especially on older ARMv7 devices, it's clearly noticeable. */
//    [self performSelector:@selector(_setPositionForReal) withObject:nil afterDelay:0.3];
//    _setPosition = NO;
//}
//
//- (void)_setPositionForReal
//{
//    if (!_setPosition) {
//        _mediaplayer.position = self.positionSlider.value;
//        _setPosition = YES;
//    }
//}
//
//- (void)positionSliderDrag:(id)sender
//{
//    [self _resetIdleTimer];
//}
//
//- (void)volumeSliderAction:(id)sender
//{
//    [self _resetIdleTimer];
//}
//
//- (void)mediaPlayerStateChanged:(NSNotification *)aNotification
//{
//    VLCMediaPlayerState currentState = _mediaplayer.state;
//    
//    /* distruct view controller on error */
//    if (currentState == VLCMediaPlayerStateError)
//        [self performSelector:@selector(closePlayback:) withObject:nil afterDelay:2.];
//    
//    /* or if playback ended */
//    if (currentState == VLCMediaPlayerStateEnded || currentState == VLCMediaPlayerStateStopped)
//        [self performSelector:@selector(closePlayback:) withObject:nil afterDelay:2.];
//    
//    [self.playPauseButton setTitle:[_mediaplayer isPlaying]? @"Pause" : @"Play" forState:UIControlStateNormal];
//}
//
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    self.positionSlider.value = [_mediaplayer position];
//    
//    if (_displayRemainingTime)
//        [self.timeDisplay setTitle:[[_mediaplayer remainingTime] stringValue] forState:UIControlStateNormal];
//    else
//        [self.timeDisplay setTitle:[[_mediaplayer time] stringValue] forState:UIControlStateNormal];
//}
//
//- (void)toggleTimeDisplay:(id)sender
//{
//    [self _resetIdleTimer];
//    _displayRemainingTime = !_displayRemainingTime;
//}
//
//
//
//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
//    if (buttonIndex == [actionSheet cancelButtonIndex])
//        return;
//    
//    NSArray *indexArray;
//    if (actionSheet == _subtitleActionSheet) {
//        indexArray = _mediaplayer.videoSubTitlesIndexes;
//        if (buttonIndex <= indexArray.count) {
//            _mediaplayer.currentVideoSubTitleIndex = [indexArray[buttonIndex] intValue];
//        }
//    } else if (actionSheet == _audiotrackActionSheet) {
//        indexArray = _mediaplayer.audioTrackIndexes;
//        if (buttonIndex <= indexArray.count) {
//            _mediaplayer.currentAudioTrackIndex = [indexArray[buttonIndex] intValue];
//        }
//    }
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
