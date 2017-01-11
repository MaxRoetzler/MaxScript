macroScript MaxClose category:"Max Core" buttonText:"Close" toolTip:"Close"
(
	case (Core.Node.GetObjectType ()) of
	(
		#EditPoly: 
		(
			$.Edit_Poly.ButtonOp #Cap;
		)

		#EditablePoly: 
		(
			$.ButtonOp #Cap;
		)

		#EditableLine: 
		(
			SplineOps.Close $;
		)
	)
)