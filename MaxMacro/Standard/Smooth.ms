(
	local Smooth = function Smooth id =
	(
		case (Core.Node.GetObjectType ()) of
		(
			#EditPoly:
			(
				id = if (id == 0) then -2 else id - 1;

				$.Edit_Poly.SetOperation #SetSmooth;
				$.Edit_Poly.SmoothingGroupsToSet = (2 ^ id);
			)

			#EditablePoly:
			(
				local faces = Core.Poly.GetSelectionAsFace $;
				id = if (id == 0) then -2 else id - 1;

				polyOp.SetFaceSmoothGroup $ faces (2 ^ id);
			)

			#EditableLine: 
			(
				with redraw off
				(
					local knots;
					local type;

					case id of
					(
						0 : type = #Corner;
						1 : type = #Smooth;
						2 : type = #Bezier;
						3 : type = #BezierCorner;
					)

					for spline = 1 to (NumSplines $) do
					(
						knots = Core.Line.GetSelectionAsKnot $ spline;

						for knot in knots do
						(
							SetKnotType $ spline knot type;
						)
					)
				)

				UpdateShape $;
				CompleteRedraw ();
			)
		)
	)

	Macro.Smooth = Smooth;
)