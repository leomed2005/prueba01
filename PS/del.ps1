$Server2 = (Get-Content SrvLogs.txt)
$NumDays = 7
$CurDate = get-date
$TestDate = $Curdate.AddDays(-$NumDays)

$strData = "Files deleted from: " + $Server2 + " on " + $CurDate     

get-childitem -path $Server2 -recurse | foreach { 
    If ($_.LastWriteTime -lt $TestDate) 
    { 
        $strData = "File to delete: " + $_.FullName + " " + $_.LastWriteTime 
        
        $strData | out-file "DeletedFiles.log" -Append
        If ($_.GetType().Name -eq "FileInfo") {
            $_.Delete()
        } else {
            $_.Delete($true)
        }
   }
}