macroScript MaxLink category:"Max Core" buttonText:"Link" toolTip:"Link"
(
	if (Core.Node.GetObjectType () == #Selection) do
	(
		local target = PickObject rubberBand:selection.Center;

		if (target != #Escape) do
		(
			selection.Parent = undefined;

			if (target != undefined) do
			(
				for node in selection where (node != target) do
				(
					node.Parent = target;
				)
			)
		)
	)
)