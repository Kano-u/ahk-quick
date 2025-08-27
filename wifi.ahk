#Requires AutoHotkey v2.0

; https://autohotkey.top/AutoHotkey2.0/docs/lib/TrayTip.htm
; TrayTip("text", "title", 16)

result := Run_获取输出_使用临时文件('netsh wlan show interface | findstr ""0-wifi-out-online""')
if (result = "") {
  Run("netsh wlan connect name=0-wifi-out-online", ,"Hide")
  Sleep(1000)
  output := Run_获取输出_使用临时文件('netsh wlan show interface | findstr ""0-wifi-out-online""')
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


/**
 * 运行命令并获取输出 (使用临时文件)
 * @param command The command string to execute.
 * @returns {String} The output of the command.
 */
Run_获取输出_使用临时文件(command) {
    ; 创建一个唯一的临时文件名
    tempFile := A_Temp . "\" . A_Now . "_" . A_TickCount . ".tmp"
    ; 'cmd.exe /c' 用于执行命令。
    ; '>' 是重定向符号，将输出写入文件。 '2>&1' 将标准错误也重定向到标准输出，这样错误信息也会被捕获。
    RunWait('cmd.exe /c "' . command . '" > "' . tempFile . '" 2>&1', , "Hide")
    ; 检查文件是否存在，以防命令执行失败没有创建文件
    if !FileExist(tempFile)
        return "错误：命令可能执行失败，未生成输出文件。"
    ; 读取临时文件的内容
    output := FileRead(tempFile, "UTF-8") ; 建议使用 UTF-8 编码读取，以兼容更多情况
    ; 删除临时文件
    try FileDelete(tempFile)

    return output
}
