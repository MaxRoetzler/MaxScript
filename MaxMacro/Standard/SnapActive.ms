(
	local SnapActive = function SnapActive =
	(
			snapMode.Active = not snapMode.Active;
			--Core.RaiseEvent #OnSnapStateChanged;
	)

	Macro.SnapActive = SnapActive;
)