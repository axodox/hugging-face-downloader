param($config, $destination)

# -config ./huggingface.json -destination ./models/manager

New-Item -ItemType Directory -Force -Path $destination | Out-Null

$tasks = Get-Content $config | ConvertFrom-Json

foreach ($task in $tasks) {
  
  $destinationFolder = $destination + '/'
  if ($task.PSobject.Properties.Name -contains "destination") {
    $destinationFolder += $task.destination
  }
  else {
    $destinationFolder += $task.repository
  }

  ./Download-HuggingFaceModel.ps1 -repository "$($task.repository)" -patterns "$($task.filter)" -destination "$destinationFolder"
}
