macroScript MaxSelectLoop category:"Max Core" buttonText:"Select Loop" toolTip:"Select Loop"
(
	case (Core.Node.GetObjectType ()) of
	(
		#EditPoly: 
		(
			$.Edit_Poly.ButtonOp #SelectEdgeLoop;
		)

		#EditablePoly: 
		(
			$.SelectEdgeLoop ();
		)

		#UnwrapUVW: 
		(
			$.UnwrapUvw.UvLoop 0;
		)
	)
)