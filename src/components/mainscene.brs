function init()
    m.top.setFocus(true)
    m.txtQRCode = m.top.findNode("TextQrCode")
    m.keyboardDialog = m.top.findNode("KeyboardDialog")
    m.keyboardDialog.observeFieldScoped("buttonSelected", "dismissDialog")
    m.keyboardDialog.observeFieldScoped("text", "handleTextEdit")
    m.qrview = m.top.findNode("generateQrView")

    m.qrview.observeField("renderComplete", "fixQrPosition")
    m.qrview.callfunc("renderQR", m.txtQRCode.text)
    m.graphicWidth = 400
    m.graphicHeight = 400

    m.qrview.width = 400
    m.qrview.height = 400

    m.selectedObj = "txtQRCode"
    m.txtQRCode.setFocus(true)
end function
function fixQrPosition(msg as object)
    m.qrview.visible = true 
end function
    
sub handleTextEdit(msg)
    m.txtQRCode.text = m.keyboardDialog.text
end sub
sub setUpEditText()
    m.keyboardDialog.textEditBox.secureMode = false
    m.keyboardDialog.keyboardDomain = "email"
    m.keyboardDialog.title = "Text"
    m.keyboardDialog.message = [""]
    m.keyboardDialog.buttons = ["OK"]
    m.keyboardDialog.textEditBox.hintText = "Enter Text ..."
    m.keyboardDialog.text = m.txtQRCode.text
  end sub
sub dismissDialog()
    
    m.keyboardDialog.close=true
    'Revert focus'
    m.txtQRCode.setFocus(true)
    m.keyboardDialog.visible=false
    m.qrview.callfunc("renderQR", m.txtQRCode.text)
    print m.txtQRCode.text
  end sub
  function onKeyEvent(key as String, press as Boolean) as Boolean
    handled = false
    ? " key= "; key; " press= "; press
    if press then
        if key = "down"
          if m.selectedObj = "txtQRCode"
           m.doneButton.setFocus(true)
           m.selectedObj = "btGenerate"
           m.txtQRCode.active=false
          end if
        else if key = "up"
          if m.selectedObj = "btGenerate"
            m.selectedObj = "txtQRCode"
            m.txtQRCode.setFocus(true)
            m.txtQRCode.active=true
          end if
        
        else if key = "OK"
          if m.selectedObj = "txtQRCode"
            setUpEditText()
            m.keyboardDialog.visible=true
            m.keyboardDialog.setFocus(true)
          end if
          
          print "selectedObj= "; m.selectedObj
        end if
    end if
    return handled
end function