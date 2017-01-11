macroScript MaxCoordSystemCycle category:"Max Core" buttonText:"Coord System Cycle" toolTip:"Coord System Cycle"
(
	case (GetRefCoordSys()) of
	(
		Default: SetRefCoordSys #Hybrid;
		#Hybrid: SetRefCoordSys #Local;
		#Local:	 SetRefCoordSys #Hybrid;
	)

	--Core.RaiseEvent #OnCoordSysChanged;
)