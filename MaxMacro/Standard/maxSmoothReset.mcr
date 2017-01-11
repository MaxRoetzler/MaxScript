macroScript MaxSmoothReset category:"Max Core" buttonText:"Smooth Reset" toolTip:"Smooth Reset"
(
	case (Core.Node.GetObjectType ()) of
	(
		#EditPoly:
		(
			$.Edit_Poly.SetOperation #SetSmooth;
			$.Edit_Poly.SmoothingGroupsToSet = 0;
		)

		#EditablePoly:
		(
			local faces = Core.Poly.GetSelectionAsFace $;
			polyOp.SetFaceSmoothGroup $ faces 0;
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
						SetKnotType $ spline knot #Corner;
					)
				)
			)

			UpdateShape $;
			CompleteRedraw ();
		)
	)
)