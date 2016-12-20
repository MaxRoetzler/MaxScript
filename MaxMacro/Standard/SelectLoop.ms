(
	local SelectLoop = function SelectLoop =
	(
		case (Core.Node.GetObjectType ()) of
		(
			#EditPoly: 
			(
				$.Edit_Poly.ButtonOp #SelectEdgeLoop;
			)

			#EditablePoly: 
			(
				$.SelectEdgeLoop ();
			)

			#UnwrapUVW: 
			(
				$.UnwrapUvw.UvLoop 0;
			)
		)
	)

	Macro.SelectLoop = SelectLoop;
)