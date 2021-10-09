
Sub Macro_Selection_Font_Color_RED()
    Selection.Font.ColorIndex = wdDarkRed
End Sub

Sub Macro_Selection_Font_Color_BLUE()
    Selection.Font.ColorIndex = wdDarkBlue
End Sub

Sub Macro_Selection_Font_Color_BLACK_WHITE_SWITCH()
    If Selection.Font.ColorIndex = wdWhite Then
        Selection.Font.ColorIndex = wdBlack
    Else
        Selection.Font.ColorIndex = wdWhite
    End If
End Sub

Sub Macro_Selection_Highlight_switch()
    If Selection.Range.HighlightColorIndex = wdNoHighlight Then
        Selection.Range.HighlightColorIndex = wdYellow
    Else
        Selection.Range.HighlightColorIndex = wdNoHighlight
    End If
End Sub

Sub Macro_Selection_Double_Strikethrogh()
    Selection.Font.DoubleStrikeThrough = Not Selection.Font.DoubleStrikeThrough
End Sub

Sub Macro_Selection_Set_FontSizeLarge()
    Selection.Font.Size = 32
End Sub

Sub Macro_Selection_Reset()
    Selection.Font.Reset
End Sub

Sub Macro_Selection_Font_Grow()
    Selection.Font.Grow
End Sub

Sub Macro_Selection_Font_Shrink()
    Selection.Font.Shrink
End Sub

Sub Macro_Selection_to_Question_mark()
    Dim length As Integer
    Dim strTemp As String
    strTemp = ""
    length = Len(Selection.Text)
    For i = 1 To length - 1
        strTemp = strTemp + "?"
    Next i
    Selection.Delete
    Selection.InsertAfter (strTemp + " ")
    Selection.MoveRight Unit:=wdCharacter, Count:=1
End Sub
