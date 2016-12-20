(
	local Close = function Close =
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

	Macro.Close = Close;
)