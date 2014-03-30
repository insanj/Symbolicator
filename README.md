Symbolicator
============

(not yet working on arm64)

Symbolicator for iOS 6 and iOS 7 - it's a Cydia Substrate library that reveals "&lt;redacted>" symbol names at runtime in calls made to +[NSThread callStackSymbols] or -[NSException callStackSymbols], by making use of Symbolicator.framework and the ObjC runtime

Useful when debugging without the need to crash the application, or when reverse engineering some application or framework. This was the usual in iOS 5 and older, but starting in iOS 6 all of their frameworks symbols are hidden (which you can later symbolicate in XCode with a CrashReport, but this is not possible to do at runtime), probably due to the different format found on dyld_shared_cache

### Important: ######
**Do NOT inject this library into all processes**. Choose the ones you will work with in your filter plist, because current version also uses the ObjC runtime to load all class and method names and while optimized, it is still very expensive. If you load it in every process, system will be likely to crash.

Before:
============
![Before](http://i.minus.com/jfz6PHQIhjxVS.png)

After:
============
![After](http://i.minus.com/jrlBCbM6FM19C.png)

##Fork Explanation

After investigating this library for a while, I decided it'd be awfully convenient to have a pre-compiled as well as an easily-compilable version publicly available for theos / Cydia Substrate. I can't offer any guarantees or liability for usage, but in my experience, this fork works well on non-arm64 devices. If you have trouble using it at first, just keep at it. This is the average syslog from my experimentation:

	MobileSMS[1694]: MS:Notice: Injecting: com.apple.MobileSMS [MobileSMS] (847.21)
	MobileSMS[1694]: MS:Notice: Loading: /Library/MobileSubstrate/DynamicLibraries/Symbolicator.dylib
	backboardd[1663]: CoreAnimation: timed out fence 2402b
	backboardd[1663]: CoreAnimation: timed out fence 17adf
	backboardd[1663]: CoreAnimation: updates deferred for too long
	MobileSMS[1694]: Symbolicator: Loading all methods addresses from objc runtime
	MobileSMS[1694]: MobileSMS(1694,0x2c1000) malloc: *** error for object 0x166fa494: incorrect checksum for freed object - object was probably modified after being freed.
	*** set a breakpoint in malloc_error_break to debug
	ReportCrash[1695]: MS:Notice: Injecting: (null) [ReportCrash] (847.21)
	ReportCrash[1695]: ReportCrash acting against PID 1694
	ReportCrash[1695]: Formulating crash report for process MobileSMS[1694]
	com.apple.launchd[1] (UIKitApplication:com.apple.MobileSMS[0x1bd6][1694]): (UIKitApplication:com.apple.MobileSMS[0x1bd6]) Job appears to have crashed: Abort trap: 6
	com.apple.launchd[1] (UIKitApplication:com.apple.MobileSMS[0x1bd6]): (UIKitApplication:com.apple.MobileSMS[0x1bd6]) Throttling respawn: Will start in 2147483623 seconds
	backboardd[1663]: Application 'UIKitApplication:com.apple.MobileSMS[0x1bd6]' exited abnormally with signal 6: Abort trap: 6
	networkd[146]: Analytics Engine: double ON for app: com.apple.MobileSMS
	MobileSMS[1697]: MS:Notice: Injecting: com.apple.MobileSMS [MobileSMS] (847.21)
	ReportCrash[1695]: Saved crashreport to /var/mobile/Library/Logs/CrashReporter/...
	MobileSMS[1697]: MS:Notice: Loading: /Library/MobileSubstrate/DynamicLibraries/Symbolicator.dylib
	MobileSMS[1697]: Symbolicator: Loading all methods addresses from objc runtime
	MobileSMS[1697]: Symbolicator: All addresses loaded and sorted 1467 milliseconds

============
