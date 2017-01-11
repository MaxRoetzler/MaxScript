macroScript MaxBevel category:"Max Core" buttonText:"Bevel" toolTip:"Bevel"
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