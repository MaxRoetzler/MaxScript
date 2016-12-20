(
	local Inset = function Inset =
	(
		case (Core.Node.GetObjectType ()) of
		(
			#EditPoly: 
			(
				if (subObjectLevel > 3) do
				(
					$.Edit_Poly.PopupDialog #Inset;
				)
			)

			#EditablePoly: 
			(
				if (subObjectLevel > 3) do
				(
					$.PopupDialog #Inset;
				)
			)
		)
	)

	Macro.Inset = Inset;
)