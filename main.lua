local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/.../Rayfield.lua"))()

local Window = Rayfield:CreateWindow({
	Name = "物人 データ版",
	LoadingTitle = "読み込み中...",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = nil,
		FileName = "OreMonoConfig"
	},
	KeySystem = false,
})

-- ボタンの例
local Tab = Window:CreateTab("操作")
local Section = Tab:CreateSection("動作")

Section:CreateButton({
	Name = "飛ぶ",
	Callback = function()
		print("飛ぶボタン押した")
		-- ここにExecutor版の飛ぶ処理を入れる
	end
})

Section:CreateSlider({
	Name = "移動速度",
	Range = {16, 200},
	Increment = 1,
	Suffix = "studs/s",
	CurrentValue = 16,
	Flag = "SpeedSlider",
	Callback = function(value)
		print("速度変更:", value)
		-- プレイヤーの移動速度を変更
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
	end
})
