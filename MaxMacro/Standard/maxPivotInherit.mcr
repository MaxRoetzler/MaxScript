macroScript MaxPivotInherit category:"Max Core" buttonText:"Pivot Inherit" toolTip:"Pivot Inherit"
(
	if (Core.Node.GetObjectType () == #Selection) do
	(
		local target = PickObject rubberBand:selection.Center;

		if (IsValidNode target) do
		(
			selection.Pivot = target.Pivot;
		)
	)
)