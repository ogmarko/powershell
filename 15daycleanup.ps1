Foreach ($element in Dir D:\Outgoing -recurse) { 
	if ($element -is [System.IO.DirectoryInfo]) {
		$last = $element.LastAccessTime
		$timespan = new-timespan -days 15
	
		if (((get-date) - $last) -gt $timespan){
			echo "$last Deleting Outgoing $element"
			Remove-Item $element.Fullname -Force -recurse
		}
	}
}

Foreach ($element in Dir D:\Incoming -recurse) { 
	if ($element -is [System.IO.DirectoryInfo]) {
		$last = $element.LastAccessTime
		$timespan = new-timespan -days 15
	
		if (((get-date) - $last) -gt $timespan){
			echo "$last Deleting Incoming $element"
			Remove-Item $element.Fullname -Force -recurse
		}
	}
}

