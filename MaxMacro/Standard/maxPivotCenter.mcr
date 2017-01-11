macroScript MaxPivotCenter category:"Max Core" buttonText:"Pivot Center" toolTip:"Pivot Center"
(
	if (Core.Node.GetObjectType () == #Selection) do
	(
		for node in selection do
		(
			node.Pivot = node.Center;
		)
	)
)