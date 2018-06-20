'This script assumes you have already created a new sheet and titled it "Duplicates"
Sub duplicstuff()
Dim t As Single
t = Timer
Dim d As Object, x&, xcol As String
Dim lc&, lr&, k(), e As Range
'Set the column you which do dedupe below. In this example it is set to columb "B"
xcol = "B"
lc = Cells.Find("*", after:=[a1], searchdirection:=xlPrevious).Column
lr = Cells.Find("*", after:=[a1], searchdirection:=xlPrevious).Row
ReDim k(1 To lr, 1 To 1)
Set d = CreateObject("scripting.dictionary")
For Each e In Cells(1, xcol).Resize(lr)
    If Not d.exists(e.Value) Then
        d(e.Value) = 1
        k(e.Row, 1) = 1
    End If
Next e
If d.Count = lr Then
    MsgBox "No duplicates"
    Exit Sub
End If
Cells(1, lc + 1).Resize(lr) = k
Range("A1", Cells(lr, lc + 1)).Sort Cells(1, lc + 1), 1
x = Cells(1, lc + 1).End(4).Row
Cells(x + 1, 1).Resize(lr - x, lc).Copy Sheets("Duplicates").Range("A1")
Cells(x + 1, 1).Resize(lr - x, lc).Clear
Cells(1, lc + 1).Resize(x).Clear
MsgBox "Code took " & Format(Timer - t, "0.00 secs")
MsgBox lr & " rows" & vbLf & lc & " columns" & vbLf & _
    lr - x & " duplicate rows"
End Sub

