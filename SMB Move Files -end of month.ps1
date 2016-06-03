$RootDir = "H:\SQL_Backups"
$WeeklyDir = "$RootDir\Weekly"
$myDate = "*201602*"

$myBaseDirList = gci -path "$WeeklyDir" | ?{ $_.PSIsContainer }

foreach ($myBaseDir in $myBaseDirList)
{
	$myDirList = gci -path "$WeeklyDir\$myBaseDir" | ?{ $_.PSIsContainer }
	foreach ($myDir in $myDirList)
	{		
		$myFiles = gci -path "$WeeklyDir\$myBaseDir\$myDir\$myDate" | Sort-Object LastAccessTime | Select-Object -First 1
		foreach ($myFile in $myFiles)
		{
			$myDestination = $myFile.Directory -replace "Weekly", "Monthly"
			New-Item -ErrorAction Ignore -ItemType Directory -Force -Path $myDestination
			Write-Host $myFile "$myDestination"
			move-item -path $myFile -destination "$myDestination"
		}
	}
}
