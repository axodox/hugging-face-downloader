# Usage

- Add `Axodox.HuggingFace.Downloader` from Nuget.org to your Visual Studio project.
- Add `huggingface.json` to your project, follow this format to use:

```json
[
  {
    "repository": "axodoxian/realistic_vision_onnx",
    "filter": "tokenizer/*;safety_checker/*.onnx",
    "destination": "realistic_tokenizer"
  },
  {
    "repository": "axodoxian/stable_diffusion_onnx",
    "filter": "*.onnx"
  }
]
```

- When you build your project it will download the models into `$(SolutionDir)/models`. You then can include these files in your build.