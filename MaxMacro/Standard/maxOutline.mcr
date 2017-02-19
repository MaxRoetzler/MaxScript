macroScript MaxOutline category:"Max Core" buttonText:"Outline" toolTip:"Outline"
(
	case (Core.Node.GetObjectType ()) of
	(
		#EditPoly:
		(
			$.Edit_Poly.PopupDialog #Outline;
		)

		#EditablePoly:
		(
			$.PopupDialog #Outline;
		)

		#EditableLine: 
		(
			SplineOps.StartOutline $;
		)
	)
)