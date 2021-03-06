macroScript MaxConnect category:"Max Core" buttonText:"Connect" toolTip:"Connect"
(
	case (Core.Node.GetObjectType ()) of
	(
		#EditPoly: 
		(
			case subObjectLevel of
			(
				1 : $.Edit_Poly.ButtonOp #ConnectVertices;
				2 : $.Edit_Poly.PopupDialog #ConnectEdges;
			)
		)

		#EditablePoly: 
		(
			if (subObjectLevel == 1) then
			(
				$.ConnectVertices ();
			)
			else if (subObjectLevel == 2) then
			(
				$.PopupDialog #ConnectEdges;
			)
			else if (subObjectLevel > 2) do
			(
				local snapData = Core.Util.SnapData ();
				local verts = Core.Poly.GetSelectionAsVertex $;
				local center = Core.Poly.CalculateWeightedCenter $ verts:verts;

				Core.Util.SetSnap #(7, 1) #Exclusive;

				local master = undefined;
				local target = PickPoint snap:#3D rubberBand:center;

				if (ClassOf target == Point3) do
				(
					for vert in verts while (master == undefined) do
					(
						if (Length (polyOp.GetVert $ vert - target) < 1e-3) do
						(
							master = vert;
						)
					)
				)

				if (master != undefined) then
				(
					for vert in verts do 
					(
						polyOp.CreateEdge $ vert master;
					)
				)

				snapData.Reset ();
			)
		)

		#EditableLine: 
		(
			with Redraw off
			(
				if (subObjectLevel == 1) do
				(
					local count = 0;
					local knots = #();
					local total = NumSplines $;

					for spline = 1 to total do
					(
						for knot in (GetKnotSelection $ spline) while (count < 3) do
						(
							Append knots (GetKnotPoint $ spline knot);
							count += 1;
						)
					) -- End collect selected knots.

					if (count == 2) do
					(
						local index = total + 1;

						AddNewSpline $;

						AddKnot $ index #Smooth #Curve knots[1];
						AddKnot $ index #Smooth #Curve knots[2];

						UpdateShape $;
					)
				)
			)

			CompleteRedraw ();
		)
	)
)