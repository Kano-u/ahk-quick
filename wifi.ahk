#Requires AutoHotkey v2.0

; https://autohotkey.top/AutoHotkey2.0/docs/lib/TrayTip.htm
; TrayTip("text", "title", 16)

result := RunWaitOne('netsh wlan show interface | findstr ""0-wifi-out-online""')
if (result = "") {
  Run("netsh wlan connect name=0-wifi-out-online")
  Sleep(1000)
  output := RunWaitOne('netsh wlan show interface | findstr ""0-wifi-out-online""')
  if (output = "") {
    TrayTip("未连接到 WiFi：0-wifi-out-online", "", 16)
  }
  else {
    TrayTip("✅ 连接 0-wifi-out-online 成功", "", 16)
  }
}
else {
  TrayTip("ℹ️ 已连接 0-wifi-out-online", "", 16)
}











; https://autohotkey.top/AutoHotkey2.0/docs/lib/Run.htm
; 在以上网页链接中，出现该函数的定义
RunWaitOne(command) {
  shell := ComObject("WScript.Shell")
  ; 通过 cmd.exe 执行单条命令
  exec := shell.Exec(A_ComSpec " /C " command)
  ; 读取并返回命令的输出
  return exec.StdOut.ReadAll()
}
