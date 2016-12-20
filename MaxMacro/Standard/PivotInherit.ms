(
	local PivotInherit = function PivotInherit =
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

	Macro.PivotInherit = PivotInherit;
)