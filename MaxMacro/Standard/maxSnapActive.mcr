macroScript MaxSnapActive category:"Max Core" buttonText:"Snap Active" toolTip:"Snap Active"
(
		snapMode.Active = not snapMode.Active;
		--Core.RaiseEvent #OnSnapStateChanged;
)