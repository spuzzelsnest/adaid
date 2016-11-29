#Custom cleanup IMG001


$UserFolders = get-childItem C:\Users\ -Directory
	
		foreach ($folder in $UserFolders){
				
					$path = "c:\Users\"+$folder
					remove-item $path"\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\*" -force -verbose -ErrorAction SilentlyContinue
					Write-Output "Cleaned up Temp Items for "$folder.Name	
		}
		