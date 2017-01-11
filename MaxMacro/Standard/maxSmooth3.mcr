macroScript MaxSmooth3 category:"Max Core" buttonText:"Smooth ID-3" toolTip:"Smooth ID-3"
(
	case (Core.Node.GetObjectType ()) of
	(
		#EditPoly:
		(
			$.Edit_Poly.SetOperation #SetSmooth;
			$.Edit_Poly.SmoothingGroupsToSet = (2 ^ 2);
		)

		#EditablePoly:
		(
			local faces = Core.Poly.GetSelectionAsFace $;
			polyOp.SetFaceSmoothGroup $ faces (2 ^ 2);
		)

		#EditableLine: 
		(
			with redraw off
			(
				local knots;

				for spline = 1 to (NumSplines $) do
				(
					knots = Core.Line.GetSelectionAsKnot $ spline;

					for knot in knots do
					(
						SetKnotType $ spline knot #BezierCorner;
					)
				)
			)

			UpdateShape $;
			CompleteRedraw ();
		)
	)
)