macroScript MaxConstrainNormal category:"Max Core" buttonText:"Constrain Normal" toolTip:"Constrain Normal"
(
	case (Core.Node.GetObjectType ()) of
	(
		#EditPoly: 
		(
			with undo off
			(
				$.Edit_Poly.ConstrainType = if ($.Edit_Poly.ConstrainType == 3) then 0 else 3;
			)
		)

		#EditablePoly: 
		(
			with undo off
			(
				$.ConstrainType = if ($.ConstrainType == 3) then 0 else 3;
			)
		)
	)
)