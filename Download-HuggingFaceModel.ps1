param($repository, $patterns, $destination)

# -repository "axodoxian/realistic_vision_onnx" -patterns "tokenizer/*;safety_checker/*.onnx" -destination "D:\dev\hugging_face_downloader\models"

Write-Host "Fetching $repository manifest from HuggingFace..."
$modelInfo = Invoke-WebRequest -Uri "https://huggingface.co/api/models/$repository" | ConvertFrom-Json
$patterns = $patterns.Split(';')

$ProgressPreference = 'SilentlyContinue'
foreach ($fileref in $modelInfo.siblings) {
  $filename = $fileref.rfilename

  $copyFile = $false
  foreach ($pattern in $patterns) {
    if ($filename -like $pattern) {
      $copyFile = $true 
    }
  }

  if ($copyFile) {
    Write-Host "Verifying $filename..."

    $destinationFile = "$destination/$filename" 

    if(Test-Path $destinationFile) {
      Write-Host "Skipping $filename as it already exists."
      continue 
    }

    Write-Host "Downloading $filename..."

    $destinationFolder = Split-Path -Path $destinationFile -Parent
    New-Item -ItemType Directory -Force -Path $destinationFolder | Out-Null
    
    Invoke-WebRequest -Uri "https://huggingface.co/$repository/resolve/main/$filename" -OutFile $destinationFile    
  } 
}

Write-Host "Done."
