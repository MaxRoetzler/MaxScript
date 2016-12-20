(
	local SelectShrink = function SelectShrink =
	(
		case (Core.Node.GetObjectType ()) of
		(
			#EditPoly: 
			(
				$.Edit_Poly.ButtonOp #ShrinkSelection;
			)

			#EditablePoly: 
			(
				$.ShrinkSelection ();
			)

			#EditableLine: 
			(
				with Redraw off
				(
					case subObjectLevel of
					(
						1 : for i = 1 to (NumSplines $) do SetKnotSelection $ i (Core.Line.ShrinkKnotSelection $ i);
						2 : for i = 1 to (NumSplines $) do SetSegSelection $ i (Core.Line.ShrinkSegmentSelection $ i);
					)
				)

				CompleteRedraw ();
			)

			#UnwrapUVW: 
			(
				$.UnwrapUvw.ContractSelection ();
			)
		)
	)

	Macro.SelectShrink = SelectShrink;
)