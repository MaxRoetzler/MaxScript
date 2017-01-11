macroScript MaxSelectRing category:"Max Core" buttonText:"Select Ring" toolTip:"Select Ring"
(
	case (Core.Node.GetObjectType ()) of
	(
		#EditPoly: 
		(
			$.Edit_Poly.ButtonOp #SelectEdgeRing;
		)

		#EditablePoly: 
		(
			$.SelectEdgeRing ();
		)

		#UnwrapUVW: 
		(
			$.UnwrapUvw.UvRing 0;
		)
	)
)