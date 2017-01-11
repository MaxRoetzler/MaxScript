macroScript MaxMaterialReset category:"Max Core" buttonText:"Material Reset" toolTip:"Material Reset"
(
	if (Core.Node.GetObjectType () == #Selection) do
	(
		for node in selection do
		(
			node.Material = undefined;
		)
	)
)