(
	local SelectGrow = function SelectGrow =
	(
		case (Core.Node.GetObjectType ()) of
		(
			#EditPoly: 
			(
				$.Edit_Poly.ButtonOp #GrowSelection;
			)

			#EditablePoly: 
			(
				$.GrowSelection ();
			)

			#EditableLine: 
			(
				with Redraw off
				(
					case subObjectLevel of
					(
						1 : for i = 1 to (NumSplines $) do SetKnotSelection $ i (Core.Line.GrowKnotSelection $ i);
						2 : for i = 1 to (NumSplines $) do SetSegSelection $ i (Core.Line.GrowSegmentSelection $ i);
					)
				)

				CompleteRedraw ();
			)

			#UnwrapUVW: 
			(
				$.UnwrapUvw.ExpandSelection ();
			)
		)
	)

	Macro.SelectGrow = SelectGrow;
)