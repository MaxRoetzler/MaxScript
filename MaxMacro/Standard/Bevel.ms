(
	local Bevel = function Bevel =
	(
		case (Core.Node.GetObjectType ()) of
		(
			#EditPoly: 
			(
				$.Edit_Poly.PopupDialog #Bevel;
			)

			#EditablePoly: 
			(
				$.PopupDialog #Bevel;
			)

			#EditableLine: 
			(
				SplineOps.StartFillet $;
			)
		)
	)

	Macro.Bevel = Bevel;
)