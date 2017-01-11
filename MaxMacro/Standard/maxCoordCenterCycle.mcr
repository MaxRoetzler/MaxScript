macroScript MaxCoordCenterCycle category:"Max Core" buttonText:"Coord Center Cycle" toolTip:"Coord Center Cycle"
(
	case (GetCoordCenter ()) of
	(
		Default: 	SetCoordCenter #Local;
		#Selection: SetCoordCenter #Local;
		#Local: 	SetCoordCenter #Selection;
	)
)