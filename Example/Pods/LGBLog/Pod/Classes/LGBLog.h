
#ifndef LGBLog_h
#define LGBLog_h

//Log
#ifdef DEBUG
#define ZA_log(fmt,...)             NSLog(@"[%@:%d] " fmt, [[NSString stringWithFormat:@"%s", __FILE__] lastPathComponent], __LINE__, ##__VA_ARGS__)
#else
#define ZA_log(fmt,...)
#endif

#define ZA_logBounds(view)              ZA_log(@"%s bounds: %@", #view, NSStringFromCGRect([view bounds]))
#define ZA_logFrame(view)               ZA_log(@"%s frame: %@", #view, NSStringFromCGRect([view frame]))
#define ZA_logSize(size)                ZA_log(@"%s size: %@", #size, NSStringFromCGSize(size))
#define ZA_logString(str)               ZA_log(@"%s : %@", #str, str)
#define ZA_logObj(obj)                  ZA_log(@"%s : %@", #obj, obj)
#define ZA_logInteger(num)              ZA_log(@"%s : %ld", #num, (long)num)
#define ZA_logFloat(num)                ZA_log(@"%s : %f", #num, num)
#define ZA_logBool(num)                 ZA_log(@"%s : %@", #num, (num ? @"YES" : @"NO"))

#ifdef DEBUG
#define ZA_SHOW_VIEW_BORDERS    YES
#else
#define ZA_SHOW_VIEW_BORDERS    NO
#endif

#define ZA_showDebugBorderForViewColor(view, color)     if (ZA_SHOW_VIEW_BORDERS) { view.layer.borderColor = color.CGColor; view.layer.borderWidth = 1.0; }
#define ZA_showDebugBorderForView(view)                 ZA_showDebugBorderForViewColor(view, [UIColor colorWithWhite:0.0 alpha:0.25])


//Color
#define ZA_rgba(r,g,b,a)            [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define ZA_rgb(r,g,b)               ZA_rgba(r,g,b,1.0f)
#define ZA_hexRGBA(rgb, a)          ZA_rgba(((rgb & 0xFF0000) >> 16), ((rgb & 0xFF00) >> 8), (rgb & 0xFF), a)
#define ZA_hexRGB(rgb)              ZA_hexRGBA(rgb, 1.0)

#endif
