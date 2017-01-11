macroScript MaxReplace category:"Max Core" buttonText:"Replace" toolTip:"Replace"
(
	if (Core.Node.GetObjectType () == #Selection) do
	(
		local target = PickObject rubberBand:selection.Center;

		case target of
		(
			Default		: InstanceReplace selection target;
			undefined	: InstanceMgr.MakeObjectsUnique selection #Group;
		)
	)
)