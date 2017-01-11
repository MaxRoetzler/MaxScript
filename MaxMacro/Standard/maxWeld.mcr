macroScript MaxWeld category:"Max Core" buttonText:"Weld" toolTip:"Weld"
(
	case (Core.Node.GetObjectType ()) of
	(
		#EditPoly: 
		(
			if (subObjectLevel == 1) then
			(
				$.Edit_Poly.WeldVertexThreshold = 1e-3;
				$.Edit_Poly.ButtonOp #WeldVertex;
			)
			else if (subObjectLevel == 2 or subObjectLevel == 3) do
			(
				$.Edit_Poly.WeldEdgeThreshold = 1e-4;
				$.Edit_Poly.ButtonOp #WeldEdge;
			)
		)

		#EditablePoly: 
		(
			$.WeldThreshold = 1e-3;
			$.ButtonOp #WeldSelected;
		)

		#EditableLine: 
		(
			WeldSpline $ 1e-3;
		)

		#UnwrapUVW: 
		(
			$.UnwrapUvw.WeldSelectedShared ();
		)
	)
)