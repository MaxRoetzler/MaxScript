macroScript MaxOutline category:"Max Core" buttonText:"Outline" toolTip:"Outline"
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