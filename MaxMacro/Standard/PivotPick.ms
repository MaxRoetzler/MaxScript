(
	local PivotPick = function PivotPick =
	(
		if (Core.Node.GetObjectType () == #Selection) do
		(
			local snapData = Core.Util.SnapData ();
			Core.Util.SetSnap #(7,1) #Exclusive;

			local target = PickPoint snap:#3D rubberBand:selection.Center;

			if (ClassOf target == Point3) do
			(
				selection.Pivot = target;
			)

			snapData.Reset ();
		)
	)

	Macro.PivotPick = PivotPick;
)