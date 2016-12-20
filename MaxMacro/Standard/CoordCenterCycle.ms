(
	local CoordCenterCycle = function CoordCenterCycle =
	(
		case (GetCoordCenter ()) of
		(
			Default: 	SetCoordCenter #Local;
			#Selection: SetCoordCenter #Local;
			#Local: 	SetCoordCenter #Selection;
		)
	)

	Macro.CoordCenterCycle = CoordCenterCycle;
)