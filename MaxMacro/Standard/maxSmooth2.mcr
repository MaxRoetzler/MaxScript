macroScript MaxSmooth2 category:"Max Core" buttonText:"Smooth ID-2" toolTip:"Smooth ID-2"
(
	case (Core.Node.GetObjectType ()) of
	(
		#EditPoly:
		(
			$.Edit_Poly.SetOperation #SetSmooth;
			$.Edit_Poly.SmoothingGroupsToSet = (2 ^ 1);
		)

		#EditablePoly:
		(
			local faces = Core.Poly.GetSelectionAsFace $;
			polyOp.SetFaceSmoothGroup $ faces (2 ^ 1);
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
						SetKnotType $ spline knot #Bezier;
					)
				)
			)

			UpdateShape $;
			CompleteRedraw ();
		)
	)
)