(
	local CoordSystemCycle = function CoordSystemCycle =
	(
		case (GetRefCoordSys()) of
		(
			Default: SetRefCoordSys #Hybrid;
			#Hybrid: SetRefCoordSys #Local;
			#Local:	 SetRefCoordSys #Hybrid;
		)

		--Core.RaiseEvent #OnCoordSysChanged;
	)

	Macro.CoordSystemCycle = CoordSystemCycle;
)