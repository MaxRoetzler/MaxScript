macroScript MaxDivide category:"Max Core" buttonText:"Divide" toolTip:"Divide"
(
	case (Core.Node.GetObjectType ()) of
	(
		#EditPoly: 
		(
			if (subObjectLevel == 2 or subObjectLevel == 3) do
			(
				local edges = $.Edit_Poly.GetSelection #Edge;

				for edge in edges do
				(
					$.Edit_Poly.DivideEdge edge 0.5;
				)
			)
		)

		#EditablePoly: 
		(
			if (subObjectLevel == 2 or subObjectLevel == 3) then
			(
				$.connectEdgeSegments = 1;
				$.ConnectEdges ();
			)
			else if (subObjectLevel == 4) do
			(
				$.Tessellate #Face;
			)
		)

		#EditableLine: 
		(
			SplineOps.Divide $;
		)
	)
)