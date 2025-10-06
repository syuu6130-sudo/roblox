local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "My Custom UI",
   LoadingTitle = "Loading...",
   LoadingSubtitle = "by しゅう",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "MyScript",
      FileName = "Config"
   },
   Discord = {
      Enabled = false,
   },
   KeySystem = false
})

local Tab = Window:CreateTab("Main", 4483362458)

Tab:CreateButton({
   Name = "Click Me",
   Callback = function()
      Rayfield:Notify({
         Title = "反応しました！",
         Content = "このボタンはちゃんと動作してます！",
         Duration = 4,
         Image = 4483362458
      })
   end,
})
