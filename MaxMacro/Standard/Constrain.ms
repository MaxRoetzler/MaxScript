(
	local Constrain = function Constrain id =
	(
		case (Core.Node.GetObjectType ()) of
		(
			#EditPoly: 
			(
				with undo off
				(
					$.Edit_Poly.ConstrainType = if ($.Edit_Poly.ConstrainType == id) then 0 else id;
				)
			)

			#EditablePoly: 
			(
				with undo off
				(
					$.ConstrainType = if ($.ConstrainType == id) then 0 else id;
				)
			)
		)
	)

	Macro.Constrain = Constrain;
)