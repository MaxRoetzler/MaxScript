(
	local PivotCenter = function PivotCenter =
	(
		if (Core.Node.GetObjectType () == #Selection) do
		(
			for node in selection do
			(
				node.Pivot = node.Center;
			)
		)
	)

	Macro.PivotCenter = PivotCenter;
)