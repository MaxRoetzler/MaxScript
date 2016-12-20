(
	local Outline = function Outline =
	(
		case (Core.Node.GetObjectType ()) of
		(
			#EditPoly:
			(
				$.PopupDialog #Outline;
			)

			#EditablePoly:
			(
				$.Edit_Poly.PopupDialog #Outline;
			)

			#EditableLine: 
			(
				SplineOps.StartOutline $;
			)
		)
	)

	Macro.Outline = Outline;
)