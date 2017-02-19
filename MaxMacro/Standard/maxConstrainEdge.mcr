macroScript MaxConstrainEdge category:"Max Core" buttonText:"Constrain Edge" toolTip:"Constrain Edge"
(
	case (Core.Node.GetObjectType ()) of
	(
		#EditPoly: 
		(
			with undo off
			(
				$.Edit_Poly.ConstrainType = if ($.Edit_Poly.ConstrainType == 1) then 0 else 1;
			)
		)

		#EditablePoly: 
		(
			with undo off
			(
				$.ConstrainType = if ($.ConstrainType == 1) then 0 else 1;
			)
		)
	)
)