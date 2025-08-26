#Requires AutoHotkey v2.0.2
#SingleInstance Force

; Komorebic(cmd) {
;     RunWait(format("komorebic.exe {}", cmd), , "Hide")
; }

; 激活给定的窗口，窗口不存在，则运行程序
_Activate(win_title, exe_path) {
    Sleep(100)
    If WinExist(win_title)
        WinActivate(win_title)
    else
        Run(exe_path)
}

; 将窗口调整为固定大小并居中的函数
_CenterAndResizeWindow(winTitle := "A") {
    try {
        ; 获取目标窗口的ID
        winHwnd := WinExist(winTitle)
        if !winHwnd {
            MsgBox "未找到指定窗口"
            return false
        }
        ; https://autohotkey.top/AutoHotkey2.0/docs/lib/Monitor.htm
        ; A_ScreenWidth、A_ScreenHeight 为内置变量
        WinMove(6, 70, A_ScreenWidth-12, A_ScreenHeight-80, winHwnd)
        
        return true
    } catch Error as e {
        MsgBox "调整窗口大小时出错: " e.Message
        return false
    }
}

; 将活动窗口调整并居中
#HotIf WinActive("A") ; 仅在活动窗口时触发
!F1:: {
    _CenterAndResizeWindow()
}

; Zen
^!+z::_Activate("ahk_exe zen.exe", "C:\Program Files\Zen Browser\zen.exe")
; VSCode
!c::_Activate("ahk_exe code.exe", "D:\Software\Normal\VSCode\Code.exe")
; Fork
!f::_Activate("ahk_exe Fork.exe", "C:\Users\33467\AppData\Local\Fork\current\Fork.exe")
; Obsidian
!d::_Activate("ahk_exe Obsidian.exe", "C:\Users\33467\AppData\Local\Programs\Obsidian\Obsidian.exe")
!x::WinMinimize("A")